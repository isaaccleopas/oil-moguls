This is a marketing website written with Vue 3, Vite, and Tailwind CSS v4.

## Project guidelines

- Keep the site static and backend-light. Do not add a server framework unless there is a real API or persistence need.
- Use Vue 3 with the Composition API (`<script setup>`) and Vue Router for pages.
- Put shared copy and links in `src/content.js`. ApexBee must stay on `https://apexbeeapp.com`.
- Production domain is `https://oilmoguls.com`. Preview host is `https://oilmoguls.85.17.145.58.sslip.io`.

### JS and CSS guidelines

- **Use Tailwind CSS classes and custom CSS rules** to create polished, responsive, and visually stunning interfaces.
- Tailwind CSS v4 is loaded from `src/style.css` with `@import "tailwindcss";` and `@theme` tokens. Do not add `tailwind.config.js`.
- **Never** use `@apply` when writing raw css.
- **Always** manually write your own tailwind-based components instead of using daisyUI.
- Import vendor CSS/JS into `src/` (or `index.html` for fonts). Do not add unrelated script tags in page templates.

### UI/UX & design guidelines

- **Produce world-class UI designs** with a focus on usability, aesthetics, and modern design principles
- Implement **subtle micro-interactions** (e.g., button hover effects, and smooth transitions)
- Ensure **clean typography, spacing, and layout balance** for a refined, premium look
- Focus on **delightful details** like hover effects, loading states, and smooth page transitions

Brand colours: Deep Forest `#0E3020`, Night `#103524`, Sage `#8FCDA5` (accent only), Off-White `#F2F6F1`.
