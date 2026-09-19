---
title: "Claude Certified Associate – Foundations: Domain 3 — Governance, Risk, and Responsible Use"
date: 2026-09-15
description: One inappropriate use case can freeze an entire organization's AI program. Domain 3 of the Claude certification exam, 15% of it, is the judgment framework for keeping adoption moving safely.
tags:
  - claude
  - anthropic
  - certification
  - governance
  - responsible-ai
  - ai-fluency
categories:
  - Claude
series:
  - getting-claude-certified
series_order: 5
showAuthor: true
image: cover.png
---

## What this is about

Domain 3 of the [Claude Certified Associate – Foundations](https://anthropic-partners.skilljar.com/claude-certified-associate-foundations-certification) exam is **Governance, Risk, and Responsible Use**. It's worth 15%. The framing is blunt: sensitive data uploaded to the wrong place, an untrusted Skill granted broad access, a quiet policy violation at the wrong moment — any one of these can freeze an entire organization's AI program and cost every team the productivity it had gained. Governance isn't a policy binder on a shelf. It's exercised by practitioners, one decision at a time — which makes it a skill you build, not a document you read once.

![Horizontal bar chart titled "Where the exam actually puts its weight," showing all 7 Claude Certified Associate – Foundations exam domains ranked by percentage: Output Evaluation and Validation at 21%, Workflow Integration and Solution Design at 16%, Governance Risk and Responsible Use at 15% highlighted in blue, followed by Prompting and Task Execution at 14%, Product and Model Selection at 12%, Configuration and Knowledge Management at 12%, and Troubleshooting and Optimization at 10%](domain-weights-chart.webp "Governance, Risk, and Responsible Use is the third-heaviest domain on the exam")

## Key point 1: screen use cases with four questions, not a gut feeling

Every proposed use case gets tested against four criteria: **reversibility** (can a wrong output be caught before it causes harm?), **consequence of error** (what does it cost if it's wrong?), **need for human creativity or empathy** (does this require judgment a model can't supply?), and **accountability** (who answers for the outcome?). Run all four, then name the one that's load-bearing — the one that, if it changed, would move the use case into a different category. That's what makes a classification defensible to a reviewer instead of just a feeling.

{{< mermaid >}}
flowchart TD
    A[Proposed use case] --> B{Run the 4 criteria:<br/>reversibility, consequence,<br/>human element, accountability}
    B -->|All clear| C[Fully appropriate<br/>normal review]
    B -->|Useful, but stakes or<br/>accountability need a gate| D[Appropriate with human review<br/>define who/what/when]
    B -->|Irreversible, high consequence,<br/>or non-transferable accountability| E[Inappropriate<br/>name the human role that must own it]

    style C fill:#0ca30c,stroke:#087a08,color:#fff
    style D fill:#fab219,stroke:#c98500,color:#0b0b0b
    style E fill:#d03b3b,stroke:#a82f2f,color:#fff
{{< /mermaid >}}

The middle box is where most people get sloppy: "appropriate with human review" isn't real until the gate is specific — who reviews, what they check, and when in the workflow it happens. "A manager reviews the shortlist for adverse-impact patterns before any candidate is contacted" is a gate. "We'll keep a human in the loop" is not.

## Key point 2: a Skill is software — vet it like software

A Skill can access whatever your session already has access to and can take actions through code execution. It doesn't request permissions; it inherits them. Before enabling one, check three things: **source** (who published it — Anthropic, internally-approved, or an unknown third party), **reach** (what could it actually touch in the sessions it runs in, and is that proportional to the task), and **appropriateness** (is it the right tool for the job, or more capability than needed). "Internal" isn't the same as "vetted" — a Skill built by another team in your own company still needs the same check.

Three outcomes fall out of that check: **enable** it when source, permissions, and appropriateness are all clear; **escalate** it to your admin or security function when it's useful but the source or permissions are unclear; **decline** it when the permissions are clearly disproportionate or the source can't be established. The same proportionality habit applies to any capability that can read or act on your data, not just Skills — least privilege, revisited when the job changes.

## Key point 3: classify data before it touches a feature

Sort data into three tiers before it goes near any feature. **Green** — public, anonymized, or already-cleared internal material — needs no special handling. **Yellow** — internal-only documents, anything with names or contact details, unannounced deal or product material — needs a policy check first, and Incognito mode so it skips Memory and chat history (though your organization's underlying retention policy still applies). **Red** — regulated data, credentials, anything under a third-party confidentiality obligation — needs an approved entry point confirmed *before* anything uploads, full stop.

![Three cards showing a green/yellow/red data-sensitivity classification: green "safe to use" for public or cleared material needing no special control, yellow "review first" for internal data needing policy review and Incognito mode, red "keep out" for regulated or confidential data needing an approved entry point before upload](data-tiers.webp "Incognito controls what gets remembered, not whether the data was allowed in the first place — for red data, that question comes first")

The common mistake is treating Incognito as a safety net for red data. It isn't. Incognito controls whether something gets remembered — it says nothing about whether the data was allowed into that feature to begin with. For regulated data, "is this allowed here" gets answered before "how do I handle it here."

## Key point 4: diligence is a habit, not a one-time check

A policy followed only when someone's watching isn't governance — the gap between what the policy says and what people actually do is exactly where risk accumulates, quietly, on the routine low-visibility decisions rather than the obvious high-stakes ones. The fix is a periodic audit: compare what your team is actually doing against what policy requires, and treat every divergence — an unapproved upload, a skipped review gate, an unvetted Skill — as a closeable gap, not a violation to punish. Most drift isn't malicious. It's friction: people take the easy path when the approved one is slower, so the durable fix is usually removing the friction, not adding a rule.

## Key point 5: ethical risk hides in ordinary outputs

Bias and fairness risk doesn't show up labeled as an ethics problem — it shows up as a routine summary, recommendation, or shortlist that quietly favors one group, built on a framing nobody questioned. It belongs in routine review, especially in people-facing work like hiring or evaluation, not a separate ethics exercise. Transparency matters too: know when your context or policy requires disclosing AI assistance, and default to disclosing when you're unsure. For genuinely ambiguous cases, reason through who's affected, what could go wrong, what fair looks like, and what disclosure applies — and when the affected population is large or the harm significant, escalate the reasoning rather than deciding alone. A documented "I don't know, and here's why" is more useful to a reviewer than a confident guess.

![Infographic summarizing the Governance, Risk and Responsible Use framework in five numbered sections: screen use cases with four questions (reversibility, consequence of error, human creativity or empathy, accountability), a Skill is software — vet it like software (source, reach, appropriateness), classify data before it touches a feature (green, yellow, red tiers), diligence is a habit not a one-time check (audit, find gaps, remove friction, build a culture), and ethical risk hides in ordinary outputs (check for bias, consider impact, be transparent, escalate when needed)](domain-3-governance-infographic.webp "The whole Domain 3 framework on one page — built to share as a standalone summary")

## Conclusion

Domain 3 in one pass: screen every use case against reversibility, consequence, human element, and accountability, and make the human-review gate specific when that's the answer. Vet a Skill's source and reach like you'd vet any software before installing it. Classify data green, yellow, or red before it touches a feature, and remember Incognito isn't a substitute for that classification. Audit real usage against policy on a schedule, because drift happens quietly. And check routine outputs for bias and disclosure the same way you'd check them for accuracy — because the ethical risk was never going to announce itself.

## Sources

- [Governance, Risk & Responsible Use — Anthropic Partner Academy](https://anthropic-partners.skilljar.com/path/claude-certified-associate-foundations/governance-risk-responsible-use)
- [Claude Certified Associate – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542847%2FClaude+Certified+Associate+%E2%80%93+Foundations+Exam+Guide.pdf) — official PDF

## Where this fits

Part 5 of **Getting Claude Certified**. Part 1 covered the [4D Framework]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}), Part 2 covered [Chat, Projects, Artifacts, and Research]({{< ref "/posts/claude-cert-02-using-claude-chat-projects-artifacts-and-research/" >}}), Part 3 covered [Domain 1 — Output Evaluation and Validation]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}), Part 4 covered [Domain 2 — Workflow Integration and Solution Design]({{< ref "/posts/claude-cert-04-workflow-integration-and-solution-design/" >}}). Part 6 takes on [Domain 4 — Prompting and Task Execution]({{< ref "/posts/claude-cert-06-prompting-and-task-execution/" >}}).
