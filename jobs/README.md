# jobs

Hyderabad software salary / employer dataset scraped from AmbitionBox, kept alongside the resumes in this repo for salary benchmarking and JD targeting.

> Salary CSVs were removed — the `Hyderabad +N other locations` rows covered
> companies with no verifiable Hyderabad tech office, so the data was unfit for
> Hyderabad benchmarking. A fresh scrape (verified-Hyderabad companies only) is
> pending — see `designations_full.txt` for the role menu to scrape from.

## What it contains

- `designations_full.txt` — 199 AmbitionBox designation filters with live job counts, e.g. `software-engineer || Software Engineer (7720)`
- `package.json` — placeholder only (`jobs@1.0.0`, no scripts/dependencies)

All salaries were in ₹ LPA ranges for 0–x yrs experience (removed, see above).

## Why it's in the Resume repo

Use it to ground `Main_Resume.tex` / `Custom_Resumes/` tailoring and `JD's/` research:

- benchmark expected pay per designation/company in Hyderabad
- pick target companies and roles (see `designations_full.txt` counts)
- cross-check company culture signals (`Highly_Rated_For` / `Critically_Rated_For`, `Rating`, `Reviews_Count`)

## Quick use

```bash
# counts per designation filter
cut -d'(' -f2 designations_full.txt | sort -t')' -k1 -nr | head
```

Source: AmbitionBox Hyderabad listings. Snapshot as committed — re-scrape to refresh.
