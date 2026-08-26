#!/usr/bin/env bash
# Public team preview on the ApexBee VPS via sslip.io (no extra DNS panel).
set -euo pipefail

APP=/root/batcave/nmdpra/oil_moguls
HOST=oilmoguls.85.17.145.58.sslip.io
cd "$APP"

python3 - <<'PY'
from pathlib import Path
host = "oilmoguls.85.17.145.58.sslip.io"
p = Path(".env")
text = p.read_text()
lines = []
seen_host = seen_origins = False
for line in text.splitlines():
    if line.startswith("PHX_HOST="):
        lines.append("PHX_HOST=" + host)
        seen_host = True
    elif line.startswith("PHX_CHECK_ORIGINS="):
        lines.append("PHX_CHECK_ORIGINS=" + host)
        seen_origins = True
    else:
        lines.append(line)
if not seen_host:
    lines.append("PHX_HOST=" + host)
if not seen_origins:
    lines.append("PHX_CHECK_ORIGINS=" + host)
p.write_text("\n".join(lines) + "\n")
print("updated PHX_HOST")
PY

docker compose up -d
curl -sS -o /dev/null -w "loopback %{http_code}\n" http://127.0.0.1:4770/

python3 "$APP/scripts/add_npm_host.py"
docker exec npm-app-1 nginx -s reload

echo "==> requesting TLS certificate"
docker exec npm-app-1 sh -c "ls /data/letsencrypt-acme-challenge >/dev/null 2>&1 || mkdir -p /data/letsencrypt-acme-challenge"
set +e
docker exec npm-app-1 certbot certonly --webroot \
  -w /data/letsencrypt-acme-challenge \
  --non-interactive --agree-tos --register-unsafely-without-email \
  -d "$HOST"
CERT_OK=$?
set -e

if [ "$CERT_OK" -eq 0 ]; then
  python3 - <<'PY'
from pathlib import Path
host = "oilmoguls.85.17.145.58.sslip.io"
# find the npm host id from the conf files
conf_dir = Path("/root/npm/data/nginx/proxy_host")
target = None
for path in conf_dir.glob("*.conf"):
    text = path.read_text(errors="ignore")
    if host in text:
        target = path
        break
if not target:
    raise SystemExit("proxy conf not found")
host_id = target.stem
conf = f"""# ------------------------------------------------------------
# {host}
# ------------------------------------------------------------

server {{
  set $forward_scheme http;
  set $server         "oil_moguls";
  set $port           4760;

  listen 80;
  listen [::]:80;
  listen 443 ssl;
  listen [::]:443 ssl;

  server_name {host};

  include conf.d/include/letsencrypt-acme-challenge.conf;
  include conf.d/include/ssl-cache.conf;
  include conf.d/include/ssl-ciphers.conf;
  ssl_certificate /etc/letsencrypt/live/{host}/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/{host}/privkey.pem;

  include conf.d/include/force-ssl.conf;
  include conf.d/include/block-exploits.conf;

  proxy_set_header Upgrade $http_upgrade;
  proxy_set_header Connection $http_connection;
  proxy_http_version 1.1;

  access_log /data/logs/proxy-host-{host_id}_access.log proxy;
  error_log /data/logs/proxy-host-{host_id}_error.log warn;

  location / {{
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $http_connection;
    proxy_http_version 1.1;
    include conf.d/include/proxy.conf;
  }}

  include /data/nginx/custom/server_proxy[.]conf;
}}
"""
    target.write_text(conf)
    print("wrote tls conf", target)
PY
  docker exec npm-app-1 nginx -s reload
  echo "==> preview https://$HOST"
else
  echo "certbot failed; HTTP proxy is still up at http://$HOST"
fi

curl -sS -o /dev/null -w "public %{http_code} %{url_effective}\n" -L --max-redirs 3 "http://$HOST/" || true
