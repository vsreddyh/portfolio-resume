# AGENTS.md

## Build policy (npm builds are CI-only)

- NEVER run `npm run build` (or `astro build` directly) locally on this machine. This is a 2-vCPU shared host — parallel sessions running builds pegged CPU at 100% on 2026-10-28. `deploy-portfolio.yml` builds on `main`; PRs are verified by review + CI, never by a local build.
- `npm ci` and `npm run dev` are fine for local iteration.

## Branch policy (always PR to dev)

- `dev` is the integration branch. All feature/fix/docs branches PR to `dev` (`gh pr create --base dev`).
- Always use PRs — never push directly to `main` or `dev`.
- `dev` merges to `main` via PR (`dev` → `main`) when ready to deploy. `deploy-portfolio.yml` only runs on `main`.

## Agent skills

### Issue tracker

Issues live in this repo's GitHub Issues (`vsreddyh/portfolio-resume`, via the `gh` CLI). See `docs/agents/issue-tracker.md`.

### Triage labels

Default five canonical triage roles (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: `GLOSSARY.md` + `docs/adr/` at the repo root, created lazily. See `docs/agents/domain.md`.
