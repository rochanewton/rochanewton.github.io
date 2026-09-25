---
title: "Claude Certified Associate – Foundations: Domain 5 — Product and Model Selection"
date: 2026-09-17
description: "Before you write a single prompt, four decisions already set the quality ceiling: entry point, capability layer, model tier, context strategy. Domain 5 of the Claude certification exam, 12% of it, is that framework."
tags:
  - claude
  - anthropic
  - certification
  - model-selection
  - product-selection
  - ai-fluency
categories:
  - Claude
series:
  - getting-claude-certified
series_order: 7
showAuthor: true
image: cover.png
---

## What this is about

Domain 5 of the [Claude Certified Associate – Foundations](https://anthropic-partners.skilljar.com/claude-certified-associate-foundations-certification) exam is **Product and Model Selection**. It's worth 12%. The framing: before prompting even starts, four decisions already set the quality ceiling for the session — the right entry point, the right capability layer, the right model tier, the right context strategy. Get those four wrong and no amount of prompt polish fixes it. Get them right and the prompt has to do a lot less work.

![Horizontal bar chart titled "Where the exam actually puts its weight," showing all 7 Claude Certified Associate – Foundations exam domains ranked by percentage: Output Evaluation and Validation at 21%, Workflow Integration and Solution Design at 16%, Governance Risk and Responsible Use at 15%, Prompting and Task Execution at 14%, Product and Model Selection at 12% highlighted in blue, Configuration and Knowledge Management at 12%, and Troubleshooting and Optimization at 10%](domain-weights-chart.webp "Product and Model Selection ties for fifth-heaviest on the exam")

## Key point 1: pick the entry point by the job, not by habit

Chat is for a one-off question or quick task with no recurring setup. A Project is for recurring work with stable context and a consistent output format. An Artifact is for a standalone, editable deliverable meant to outlive the chat. Research is for a deep, current, multi-source investigation with citations. Defaulting to Chat for everything is the most common mismatch — it works, but it throws away the context-carrying value the other three exist for.

![Four cards titled "Four entry points, four different jobs": Chat for a one-off question or quick task, Project for recurring work with stable context and consistent format, Artifact for a standalone editable deliverable, Research for deep current multi-source investigation with citations](entry-points.webp "Pick the entry point by what the task needs, not by which one you opened first")

There's a quick test for whether a Project is worth building at all: does the task recur, is the background context stable, is the output format consistent? If two or more of those are true, a Project usually pays for itself.

## Key point 2: four capability layers, one memory hook

Projects carry recurring context and standing configuration. Skills define a repeatable procedure. Code Execution verifies anything that needs to be computed rather than estimated. Memory persists relevant facts across sessions. The layers are independent and stack — a Project can use Skills, which can trigger Code Execution, in a conversation Memory also has context on. The shorthand worth remembering: **Projects store knowledge; Skills perform tasks.**

## Key point 3: the Haiku / Sonnet / Opus decision frame

Three tiers, matched to how structured and how consequential the task is. **Haiku** fits fast, structured, high-volume, low-ambiguity work — extraction, classification, formatting, straightforward summarization. **Sonnet** is the balanced starting tier for most professional work — drafting, synthesis, analysis, research assistance, document review. **Opus** earns its cost when the quality ceiling matters more than speed — nuanced judgment, complex multi-step reasoning, ambiguous inputs, high-stakes synthesis.

{{< mermaid >}}
flowchart TD
    A[New task] --> B{Structured, high-volume,<br/>low ambiguity?}
    B -->|Yes| C[Haiku<br/>extraction, classification, formatting]
    B -->|No| D{Most professional work:<br/>drafting, analysis, synthesis?}
    D -->|Yes| E[Sonnet<br/>balanced starting tier]
    D -->|No, needs nuanced or<br/>high-stakes judgment| F[Opus<br/>quality ceiling over speed]

    style C fill:#86b6ef,stroke:#5598e7,color:#0b0b0b
    style E fill:#2a78d6,stroke:#1c5cab,color:#fff
    style F fill:#104281,stroke:#0d366b,color:#fff
{{< /mermaid >}}

The exam trap worth remembering: don't reach for Opus just because the subject sounds important. If the task is highly structured, unambiguous, and high-volume, Haiku is usually the better answer regardless of how weighty the topic feels.

## Key point 4: manage context before it degrades the output

Long sessions lose early detail as context fills and gets compressed. When a conversation that worked well for a long time suddenly stops following an early instruction, the signal is **context degradation, not a model-quality problem**. The fix has three moves: restart a new conversation once the current one is no longer reliable; before restarting, write a state summary of decisions, progress, and unresolved questions, and start the new conversation from that; and persist anything that should outlive the conversation into Memory, Project knowledge, or standing instructions instead of re-explaining it every time.

## Key point 5: web search, Research, Enterprise Search, or Thinking

Four different retrieval and reasoning tools, easy to reach for the wrong one. Web search is for a quick current fact from a small number of sources. Research is for comprehensive, multi-source, citation-backed investigation and comparative synthesis. Enterprise Search is for internal organizational knowledge — policies, Slack, email, docs, cross-source company context. Thinking is for deep reasoning where external information isn't the core need at all.

| Need | Reach for |
| --- | --- |
| Quick current fact | Web search |
| Comprehensive multi-source investigation | Research |
| Internal company knowledge across tools | Enterprise Search |
| Deep reasoning, no external lookup needed | Thinking |

![Infographic summarizing the Product and Model Selection framework in five numbered sections: pick the entry point by the job (Chat, Projects, Artifacts, Research), four capability layers with one memory hook (Projects, Skills, Code Execution, Memory), the Haiku/Sonnet/Opus decision frame, manage context before it degrades the output (restart, summarize, persist), and web search vs Research vs Enterprise Search vs Thinking](domain-5-product-model-infographic.webp "The whole Domain 5 framework on one page — built to share as a standalone summary")

## Conclusion

Domain 5 in one pass: pick the entry point that matches the job (Chat, Project, Artifact, or Research), know which of the four capability layers the task actually needs and remember Projects store knowledge while Skills perform tasks, match the model tier to how structured and consequential the work is instead of defaulting to the biggest model, and treat a conversation that stopped following instructions as a context problem to restart-summarize-persist through, not a model problem to fight. These four decisions happen before the prompt does any work at all.

## Sources

- [Claude Platform & Model Foundations — Anthropic Partner Academy](https://anthropic-partners.skilljar.com/path/claude-certified-associate-foundations/claude-platform-model-foundations)
- [Claude Certified Associate – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542847%2FClaude+Certified+Associate+%E2%80%93+Foundations+Exam+Guide.pdf) — official PDF

## Where this fits

Part 7 of **Getting Claude Certified**. Part 1 covered the [4D Framework]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}), Part 2 covered [Chat, Projects, Artifacts, and Research]({{< ref "/posts/claude-cert-02-using-claude-chat-projects-artifacts-and-research/" >}}), Part 3 covered [Domain 1 — Output Evaluation and Validation]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}), Part 4 covered [Domain 2 — Workflow Integration and Solution Design]({{< ref "/posts/claude-cert-04-workflow-integration-and-solution-design/" >}}), Part 5 covered [Domain 3 — Governance, Risk, and Responsible Use]({{< ref "/posts/claude-cert-05-governance-risk-and-responsible-use/" >}}), Part 6 covered [Domain 4 — Prompting and Task Execution]({{< ref "/posts/claude-cert-06-prompting-and-task-execution/" >}}). Part 8 takes on [Domain 6 — Configuration and Knowledge Management]({{< ref "/posts/claude-cert-08-configuration-and-knowledge-management/" >}}).
