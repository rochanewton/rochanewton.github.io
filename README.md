# rochanewton.github.io

Newton Rocha's personal site — resume, articles, tips, and real-world case studies on IBM Sterling / Managed File Transfer, Linux infrastructure, automation, and applying AI to IT operations.

Live at: **https://rochanewton.github.io/**

## Stack

- [Hugo](https://gohugo.io/) — static site generator, content written in Markdown
- [Blowfish](https://blowfish.page/) — Hugo theme (installed as a git submodule), chosen for speed, built-in search, tags/categories, code syntax highlighting, image/video embedding, social sharing cards, and analytics integration
- GitHub Pages — free static hosting
- GitHub Actions — CI (build validation on every pull request) and CD (automatic build + deploy on every push to `main`)

No paid services, no third-party hosting, no custom domain — 100% free tier.

## CI/CD pipeline

| Workflow | Trigger | What it does |
| --- | --- | --- |
| `.github/workflows/ci.yml` | Pull request → `main` | Builds the site in strict mode. A broken build fails the check and blocks the merge. |
| `.github/workflows/deploy.yml` | Push to `main` | Builds the site (including the Blowfish theme submodule) and deploys it to GitHub Pages via `actions/deploy-pages`. |

Recommended repo setting: enable **branch protection on `main`** requiring the `CI` check to pass before merging.

## Local development

```bash
# Install Hugo extended (>= 0.164.0) — see https://gohugo.io/installation/
git clone --recurse-submodules https://github.com/rochanewton/rochanewton.github.io.git
cd rochanewton.github.io
hugo server -D
# Site available at http://localhost:1313/
```

If you already cloned without `--recurse-submodules`, run:

```bash
git submodule update --init --recursive
```

## Adding a new article

```bash
hugo new content posts/my-new-article.md
```

Edit the file under `content/posts/`, set `tags` and `categories` in the front matter, then commit and open a pull request. Once merged to `main`, the deploy workflow publishes it automatically.

## Updating the Blowfish theme

```bash
git submodule update --remote --merge themes/blowfish
git add themes/blowfish
git commit -m "Update Blowfish theme"
git push
```

## Project structure

```
content/           Markdown content (posts, about, contact, homepage)
config/_default/   Hugo + Blowfish configuration (hugo.toml, params.toml, languages.en.toml, menus.en.toml)
themes/blowfish/   Blowfish theme (git submodule)
.github/workflows/ CI and deploy pipelines
```
