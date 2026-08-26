#!/bin/sh
echo "=== www A ==="
dig +short www.oilmoguls.com A @8.8.8.8
echo "=== https www ==="
curl -sI -m 15 https://www.oilmoguls.com | head -n 15
echo "=== https apex routes ==="
for p in / /academy /join
do
  echo -n "$p "
  curl -s -o /dev/null -m 15 -w "%{http_code} %{ssl_verify_result}\n" "https://oilmoguls.com$p"
done
