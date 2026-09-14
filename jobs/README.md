# jobs

Hyderabad software salary / employer dataset scraped from AmbitionBox, kept alongside the resumes in this repo for salary benchmarking and JD targeting.

## What it contains

- `ambitionbox_combined_hyderabad.csv` — 137 rows, all designations merged. Columns:
  `Designation, Company, Rating, Reviews_Count, Industry, Location_Info, Experience, Salary_Range, Salary_Min_LPA, Salary_Max_LPA, Highly_Rated_For, Critically_Rated_For`
- `ambitionbox_<designation>_hyderabad.csv` (12 files) — per-role slices with the same columns minus `Designation`, e.g.:
  - `ambitionbox_software-engineer_hyderabad.csv` (52 rows)
  - `ambitionbox_software_developer_hyderabad.csv` (34 rows)
  - `ambitionbox_data-scientist_hyderabad.csv` (22 rows)
  - `ambitionbox_software_development_engineer_hyderabad.csv` (14 rows)
  - remaining 8 files have 1–3 rows each (`ai-ml-engineer`, `backend-developer`, `data-engineer`, `developer`, `full-stack-developer`, `full-stack-engineer`, `java-full-stack-developer`, `web-developer`)
- `designations_full.txt` — 199 AmbitionBox designation filters with live job counts, e.g. `software-engineer || Software Engineer (7720)`
- `software-related-designation-list.txt` — 39 software-only designations subset of the above
- `index.html`, `index.html.bak` — raw AmbitionBox jobs-filter HTML the designation lists were parsed from
- `package.json` — placeholder only (`jobs@1.0.0`, no scripts/dependencies)

All salaries are in ₹ LPA ranges for 0–x yrs experience, with company rating, review count, industry, location mix (`Hyderabad +N other locations`), and highly/critically-rated attributes.

## Why it's in the Resume repo

Use it to ground `Main_Resume.tex` / `Custom_Resumes/` tailoring and `JD's/` research:

- benchmark expected pay per designation/company in Hyderabad
- pick target companies and roles (see `designations_full.txt` counts)
- cross-check company culture signals (`Highly_Rated_For` / `Critically_Rated_For`, `Rating`, `Reviews_Count`)

## Quick use

```bash
# all Software Engineer rows sorted by max salary
head -n 1 ambitionbox_combined_hyderabad.csv
grep "^Software Engineer," ambitionbox_combined_hyderabad.csv | sort -t, -k10 -nr

# counts per designation
cut -d, -f1 ambitionbox_combined_hyderabad.csv | sort | uniq -c | sort -nr
```

Source: AmbitionBox Hyderabad listings. Snapshot as committed — re-scrape to refresh.
