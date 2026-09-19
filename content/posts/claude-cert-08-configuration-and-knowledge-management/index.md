---
title: "Claude Certified Associate – Foundations: Domain 6 — Configuration and Knowledge Management"
date: 2026-09-19
description: "There's a line between using Claude and operating Claude. Domain 6 of the Claude certification exam, 12% of it, is the discipline of setting up an environment once and benefiting from it every conversation after."
tags:
  - claude
  - anthropic
  - certification
  - configuration
  - knowledge-management
  - ai-fluency
categories:
  - Claude
series:
  - getting-claude-certified
series_order: 8
showAuthor: true
image: cover.png
---

## What this is about

Domain 6 of the [Claude Certified Associate – Foundations](https://anthropic-partners.skilljar.com/claude-certified-associate-foundations-certification) exam is **Configuration and Knowledge Management**. It's worth 12%. The line it draws: using Claude means typing a good prompt today. Operating Claude means building an environment where the right context, instructions, and procedures already exist, so every conversation starts from a configured baseline instead of a blank slate. Configuration is leverage — set it up once, benefit on every conversation that follows — and it's also what turns individual skill into team capability, since two people asking the same question against the same configured Project get the same quality of answer.

![Horizontal bar chart titled "Where the exam actually puts its weight," showing all 7 Claude Certified Associate – Foundations exam domains ranked by percentage: Output Evaluation and Validation at 21%, Workflow Integration and Solution Design at 16%, Governance Risk and Responsible Use at 15%, Prompting and Task Execution at 14%, Product and Model Selection at 12%, Configuration and Knowledge Management at 12% highlighted in blue, and Troubleshooting and Optimization at 10%](domain-weights-chart.webp "Configuration and Knowledge Management ties for fifth-heaviest on the exam")

## Key point 1: four mechanisms, four different jobs

**Instructions** govern behavior — tone, format defaults, verification habits — not facts. The **knowledge base** holds facts and reference material Claude should draw on without re-uploading — not behavior. **Skills** carry a repeatable procedure, built once at the account level under Customize and reused across any Project that needs it — not a one-off instruction. **Scoped Memory** keeps continuity within one Project, isolated from your other Projects so context never bleeds between workstreams.

![Four cards titled "Four configuration mechanisms, four jobs": Instructions for behavior (tone, format, verification habits), Knowledge base for facts and reference, Skills for a repeatable procedure built once and reused across Projects, Scoped Memory for continuity isolated to one Project](config-mechanisms.webp "Match the need to the slot — putting a procedure in instructions or a behavior rule in knowledge is the most common configuration mistake")

{{< mermaid >}}
flowchart TD
    A[A recurring need] --> B{What kind of<br/>need is it?}
    B -->|How Claude should behave| C[Instructions]
    B -->|A fact Claude should know| D[Knowledge base]
    B -->|A repeatable multi-step procedure| E[Skill]
    B -->|Continuity within this Project| F[Scoped Memory]

    style C fill:#2a78d6,stroke:#1c5cab,color:#fff
    style D fill:#eb6834,stroke:#c14e22,color:#fff
    style E fill:#1baf7a,stroke:#0d8a5c,color:#fff
    style F fill:#eda100,stroke:#c98500,color:#fff
{{< /mermaid >}}

## Key point 2: most needs map to two slots wired together

The cleanest configurations rarely fit one mechanism alone. "Always cite the source document for factual claims" is a standing instruction, but the documents it cites live in the knowledge base — neither works without the other. A consultant running one Project per client pairs the same way: standing instructions set the formal register and citation habit, the knowledge base holds the client's brand guide and current statement of work, an account-level Skill formats every status report the same way, and scoped Memory holds that client's stakeholder names — kept out of every other client's Project entirely.

## Key point 3: connectors have capability boundaries, not bugs

A connector — Google Drive, Gmail — extends Claude's reach into data you authorize, and each one has a defined edge. A mail connector that can search and read but not send isn't broken; it's at its boundary. Two pitfalls show up often in the field: the obvious "add a connector" path can route to a public directory instead of your organization's vetted ones, so confirm the right path with your admin on Team or Enterprise; and when a connector hits its boundary, the failure looks like a bug rather than documented behavior, which sends reports to the wrong team and stalls the fix. Knowing each connector's edge before you build a workflow on it avoids both.

## Key point 4: an instruction that's vague fails silently

"Make the reports good and accurate" gives Claude almost nothing to act on — output quality drifts conversation to conversation and nothing ever announces the failure. "For every figure in a report, state its source. If a figure isn't in the provided data, mark it 'unverified' rather than including it. Lead each report with a one-sentence headline" is precise enough to actually change output, consistently. The test for any standing instruction: would two different people reading it produce the same behavior?

## Key point 5: configurations age — schedule the maintenance

Instructions, knowledge, Skills, and Memory all drift toward stale, and none of them throw an error when they do — output just quietly degrades. A monthly review pass on active Projects catches most of it: do the standing instructions still match the current process, is the knowledge base free of superseded documents, are the right Skills enabled. Anthropic-built and org-provisioned Skills update automatically; your own custom Skills only change when you re-upload them. A recurring report Project drifting on stale figures is a textbook case — the knowledge base already had the current targets, but the standing instruction and a Memory entry still pointed at last year's template. The fix was updating those two, not writing a better prompt.

![Infographic summarizing the Configuration and Knowledge Management framework in five numbered sections: four mechanisms with four different jobs (instructions, knowledge base, Skills, scoped Memory), most needs map to two slots wired together, connectors have capability boundaries not bugs, an instruction that's vague fails silently, and configurations age — schedule the maintenance](domain-6-configuration-infographic.webp "The whole Domain 6 framework on one page — built to share as a standalone summary")

## Conclusion

Domain 6 in one pass: match each recurring need to the right mechanism — instructions for behavior, knowledge for facts, Skills for procedure, scoped Memory for continuity — and expect most real needs to wire two of them together. Know each connector's capability boundary before building on it. Write instructions precise enough that two people would read them the same way. And schedule maintenance, because configuration decays silently and the fix is almost always updating the setup, not the prompt.

## Sources

- [Configuration & Knowledge Management — Anthropic Partner Academy](https://anthropic-partners.skilljar.com/path/claude-certified-associate-foundations/configuration-knowledge-management)
- [Claude Certified Associate – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542847%2FClaude+Certified+Associate+%E2%80%93+Foundations+Exam+Guide.pdf) — official PDF

## Where this fits

Part 8 of **Getting Claude Certified**. Part 1 covered the [4D Framework]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}), Part 2 covered [Chat, Projects, Artifacts, and Research]({{< ref "/posts/claude-cert-02-using-claude-chat-projects-artifacts-and-research/" >}}), Part 3 covered [Domain 1 — Output Evaluation and Validation]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}), Part 4 covered [Domain 2 — Workflow Integration and Solution Design]({{< ref "/posts/claude-cert-04-workflow-integration-and-solution-design/" >}}), Part 5 covered [Domain 3 — Governance, Risk, and Responsible Use]({{< ref "/posts/claude-cert-05-governance-risk-and-responsible-use/" >}}), Part 6 covered [Domain 4 — Prompting and Task Execution]({{< ref "/posts/claude-cert-06-prompting-and-task-execution/" >}}), Part 7 covered [Domain 5 — Product and Model Selection]({{< ref "/posts/claude-cert-07-product-and-model-selection/" >}}). Part 9 takes on Domain 7 — Troubleshooting and Optimization.
