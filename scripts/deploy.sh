#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

if [ ! -f .env ]; then
  echo "missing .env" >&2
  exit 1
fi

echo "==> building oil_moguls"
docker compose up -d --build
docker image prune -f >/dev/null
echo "==> health"
curl -sS -o /dev/null -w "loopback HTTP %{http_code}\n" http://127.0.0.1:4770/ || true
docker ps --filter name=oil_moguls --format '{{.Names}} {{.Status}}'
