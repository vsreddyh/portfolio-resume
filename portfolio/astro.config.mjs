import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import tailwindcss from '@tailwindcss/vite';

// GitHub Pages project site: https://vsreddyh.github.io/portfolio-resume/
// If you rename the repo, update `base` to match: '/<REPO-NAME>/'
// For a user site (vsreddyh.github.io repo), use base: '/'.
export default defineConfig({
  site: 'https://vsreddyh.github.io',
  base: '/portfolio-resume/',
  integrations: [mdx()],
  vite: {
    plugins: [tailwindcss()],
  },
});
