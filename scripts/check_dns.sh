#!/bin/sh
echo "=== auth NS ==="
dig +short oilmoguls.com A @artemis.dns-parking.com
echo "=== google ==="
dig +short oilmoguls.com A @8.8.8.8
echo "=== www ==="
dig +short www.oilmoguls.com A @8.8.8.8
echo "=== http to vps with host ==="
curl -sI -m 10 -H "Host: oilmoguls.com" http://85.17.145.58 | head -n 12
echo "=== public http oilmoguls.com ==="
curl -sI -m 15 http://oilmoguls.com | head -n 15
echo "=== public https oilmoguls.com ==="
curl -skI -m 15 https://oilmoguls.com | head -n 15
echo "=== 34.conf ==="
grep -E "listen|server_name|ssl_certificate|set .port" /root/npm/data/nginx/proxy_host/34.conf
