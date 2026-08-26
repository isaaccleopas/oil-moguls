#!/bin/sh
set -e
echo "=== requesting cert ==="
docker exec npm-app-1 sh -c "mkdir -p /data/letsencrypt-acme-challenge"
if docker exec npm-app-1 certbot certonly --webroot -w /data/letsencrypt-acme-challenge --non-interactive --agree-tos --email loavesmedia@gmail.com -d oilmoguls.com -d www.oilmoguls.com; then
  echo CERT_OK_BOTH
else
  echo "www failed, retrying apex only"
  docker exec npm-app-1 certbot certonly --webroot -w /data/letsencrypt-acme-challenge --non-interactive --agree-tos --email loavesmedia@gmail.com -d oilmoguls.com
  echo CERT_OK_APEX
fi
python3 /root/batcave/nmdpra/oil_moguls/scripts/write_tls_conf.py
if ! docker exec npm-app-1 nginx -t; then
  echo "nginx test failed; rewriting without force-ssl"
  python3 - <<'PY'
from pathlib import Path
p = Path("/root/npm/data/nginx/proxy_host/34.conf")
p.write_text(p.read_text().replace("  include conf.d/include/force-ssl.conf;\n", ""))
print("stripped force-ssl")
PY
  docker exec npm-app-1 nginx -t
fi
docker exec npm-app-1 nginx -s reload
echo "=== https oilmoguls.com ==="
curl -sI -m 15 https://oilmoguls.com | head -n 20
echo "=== cert names ==="
echo | openssl s_client -servername oilmoguls.com -connect oilmoguls.com:443 2>/dev/null | openssl x509 -noout -subject -ext subjectAltName
