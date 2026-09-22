# Portfolio (Astro, GitHub Pages)

Single-page site (`/`) + one page per project (`/projects/[slug]`).

## Dev

```bash
npm ci
cp ../resume/Main_Resume.pdf public/resume.pdf   # Main resume is the only resume artifact used
npm run dev
```

## Resume wiring

- Source of truth: `resume/Main_Resume.pdf` (lives in `resume/` root, not `resume/exports/`).
- The deploy workflow copies it to `portfolio/public/resume.pdf` before every build, so the site always serves the current Main resume at `/resume.pdf`.
- `public/resume.pdf` is gitignored locally (it's a build artifact copy); CI regenerates it.

## Deploy

Push to `main` → `.github/workflows/deploy-portfolio.yml` builds `portfolio/` and deploys `dist/` to Pages.
If you rename the repo, update `base` in `astro.config.mjs`.
