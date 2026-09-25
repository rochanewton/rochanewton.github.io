# rochanewton.me

Source of **[rochanewton.me](https://rochanewton.me/)** — Newton Rocha's personal site: resume, articles and real-world case studies on IBM Sterling / Managed File Transfer, Linux infrastructure, automation, and applying AI to IT operations. Published in English and Brazilian Portuguese.

## Stack

| Layer | Tool |
| --- | --- |
| Static site generator | [Hugo](https://gohugo.io/) extended 0.164.0 — pinned in CI and locally |
| Theme | [Blowfish](https://blowfish.page/), as a git submodule in `themes/blowfish` |
| Hosting | GitHub Pages, custom domain `rochanewton.me` |
| CI/CD | GitHub Actions — strict build, deploy, CodeQL, Dependabot |
| View/like counters | Firebase (Firestore) — client config injected from repository secrets |


## Quality checks

- **Strict build** — `hugo --panicOnWarning` in CI and deploy; broken `{{< ref >}}` links fail the build
- **Markdown lint** — [`.markdownlint.jsonc`](.markdownlint.jsonc)
- **Spell check** — [`cspell.json`](cspell.json), English and Brazilian Portuguese
- **EditorConfig** — UTF-8, LF, 2-space indentation
- **Dependabot** — weekly PRs for GitHub Actions and the Blowfish theme
- **CodeQL** — scans the GitHub Actions workflows

## License

- **Code** (layouts, config, scripts, workflows): [MIT](LICENSE)
- **Content** (articles and original images): [CC BY 4.0](LICENSE-CONTENT.md)

Security issues: see [SECURITY.md](SECURITY.md).

