---
title: "Building This Site: A CI/CD Pipeline with Hugo and GitHub Actions"
date: 2026-09-04
description: "How this site is built, tested, and deployed automatically — a small, real CI/CD pipeline running on GitHub Actions and GitHub Pages."
tags: ["ci-cd", "github-actions", "hugo", "devops"]
---

I wanted a place to write about infrastructure, middleware, and AI in operations — and I wanted building it to prove something too: that I can design and run a real CI/CD pipeline, not just talk about one.

## The stack

- **[Hugo](https://gohugo.io/)** — a static site generator written in Go. Content is plain Markdown, builds are fast, and there's no server or database to maintain.
- **GitHub Pages** — free static hosting, directly from this repository.
- **GitHub Actions** — builds and deploys the site automatically, and checks every change before it merges.

No paid services, no third-party hosting, no custom domain purchase — everything runs on GitHub's free tier.

## The pipeline

Two workflows do the work:

**`ci.yml`** runs on every pull request. It builds the site with Hugo in strict mode (`--panicOnWarning`), so broken shortcodes, bad front matter, or missing content fail the check before anything reaches `main`. This is the same principle I apply to production infrastructure changes: validate before you ship, not after.

**`deploy.yml`** runs on every push to `main`. It builds the site with Hugo, uploads the generated `public/` directory as a Pages artifact, and deploys it using GitHub's official Pages deployment action — no manual FTP, no build-on-my-laptop-and-copy-files step.

```yaml
# .github/workflows/deploy.yml (excerpt)
- name: Build
  run: hugo --minify

- name: Upload artifact
  uses: actions/upload-pages-artifact@v3
  with:
    path: ./public

- name: Deploy to GitHub Pages
  id: deployment
  uses: actions/deploy-pages@v4
```

## Why this matters to me

In my day-to-day work I plan and execute production changes, run disaster recovery exercises, and write the runbooks that keep a business-critical Managed File Transfer platform stable. The same discipline — test before you deploy, automate what's repetitive, keep a clear audit trail — applies here at a much smaller scale. Every post published on this site went through a pull request, a passing build check, and an automated deploy. It's a small pipeline, but it's a real one.

Next up: writing about the actual infrastructure and middleware work this site is meant to document.
