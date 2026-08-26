import sqlite3

c = sqlite3.connect("/root/npm/data/database.sqlite")
print("--- schema proxy_host ---")
for row in c.execute("PRAGMA table_info(proxy_host)"):
    print(row)
print("--- host 33 ---")
print(c.execute("select * from proxy_host where id=33").fetchone())
print("--- host 26 ---")
print(
    c.execute(
        "select id, domain_names, forward_host, forward_port, certificate_id, ssl_forced from proxy_host where id=26"
    ).fetchone()
)
print("--- max id ---")
print(c.execute("select max(id) from proxy_host").fetchone())
print("--- certificates ---")
for row in c.execute("select id, nice_name, domain_names from certificate where is_deleted=0"):
    print(row)
