# Resumes Project

## Workflow

- `Main_Resume.tex` is the master resume. It contains ALL of the user's information, skills, projects, and experience.
- `JD's/` holds job descriptions, one markdown file per JD (e.g. `Application_Engineer_Salesforce.md`).
- `Custom_Resumes/` holds tailored resumes. Never write a custom resume into the project root or over `Main_Resume.tex`.
- `CV/` holds full CVs.

## Creating a custom resume for a JD

1. Read the JD in `JD's/`.
2. Read `Main_Resume.tex` to source the user's facts, skills, and experience.
3. Create a tailored `.tex` file in `Custom_Resumes/`, named after the role.
4. Match the JD's required and preferred qualifications with facts that are TRUE. Never fabricate experience, metrics, or skills. When in doubt, ask the user.
5. Align the bullet points, skills, and summary to the JD's keywords and responsibilities, but keep the same section structure and LaTeX style as `Main_Resume.tex`.

## User feedback rules

- Only state what the user confirms. If a claim is unverified, flag it and ask.
- Keep bullets honest: no invented metrics ("near zero"), no fake capabilities ("real time", "engagement analysis") unless the user confirms them.

## Compile

- Use `pdflatex` to compile `.tex` files. Confirm the PDF renders before finishing.
