---
title: "Claude Certified Associate – Foundations: Domain 4 — Prompting and Task Execution"
date: 2026-09-16
description: The same request, phrased two ways, produces two different levels of output. Domain 4 of the Claude certification exam, 14% of it, treats prompting as structure you can learn, not a knack some people have.
tags:
  - claude
  - anthropic
  - certification
  - prompting
  - task-execution
  - ai-fluency
categories:
  - Claude
series:
  - getting-claude-certified
series_order: 6
showAuthor: true
image: cover.png
---

## What this is about

Domain 4 of the [Claude Certified Associate – Foundations](https://anthropic-partners.skilljar.com/claude-certified-associate-foundations-certification) exam is **Prompting and Task Execution**. It's worth 14%. The framing that matters here: ask Claude to "write something about our Q3 results" and you get a generic paragraph. Specify the audience, the three results that matter, the format, and the length, and you get a draft you can almost send. The model didn't get smarter between those two requests. The prompt did. This domain treats prompting as a communication discipline with learnable structure, not a knack some people have.

![Horizontal bar chart titled "Where the exam actually puts its weight," showing all 7 Claude Certified Associate – Foundations exam domains ranked by percentage: Output Evaluation and Validation at 21%, Workflow Integration and Solution Design at 16%, Governance Risk and Responsible Use at 15%, Prompting and Task Execution at 14% highlighted in blue, followed by Product and Model Selection at 12%, Configuration and Knowledge Management at 12%, and Troubleshooting and Optimization at 10%](domain-weights-chart.webp "Prompting and Task Execution is the fourth-heaviest domain on the exam")

## Key point 1: the five-component stack

Five components carry almost all the weight in a professional prompt: **Role** (who Claude should be for this task), **Context** (the background Claude can't know unless you give it), **Task** (one unambiguous action), **Constraints** (length, tone, what to include or avoid), and **Output format** (the shape of the result). Not every prompt needs all five — a quick question needs a task and maybe a constraint. Context is the one professionals skip most often, because it lives in your head and never makes it into the prompt.

![Five-row diagram titled "The five-component prompt stack," each row color-coded and labeled: Role (who Claude should be), Context (the background Claude can't know unless given), Task (one unambiguous action), Constraints (length, tone, what to include or avoid), Output format (the shape of the result)](prompt-stack.webp "Most weak prompts are missing one row on this list, usually Context")

## Key point 2: decompose complex requests into ordered steps

A request with several distinct stages packed into one prompt produces shallow work on every stage. "Evaluate these three vendors and tell me which to pick" forces Claude to invent criteria, apply them, weigh trade-offs, and recommend, all in one pass — you never see the reasoning. Break it into a sequence instead, and each step produces a checkable result before the next one runs.

{{< mermaid >}}
flowchart LR
    A[Derive criteria<br/>from requirements doc] --> B[Score each vendor<br/>against those criteria]
    B --> C[Raise trade-offs<br/>where vendors diverge]
    C --> D[Recommend<br/>tied back to weighted criteria]

    style A fill:#2a78d6,stroke:#1c5cab,color:#fff
    style B fill:#2a78d6,stroke:#1c5cab,color:#fff
    style C fill:#2a78d6,stroke:#1c5cab,color:#fff
    style D fill:#1c5cab,stroke:#104281,color:#fff
{{< /mermaid >}}

If the criteria in step one are wrong, you catch it before scoring, not after the recommendation ships. Keep steps that build on each other in one conversation; split off into a new one only when a step is genuinely independent or the thread has grown long enough that early context is degrading.

## Key point 3: iterate on the component that failed, not the whole prompt

A first draft rarely lands perfectly, and the fix is never rewriting the whole prompt — that loses the parts that worked and hides which change actually fixed the problem. Read the output as a diagnostic instead: it points straight back to the component that fell short.

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| Output is generic or off-base | Context was thin | Add the background Claude couldn't infer |
| Output answered the wrong question | Task verb was ambiguous | Sharpen the instruction |
| Output is the wrong length, tone, or shape | A constraint or format was missing | Add it |
| Output is close but misses one section | — | Iterate on that section only |

Change the one component the output told you to change, resend, and compare. Stop when a round produces marginal change instead of real improvement — at that point a quick manual edit beats another round of prompting.

## Key point 4: match strategy to task type

The five components apply everywhere, but the emphasis shifts with what you're actually doing. Analysis wants tight constraints and explicit criteria — low creative latitude, high specification. Research wants clear scope and source discipline, with citations you can actually check. Drafting wants audience, tone, and format fixed, with room for Claude to find the phrasing. Brainstorming wants loose constraints and high latitude — over-specifying kills the range you're after.

| Task type | Tighten | Loosen |
| --- | --- | --- |
| **Analysis** | Criteria, standards, scope | Phrasing |
| **Research** | Question, sources, citations | Synthesis approach |
| **Drafting** | Audience, tone, format | Word choice |
| **Brainstorming** | Goal and guardrails only | Quantity and direction |

## Key point 5: a weak prompt, repaired

**Weak:** "Summarize the customer feedback and tell me what to do." **Output:** a generic five-bullet list of themes, nothing tied to the actual data, nothing actionable — because the prompt specified almost nothing.

**Repaired:** "You are a product analyst *(role)*. Attached are 200 customer survey responses *(context)*. Identify the three most frequently raised issues, ranked by how many responses mention each *(task)*, and for each include one representative verbatim quote and the approximate share of responses it appears in *(constraints)* — use code execution to count accurately rather than estimating. Format as a ranked list, most frequent first *(output format)*."

Same model, same data. The gap between the two outputs is entirely in the specification, not the underlying capability.

![Infographic summarizing the Prompting and Task Execution framework in five numbered sections: the five-component stack (role, context, task, constraints, output format), decompose complex requests into ordered steps, iterate on the component that failed, match strategy to task type, and a weak prompt repaired side by side with its fix](domain-4-prompting-infographic.webp "The whole Domain 4 framework on one page — built to share as a standalone summary")

## Conclusion

Domain 4 in one pass: run every non-trivial prompt against the five components (role, context, task, constraints, format), and expect context to be the one you forgot. Decompose multi-stage work into ordered steps so each one produces a checkable result before the next runs. When output disappoints, diagnose which component failed and fix only that — don't start over. Match your specification style to the task: tight for analysis and research, looser for drafting, loosest for brainstorming. Structure drives quality here, not cleverness.

## Sources

- [Prompting & Task Execution — Anthropic Partner Academy](https://anthropic-partners.skilljar.com/path/claude-certified-associate-foundations/prompting-task-execution)
- [Claude Certified Associate – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542847%2FClaude+Certified+Associate+%E2%80%93+Foundations+Exam+Guide.pdf) — official PDF

## Where this fits

Part 6 of **Getting Claude Certified**. Part 1 covered the [4D Framework]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}), Part 2 covered [Chat, Projects, Artifacts, and Research]({{< ref "/posts/claude-cert-02-using-claude-chat-projects-artifacts-and-research/" >}}), Part 3 covered [Domain 1 — Output Evaluation and Validation]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}), Part 4 covered [Domain 2 — Workflow Integration and Solution Design]({{< ref "/posts/claude-cert-04-workflow-integration-and-solution-design/" >}}), Part 5 covered [Domain 3 — Governance, Risk, and Responsible Use]({{< ref "/posts/claude-cert-05-governance-risk-and-responsible-use/" >}}). Part 7 takes on [Domain 5 — Product and Model Selection]({{< ref "/posts/claude-cert-07-product-and-model-selection/" >}}).
