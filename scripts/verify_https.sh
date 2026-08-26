#!/bin/sh
echo "=== 34.conf ==="
cat /root/npm/data/nginx/proxy_host/34.conf
echo "=== cert files in npm ==="
docker exec npm-app-1 ls -l /etc/letsencrypt/live/oilmoguls.com/
echo "=== nginx test reload ==="
docker exec npm-app-1 nginx -t
docker exec npm-app-1 nginx -s reload
echo "=== curl https verbose ==="
curl -sI -m 20 https://oilmoguls.com
echo "=== curl https insecure ==="
curl -skI -m 20 https://oilmoguls.com
echo "=== openssl ==="
echo | openssl s_client -servername oilmoguls.com -connect 85.17.145.58:443 2>/dev/null | openssl x509 -noout -subject -issuer -ext subjectAltName
echo "=== http now ==="
curl -sI -m 15 http://oilmoguls.com | head -n 15
