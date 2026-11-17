import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import tailwindcss from '@tailwindcss/vite';

// GitHub Pages project site: https://vsreddyh.github.io/portfolio-resume/
// If you rename the repo, update `base` to match: '/<REPO-NAME>/'
// For a user site (vsreddyh.github.io repo), use base: '/'.
// PR previews override this via SITE_BASE (see preview-pages.yml);
// production deploys keep the default below.
// `||` (not `??`) so an explicitly empty SITE_BASE also falls back.
const previewBase = process.env.SITE_BASE || '/portfolio-resume/';
export default defineConfig({
  site: 'https://vsreddyh.github.io',
  base: previewBase,
  integrations: [mdx()],
  vite: {
    plugins: [tailwindcss()],
  },
});
