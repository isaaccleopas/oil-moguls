#!/usr/bin/env python3
"""Register oilmoguls.avrininnovations.com on Nginx Proxy Manager."""

from __future__ import annotations

import json
import sqlite3
from datetime import datetime, timezone
from pathlib import Path

DB = Path("/root/npm/data/database.sqlite")
CONF_DIR = Path("/root/npm/data/nginx/proxy_host")
DOMAIN = "oilmoguls.85.17.145.58.sslip.io"
FORWARD_HOST = "oil_moguls"
FORWARD_PORT = 4760


def utcnow() -> str:
    return datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S")


def main() -> None:
    conn = sqlite3.connect(DB)
    conn.row_factory = sqlite3.Row
    for row in conn.execute(
        "SELECT id, domain_names FROM proxy_host WHERE is_deleted = 0"
    ):
        names = json.loads(row["domain_names"])
        if DOMAIN in names:
            print("proxy host already exists id=%s" % row["id"])
            write_conf(row["id"], ssl=row_has_ssl(conn, row["id"]))
            return

    template = conn.execute("SELECT * FROM proxy_host WHERE id = 32").fetchone()
    if template is None:
        template = conn.execute("SELECT * FROM proxy_host WHERE id = 26").fetchone()
    cols = [k for k in template.keys() if k != "id"]
    values = {k: template[k] for k in cols}
    values.update(
        {
            "created_on": utcnow(),
            "modified_on": utcnow(),
            "domain_names": json.dumps([DOMAIN]),
            "forward_host": FORWARD_HOST,
            "forward_port": FORWARD_PORT,
            "certificate_id": 0,
            "ssl_forced": 0,
            "caching_enabled": 0,
            "block_exploits": 1,
            "advanced_config": "",
            "allow_websocket_upgrade": 1,
            "http2_support": 0,
            "forward_scheme": "http",
            "enabled": 1,
            "hsts_enabled": 0,
            "hsts_subdomains": 0,
        }
    )
    conn.execute(
        "INSERT INTO proxy_host (%s) VALUES (%s)"
        % (", ".join(cols), ", ".join("?" for _ in cols)),
        [values[c] for c in cols],
    )
    conn.commit()
    host_id = conn.execute("SELECT last_insert_rowid()").fetchone()[0]
    write_conf(host_id, ssl=False)
    print("created proxy host id=%s for %s -> %s:%s" % (host_id, DOMAIN, FORWARD_HOST, FORWARD_PORT))


def row_has_ssl(conn: sqlite3.Connection, host_id: int) -> bool:
    row = conn.execute(
        "SELECT certificate_id FROM proxy_host WHERE id = ?", (host_id,)
    ).fetchone()
    return bool(row and row["certificate_id"] and row["certificate_id"] > 0)


def write_conf(host_id: int, ssl: bool) -> None:
    ssl_block = ""
    if ssl:
        ssl_block = """
  listen 443 ssl;
  listen [::]:443 ssl;
  include conf.d/include/ssl-cache.conf;
  include conf.d/include/ssl-ciphers.conf;
  ssl_certificate /etc/letsencrypt/live/npm-{cert}/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/npm-{cert}/privkey.pem;
""".replace("{cert}", "PLACEHOLDER")

    conf = f"""# ------------------------------------------------------------
# {DOMAIN}
# ------------------------------------------------------------

server {{
  set $forward_scheme http;
  set $server         "{FORWARD_HOST}";
  set $port           {FORWARD_PORT};

  listen 80;
  listen [::]:80;
{ssl_block}
  server_name {DOMAIN};

  include conf.d/include/letsencrypt-acme-challenge.conf;
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
    path = CONF_DIR / ("%s.conf" % host_id)
    path.write_text(conf, encoding="utf-8")
    print("wrote %s" % path)


if __name__ == "__main__":
    main()
