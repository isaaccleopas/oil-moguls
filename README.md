# Oil Moguls

Marketing site for Oil Moguls, a learning community for oil and gas professionals. Vue 3 + Vite + Tailwind CSS v4.

Production: [https://oilmoguls.com](https://oilmoguls.com)

```bash
npm install
npm run dev
```

Open http://localhost:5173. Production build: `npm run build`.

## Deploy

The site is a static nginx container on the ApexBee VPS (`85.17.145.58`), published at `127.0.0.1:4770`.

Until Hostinger DNS is updated, HTTPS preview is:

https://oilmoguls.85.17.145.58.sslip.io

Point DNS at this server (Hostinger → DNS):

- `A` `@` → `85.17.145.58`
- `A` or `CNAME` `www` → `85.17.145.58` / `oilmoguls.com`

Then issue Let's Encrypt certificates for `oilmoguls.com` and `www.oilmoguls.com`.
