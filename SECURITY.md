# Security Policy

This repository is the source of [rochanewton.me](https://rochanewton.me/), a static site built with Hugo and deployed to GitHub Pages. It runs no servers and stores no user accounts. The only dynamic feature is the anonymous view/like counter, backed by Firebase and protected by Firestore Security Rules.

## Reporting a vulnerability

Please **do not open a public issue**. Report it privately through GitHub's
[Report a vulnerability](https://github.com/rochanewton/rochanewton.github.io/security/advisories/new) form and include:

- the affected URL, file or workflow
- steps to reproduce
- the impact you observed

I will acknowledge the report within 7 days and aim to fix confirmed issues within 30 days. Credit is given in the fix commit if you want it.

## Scope

In scope: this repository's templates, configuration, scripts and GitHub Actions workflows — for example XSS through a layout, a leaked secret, or an over-permissioned workflow.

Out of scope: GitHub Pages infrastructure, third-party services, and the upstream [Blowfish theme](https://github.com/nunocoracao/blowfish/security) (report those to their maintainers).
