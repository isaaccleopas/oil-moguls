from pathlib import Path

path = Path("/root/npm/data/nginx/proxy_host/34.conf")
path.write_text(
    """# ------------------------------------------------------------
# oilmoguls.com
# ------------------------------------------------------------

server {
  set $forward_scheme http;
  set $server         "oil_moguls";
  set $port           80;

  listen 80;
  listen [::]:80;
  listen 443 ssl;
  listen [::]:443 ssl;

  server_name oilmoguls.com www.oilmoguls.com;

  include conf.d/include/letsencrypt-acme-challenge.conf;
  include conf.d/include/ssl-cache.conf;
  include conf.d/include/ssl-ciphers.conf;
  ssl_certificate /etc/letsencrypt/live/oilmoguls.com/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/oilmoguls.com/privkey.pem;

  include conf.d/include/block-exploits.conf;
  include conf.d/include/force-ssl.conf;

  proxy_set_header Upgrade $http_upgrade;
  proxy_set_header Connection $http_connection;
  proxy_http_version 1.1;

  access_log /data/logs/proxy-host-34_access.log proxy;
  error_log /data/logs/proxy-host-34_error.log warn;

  location / {
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $http_connection;
    proxy_http_version 1.1;
    include conf.d/include/proxy.conf;
  }

  include /data/nginx/custom/server_proxy[.]conf;
}
"""
)
print("wrote", path)
