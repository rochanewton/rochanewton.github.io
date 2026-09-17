---
title: "Claude Certified Associate – Foundations: Domain 2 — Workflow Integration and Solution Design"
date: 2026-09-17
description: "Domain 2 is 16% of the Claude certification exam. It's not about whether one output is good — it's about deciding where Claude actually belongs in a workflow, and where it doesn't."
tags:
  - claude
  - anthropic
  - certification
  - workflow-integration
  - solution-design
  - ai-fluency
categories:
  - Claude
series:
  - getting-claude-certified
series_order: 4
showAuthor: true
image: cover.png
---

## What this is about

Domain 2 of the [Claude Certified Associate – Foundations](https://anthropic-partners.skilljar.com/claude-certified-associate-foundations-certification) exam is **Workflow Integration and Solution Design**. It's worth 16% — second only to Output Evaluation, which [Part 3]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}) already covered. Where that domain asked "is this one output good?", this one asks a different question entirely: **where does Claude actually belong in a workflow made of multiple steps, systems, and people — and where doesn't it?** Getting an individual answer right doesn't matter much if you've wired it into the wrong place in the process.

## Domain weight

![Horizontal bar chart titled "Where the exam actually puts its weight," showing all 7 Claude Certified Associate – Foundations exam domains ranked by percentage: Output Evaluation and Validation at 21%, Workflow Integration and Solution Design at 16% highlighted in blue, followed by Governance Risk and Responsible Use at 15%, Prompting and Task Execution at 14%, Product and Model Selection at 12%, Configuration and Knowledge Management at 12%, and Troubleshooting and Optimization at 10%](domain-weights-chart.webp "Workflow Integration and Solution Design is the second-heaviest domain on the exam, right behind Output Evaluation")

## Key point 1: three interaction patterns, not one

Claude fits into a solution three different ways, and each carries a different cost and a different amount of oversight it needs: **augmented calls**, where a human runs each step and Claude assists one call at a time; **workflows**, where Claude runs a fixed, predictable sequence of steps on its own; and **agents**, where Claude plans its own steps to reach a goal. Autonomy goes up at each stage — and so does the cost of it going wrong unsupervised.

![Horizontal bar chart titled "Three ways Claude fits into a solution," showing increasing autonomy and oversight need across three interaction patterns: Augmented calls (human runs each step, lowest risk), Workflows (Claude runs a fixed sequence, moderate), and Agents (Claude plans its own steps, highest oversight need)](interaction-spectrum.webp "Autonomy and the cost of getting it wrong rise together — pick the pattern that matches how much oversight the task actually needs")

Picking between the three comes down to two questions: does the task need more than one step, and does it need Claude to decide the steps itself?

{{< mermaid >}}
flowchart TD
    A[New task] --> B{More than<br/>one step?}
    B -->|No| C[Augmented call<br/>human runs it, Claude assists]
    B -->|Yes| D{Steps are fixed<br/>and predictable?}
    D -->|Yes| E[Workflow<br/>Claude runs the fixed sequence]
    D -->|No, Claude needs to<br/>decide the steps| F[Agent<br/>Claude plans and adapts as it goes]

    style C fill:#86b6ef,stroke:#5598e7,color:#0b0b0b
    style E fill:#2a78d6,stroke:#1c5cab,color:#fff
    style F fill:#104281,stroke:#0d366b,color:#fff
{{< /mermaid >}}

Each step down this tree trades predictability for reach — an agent can handle a task nobody scripted in advance, but it also needs the most oversight to catch when its own plan goes wrong.

## Key point 2: decompose the requirement before picking a pattern

Before choosing a pattern, split the problem into three ownership questions: what's Claude's job, what's the existing system's job, and what's the human's job. Skipping this step is how a task that should've been a single augmented call ends up over-engineered as an agent, or how a genuinely multi-step process gets crammed into one long prompt because nobody separated "what Claude does" from "what the database already does."

## Key point 3: reference architecture — retrieval vs. live-state

Once Claude's role is scoped, the next design decision is how it reaches information: **retrieval**, pulling from indexed or stored content that doesn't need to be current to the second, or **live-state integration**, calling a live system or API when the answer has to reflect what's true right now. Pricing, inventory, and account balances need live-state. A knowledge base answer about a policy from last quarter usually doesn't.

## Key point 4: picking the entry point

Claude shows up through several doors — Claude.ai, the API, SDKs, Claude Code, MCP servers — and each one is the right layer for a different kind of customization. Claude.ai is the user-facing interface for people working directly with Claude. The API and SDKs are the build-time engineering layer for embedding Claude into your own product. MCP servers are how Claude reaches external tools and data without custom integration code for each one. Picking the wrong entry point means re-solving a problem the platform already solved at a different layer.

## Key point 5: communicating value and limits to stakeholders

The last piece of this domain isn't technical at all: being able to explain to a stakeholder what Claude will actually do, what it won't, and where a human still has to be involved — before the solution ships, not after it disappoints someone. A solution nobody trusts because nobody explained its limits up front fails for a reason that had nothing to do with the model.

![Infographic summarizing the Workflow Integration and Solution Design framework in five numbered sections: three interaction patterns (augmented calls, workflows, agents), decomposing the requirement before picking a pattern (Claude's job, system's job, human's job), reference architecture (retrieval vs. live-state), picking the entry point (Claude.ai, API, SDKs, Claude Code, MCP servers), and communicating value and limits to stakeholders](domain-2-workflow-integration-infographic.webp "The whole Domain 2 framework on one page — built to share as a standalone summary")

## Conclusion

Domain 2 comes down to this: pick the interaction pattern that matches how much autonomy the task actually needs (augmented call, workflow, or agent), decompose the requirement so Claude, the existing system, and the human each own a clear piece, choose retrieval or live-state based on whether the answer needs to be current, pick the platform entry point that matches the kind of customization the job needs, and be straight with stakeholders about what the solution will and won't do. That's solution design — the layer above any single good output.

## Sources

- [Claude Platform & Solution Design — Anthropic Partner Academy](https://anthropic-partners.skilljar.com/claude-platform-solution-design)
- [Claude Certified Associate – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542847%2FClaude+Certified+Associate+%E2%80%93+Foundations+Exam+Guide.pdf) — official PDF

## Where this fits

Part 4 of **Getting Claude Certified**. Part 1 covered the [4D Framework]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}), Part 2 covered [Chat, Projects, Artifacts, and Research]({{< ref "/posts/claude-cert-02-using-claude-chat-projects-artifacts-and-research/" >}}), Part 3 covered [Domain 1 — Output Evaluation and Validation]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}). Part 5 takes on Domain 3 — Governance, Risk, and Responsible Use.
