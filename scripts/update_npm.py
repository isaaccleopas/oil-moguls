#!/usr/bin/env python3
"""Point Nginx Proxy Manager at the static Oil Moguls container on port 80."""

import sqlite3
from datetime import datetime, timezone
from pathlib import Path

DB = "/root/npm/data/database.sqlite"
CONF33 = Path("/root/npm/data/nginx/proxy_host/33.conf")
CONF34 = Path("/root/npm/data/nginx/proxy_host/34.conf")
SRC34 = Path("/root/batcave/nmdpra/oil_moguls/scripts/34.conf")


def now():
    return datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S")


def main():
    conf33 = CONF33.read_text()
    conf33 = conf33.replace("set $port           4760;", "set $port           80;")
    CONF33.write_text(conf33)

    if SRC34.exists():
        CONF34.write_text(SRC34.read_text())

    conn = sqlite3.connect(DB)
    conn.row_factory = sqlite3.Row
    conn.execute(
        "UPDATE proxy_host SET forward_port = 80, modified_on = ? WHERE id = 33 AND is_deleted = 0",
        (now(),),
    )
    existing = conn.execute(
        "SELECT id FROM proxy_host WHERE domain_names LIKE '%oilmoguls.com%' AND is_deleted = 0"
    ).fetchone()
    if existing:
        conn.execute(
            "UPDATE proxy_host SET forward_host = 'oil_moguls', forward_port = 80, forward_scheme = 'http', modified_on = ? WHERE id = ?",
            (now(), existing["id"]),
        )
        print(f"updated existing oilmoguls.com host id={existing['id']}")
    else:
        row33 = conn.execute("SELECT * FROM proxy_host WHERE id = 33").fetchone()
        cols = [k for k in row33.keys() if k != "id"]
        values = {k: row33[k] for k in cols}
        values["created_on"] = now()
        values["modified_on"] = now()
        values["domain_names"] = '["oilmoguls.com","www.oilmoguls.com"]'
        values["forward_host"] = "oil_moguls"
        values["forward_port"] = 80
        values["forward_scheme"] = "http"
        values["certificate_id"] = 0
        values["ssl_forced"] = 0
        values["hsts_enabled"] = 0
        values["hsts_subdomains"] = 0
        values["http2_support"] = 0
        values["allow_websocket_upgrade"] = 0
        values["enabled"] = 1
        values["advanced_config"] = ""
        placeholders = ",".join("?" for _ in cols)
        conn.execute(
            f"INSERT INTO proxy_host ({','.join(cols)}) VALUES ({placeholders})",
            [values[k] for k in cols],
        )
        new_id = conn.execute("SELECT last_insert_rowid()").fetchone()[0]
        print(f"inserted oilmoguls.com host id={new_id}")
        if new_id != 34:
            dest = Path(f"/root/npm/data/nginx/proxy_host/{new_id}.conf")
            text = CONF34.read_text().replace("proxy-host-34", f"proxy-host-{new_id}")
            dest.write_text(text)
            print(f"wrote {dest}")
    conn.commit()
    print("33 port:")
    print(conn.execute("SELECT id, domain_names, forward_port FROM proxy_host WHERE id=33").fetchone())
    print("oilmoguls.com hosts:")
    for row in conn.execute(
        "SELECT id, domain_names, forward_host, forward_port, certificate_id FROM proxy_host WHERE domain_names LIKE '%oilmoguls%' AND is_deleted=0"
    ):
        print(tuple(row))
    conn.close()


if __name__ == "__main__":
    main()
