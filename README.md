# Newton Rocha

<p align="center">
  <strong>Cloud Engineer • AWS • Linux • Enterprise Integration</strong>
</p>

<p align="center">
  <a href="https://rochanewton.github.io">Website</a> •
  <a href="https://linkedin.com/in/rochanewton">LinkedIn</a> •
  <a href="https://github.com/rochanewton">GitHub</a>
</p>

---

## 📖 About

This repository contains the source code of my personal website, built using **MkDocs Material** and automatically deployed to **GitHub Pages** using **GitHub Actions**.

The site documents my professional journey in Cloud Computing, AWS, Linux, Cybersecurity, and Enterprise Integration.

---

## 🛠️ Tech Stack

- **Site Generator:** [MkDocs](https://www.mkdocs.org/)
- **Theme:** [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- **Programming Language:** Python
- **Automation & Hosting:** GitHub Actions & GitHub Pages

---

## ✨ Features

- **Personal Portfolio & Resume:** Modern, interactive career timeline.
- **Technical Blog:** Step-by-step guides and articles.
- **Responsive Layout:** Beautiful design fully optimized for mobile devices.
- **Print-to-PDF Overrides:** High-fidelity print styles for easy resume export.
- **Dark/Light Mode:** Seamless toggle controls.
- **Automated Validation:** CI/CD checks for markdown syntax, links, YAML schema, and spelling.

---

## 🔄 CI/CD Pipeline

Every push to the `main` branch triggers an automated GitHub Actions pipeline that:

1. **Markdown Linting:** Validates syntax and formatting rules.
2. **YAML Linting:** Verifies mkdocs and workflow files configuration.
3. **Spellchecking:** Uses Codespell to detect typos.
4. **Link Checking:** Scans document links to prevent broken references.
5. **Static Site Build:** Compiles Markdown sources into static HTML.
6. **Deploy:** Automatically deploys the built site to GitHub Pages.

---

## 💻 Local Development

To run the site locally, clone the repository and execute:

```bash
# Create and activate virtual environment
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Start local server
mkdocs serve
```

The site will be available at `http://127.0.0.1:8000/`.
