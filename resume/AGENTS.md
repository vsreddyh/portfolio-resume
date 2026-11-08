# Resumes Project

## Workflow

- `Main_Resume.tex` is the master resume. It contains ALL of the user's information, skills, projects, and experience.
- `JD's/` holds job descriptions, one markdown file per JD (e.g. `Application_Engineer_Salesforce.md`).
- `Custom_Resumes/` holds tailored resumes. Never write a custom resume into the project root or over `Main_Resume.tex`.
- `CV/` holds cover-letter CVs: a letter explaining why the user is suitable for the role, 50–100 words only. Always write CVs as `.txt` files. Never use the tailored resume generator for CVs. A cover letter is a proper business letter, not a resume: no centered resume-style header — sender block is name + email only, then date, recipient, `Re:` line, salutation, body, sign-off with name. On user request, also produce a typeset PDF letter compiled into `exports/` (see Compile for the `-jobname` rule).
- `exports/` holds all compiled PDFs. Compile every `.tex` file into `exports/`; never leave PDFs in project root, `Custom_Resumes/`, or `CV/`.

## Creating a custom resume for a JD

1. Read the JD in `JD's/`.
2. Read `Main_Resume.tex` to source the user's facts, skills, and experience.
3. Create a tailored `.tex` file in `Custom_Resumes/`, named after the role.
4. Match the JD's required and preferred qualifications with facts that are TRUE. Never fabricate experience, metrics, or skills. When in doubt, ask the user.
5. Align the bullet points, skills, and summary to the JD's keywords and responsibilities. Section structure may be changed to serve the JD (reorder, rename, or merge sections) but keep the same LaTeX style as `Main_Resume.tex`.
6. Tailor content in the custom resume to fit the JD while keeping it to one page: keep the Technical Skills category structure (Languages, Backend, Frontend, Databases, Cloud/DevOps, AI/ML, Tools), list the JD's required technologies first, and only include skills that are TRUE for the user — drop skills irrelevant to the JD. Keep skill lines lean: drop redundant items (e.g. JavaScript when TypeScript/Node.js is listed) and whole categories with no JD relevance (e.g. Testing, Frontend) rather than letting the section bloat. You may edit, reword, or remove bullet points. Do not change the master `Main_Resume.tex` unless asked.
7. Derived resumes (custom resumes, CVs, or any resume built from `Main_Resume.tex`) must always fit on a single page.
8. Never leave a section (experience role, project, etc.) with only one bullet point — keep at least two per section, or drop the section entirely.
9. Never remove an experience (role) section from a custom resume. If one page is tight, trim bullets, projects, skills, or other sections instead. An experience section may be trimmed down to two bullet points if needed: keep the most JD-relevant point first, and make the second point a one-line summary of the rest of the work.
10. Keep every bullet point to at most two lines; prefer a single line. Trim wording to fit, never facts.
11. Typography: body text is justified with hyphenation disabled — every new `.tex` file must include `\usepackage[none]{hyphenat}` and `\sloppy` in the preamble so words never split across lines. Rendered text uses normal hyphens only (`-`): never `--`, `---`, or em-dashes in dates, figures, or prose (e.g. `2022 - 2026`, `10-25\%`). `%---` comment separators are fine; they don't render.

## Changelog responses

- Whenever the agent edits or creates a resume, respond with a changelog of what changed.
- When a resume is created: list both what was removed from `Main_Resume.tex` and what was edited from it.
- When a resume is edited: list both what was removed from the previous version and what was edited from it.

## User feedback rules

- Only state what the user confirms. If a claim is unverified, flag it and ask.
- Keep bullets honest: no invented metrics ("near zero"), no fake capabilities ("real time", "engagement analysis") unless the user confirms them.

## Compile

- Use `tectonic` to compile `.tex` files; on hosts where it is not installed, `pdflatex` is the accepted fallback. Confirm the PDF renders before finishing.
- `Custom_Resumes/<name>.tex` and `CV/<name>.tex` share basenames, so compiling both with default settings overwrites one PDF. Always compile CV letters with `-jobname=CV_<name>` (e.g. `exports/CV_Platform_Software_Engineer_2_Oracle_348618.pdf`).
- Verify with `pdfinfo` (exactly 1 page) and `pdftotext` (no output line ends with `-`, i.e. no split words).
