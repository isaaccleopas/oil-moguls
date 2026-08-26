#!/bin/sh
set -e
echo "=== 34.conf ==="
cat /root/npm/data/nginx/proxy_host/34.conf
echo "=== Host oilmoguls.com @ npm :80 ==="
curl -sI -m 10 -H "Host: oilmoguls.com" http://127.0.0.1 || echo "FAIL oilmoguls.com"
echo "=== Host www.oilmoguls.com @ npm :80 ==="
curl -sI -m 10 -H "Host: www.oilmoguls.com" http://127.0.0.1 || echo "FAIL www"
echo "=== spa /academy ==="
curl -skI https://oilmoguls.85.17.145.58.sslip.io/academy
echo "=== spa /join ==="
curl -skI https://oilmoguls.85.17.145.58.sslip.io/join
echo "=== public http oilmoguls.com ==="
curl -sI -m 15 http://oilmoguls.com || echo "FAIL public http"
echo "=== public https oilmoguls.com ==="
curl -skI -m 15 https://oilmoguls.com || echo "FAIL public https"
echo "=== js bundle apexbee ==="
JS=$(curl -sk https://oilmoguls.85.17.145.58.sslip.io/ | grep -oE '/assets/[^"]+\.js' | head -n 1)
echo "JS=$JS"
curl -sk "https://oilmoguls.85.17.145.58.sslip.io$JS" | grep -o "apexbeeapp.com" | head -n 3
