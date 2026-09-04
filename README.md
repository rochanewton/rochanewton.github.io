# newtonrocha.github.io

Personal site — notes on IBM Sterling / Managed File Transfer, Linux infrastructure, automation, and applying AI to IT operations.

Live at: **https://newtonrocha.github.io/**

## Stack

- [Hugo](https://gohugo.io/) — static site generator, content written in Markdown
- GitHub Pages — free static hosting
- GitHub Actions — CI (build validation on every pull request) and CD (automatic build + deploy on every push to `main`)

No paid services, no third-party hosting, no custom domain — 100% free tier.

## CI/CD pipeline

| Workflow | Trigger | What it does |
| --- | --- | --- |
| `.github/workflows/ci.yml` | Pull request → `main` | Builds the site in strict mode (`--panicOnWarning`). A broken build fails the check and blocks the merge. |
| `.github/workflows/deploy.yml` | Push to `main` | Builds the site, uploads the generated `public/` folder as a Pages artifact, and deploys it via GitHub's official `actions/deploy-pages`. |

Recommended repo setting: enable **branch protection on `main`** requiring the `CI` check to pass before merging, so nothing broken ever reaches production.

## Local development

```bash
# Install Hugo (extended version) — see https://gohugo.io/installation/
hugo server -D
# Site available at http://localhost:1313/
```

## Adding a new post

```bash
hugo new content posts/my-new-post.md
```

Edit the file under `content/posts/`, then commit and open a pull request. Once merged to `main`, the deploy workflow publishes it automatically — usually live within a minute or two.

## Project structure

```
content/          Markdown content (posts, about page)
layouts/          Custom HTML templates (no external theme dependency)
static/css/       Site stylesheet
.github/workflows/ CI and deploy pipelines
hugo.yaml          Site configuration
```
