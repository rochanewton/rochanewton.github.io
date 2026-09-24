---
title: "Becoming a Claude Architect: Overview — Claude Certified Architect – Foundations"
date: 2026-09-24
description: "A new certification, a new series. Claude Certified Architect – Foundations tests whether you can design Claude systems other people build on — not just use Claude well. Here's what the exam covers and what this series will walk through."
tags:
  - claude
  - anthropic
  - certification
  - claude-architect
  - agentic-architecture
  - mcp
  - ai-fluency
categories:
  - Claude
series:
  - becoming-a-claude-architect
series_order: 1
showAuthor: true
image: cover.png
---

## What this is about

**Claude Certified Architect – Foundations** is Anthropic's certification for designing Claude systems, not just using them. Where the Claude Certified Associate exam tests whether you can operate Claude with professional discipline — good prompts, sound judgment on output, the right entry point for the job — the Architect exam tests something a level up: can you design the agentic system, the tool integrations, and the configuration that other people build on top of. The ideal candidate has 6+ months of hands-on experience building with the Claude API, the Claude Agent SDK, Claude Code, and Model Context Protocol (MCP) — this isn't a first certification, it's the next one.

This kicks off a new series, **Becoming a Claude Architect**, separate from my [Getting Claude Certified]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}) series on the Associate exam. If you haven't sat that one yet, it's the natural place to start — this series assumes the fluency habits from that one are already in place.

## Key point 1: the exam, by the numbers

60 items, multiple-choice and multiple-response, 120 minutes, delivered proctored online or at a test center. Passing is a scaled score of 720 on a 100–1,000 scale — Anthropic doesn't publish the raw-to-scaled conversion, so "720" isn't "72% of questions right," it's a calibrated bar. The credential costs $125 and stays valid for 12 months, and scoring comes back as pass/fail plus a percent-correct breakdown by domain, so you know exactly where a retake needs to focus.

## Key point 2: five domains, one clear heaviest

{{< mermaid >}}
flowchart LR
    A[Agentic Architecture<br/>& Orchestration — 27%] --> F[Architect exam]
    B[Claude Code Configuration<br/>& Workflows — 20%] --> F
    C[Prompt Engineering<br/>& Structured Output — 20%] --> F
    D[Tool Design<br/>& MCP Integration — 18%] --> F
    E[Context Management<br/>& Reliability — 15%] --> F

    style A fill:#2a78d6,stroke:#1c5cab,color:#fff
    style B fill:#86b6ef,stroke:#5598e7,color:#0b0b0b
    style C fill:#86b6ef,stroke:#5598e7,color:#0b0b0b
    style D fill:#c9ddf6,stroke:#86b6ef,color:#0b0b0b
    style E fill:#c9ddf6,stroke:#86b6ef,color:#0b0b0b
{{< /mermaid >}}

![Horizontal bar chart titled "Where the Architect exam puts its weight," showing all 5 Claude Certified Architect – Foundations exam domains ranked by percentage: Agentic Architecture and Orchestration at 27%, Claude Code Configuration and Workflows at 20%, Prompt Engineering and Structured Output at 20%, Tool Design and MCP Integration at 18%, and Context Management and Reliability at 15%](domain-weights-chart.webp "Agentic Architecture and Orchestration alone is worth more than the two lightest domains combined")

Agentic Architecture & Orchestration carries more weight than any other single domain — over a quarter of the exam — which tells you where Anthropic thinks the real skill gap sits between someone who uses Claude well and someone who architects Claude systems: not in knowing the API surface, but in designing how autonomous work gets orchestrated, handed off, and kept reliable.

## Key point 3: usage skill and architecture skill are different exams for a reason

Being good at prompting doesn't automatically make someone good at deciding when a workflow should become a multi-agent system, what a tool's interface should look like to an LLM calling it blind, or how a Claude Code deployment should be configured so a team can trust it in production. The Associate exam tests judgment inside a single conversation. The Architect exam tests judgment about the system around the conversation — the parts a single good prompt can't fix.

## Key point 4: what this series covers

Six more posts follow this one, each taking on one domain in the order of the exam guide: Agentic Architecture & Orchestration, Tool Design & MCP Integration, Claude Code Configuration & Workflows, Prompt Engineering & Structured Output, and Context Management & Reliability. The series closes with a 100-question interactive practice set — 20 per domain, click an answer and see immediately whether it's right — built as an unofficial study aid once all five domain posts are written.

## Conclusion

Claude Certified Architect – Foundations in one pass: it's the next certification after Associate, not a harder version of the same one — it tests systems design, not usage discipline. 60 items, 120 minutes, a scaled 720 to pass. Agentic Architecture & Orchestration is the domain to take most seriously at 27% of the exam, with Claude Code Configuration & Workflows and Prompt Engineering & Structured Output tied right behind it at 20% each. Six domain-by-domain posts and a practice quiz follow.

## Sources

- [Claude Certified Architect – Foundations Certification — Anthropic Partner Academy](https://anthropic-partners.skilljar.com/claude-certified-architect-foundations-certification)
- [Claude Certified Architect – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542750%2FClaude+Certified+Architect+%E2%80%93+Foundations+Exam+Guide.pdf) — official PDF

## Where this fits

Part 1 of **Becoming a Claude Architect**. This series follows on from [Getting Claude Certified]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}), my 9-part series on the Claude Certified Associate – Foundations exam — start there if you're newer to Claude. Part 2 takes on [Domain 1 — Agentic Architecture & Orchestration]({{< ref "/posts/claude-architect-02-agentic-architecture-orchestration/" >}}).
