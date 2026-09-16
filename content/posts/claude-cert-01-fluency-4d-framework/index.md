---
title: "The 4D Framework: Delegation, Description, Discernment, Diligence"
date: 2026-09-15
aliases:
  - /posts/why-a-middleware-engineer-is-getting-certified-in-claude/
  - /posts/ai-fluency-4d-framework/
description: "AI Fluency isn't a pile of prompt tricks — it's four competencies. Here's Delegation, Description, Discernment, and Diligence, condensed to what actually changes how you work with Claude."
tags:
  - claude
  - anthropic
  - ai-fluency
  - prompting
  - certification
  - ai-ops
categories:
  - Claude
series:
  - getting-claude-certified
series_order: 1
showAuthor: true
image: cover.png
---

## What this is about

Anthropic's AI Fluency course breaks working with AI into four competencies instead of a pile of prompt tricks: **Delegation, Description, Discernment, Diligence**. The 4Ds. I went in expecting a prompting course and came out with a decision framework instead — one that's less about writing better prompts and more about deciding what to hand off, how to communicate it, how to judge what comes back, and who's accountable for it. Here's each one, condensed to what actually matters.

## Key point 1: Delegation — the decision before the prompt

Delegation is deciding what's yours to do, what's AI's to do, and what's worth doing together — before any of that becomes a prompt. It comes down to knowing the actual goal, knowing what the specific AI system in front of you is good and bad at, and only then making the handoff call. The part most people underrate: what's safe to delegate changes by context. A quick chat answer and an unattended agent running tool calls don't get the same trust by default, so the question gets re-asked every time, not decided once and reused.

## Key point 2: Description — AI can't read your mind

Description is telling AI what you want clearly enough that it can actually deliver — not just the end result, but the method you want followed and how it should behave while working with you. Most disappointing AI output traces back to specifying only the end result and skipping the other two. Ask for a summary without saying how blunt the feedback should be, and don't be surprised when it agrees with everything you wrote.

## Key point 3: Discernment — the flip side of description

Discernment is judging what comes back: the output itself, the reasoning behind it, and whether the interaction was actually responsive to your direction or just agreeable. The catch — your discernment is only as strong as your own expertise in the topic. A wrong claim in your own field jumps out in a sentence. The same wrong claim outside your field reads as confidently correct, because to you, it's indistinguishable from a right one.

## Key point 4: Diligence — the part that isn't about quality at all

Diligence isn't about getting better output — it's about owning what you did to get it: being thoughtful about which system you use, being honest with people about AI's role when they see the result, and actually standing behind it once it ships under your name. The piece most often skipped is standing behind it — nobody checks until something's wrong in front of someone who matters, and "the AI wrote that part" doesn't hold up in that moment.

## How the four fit together

{{< mermaid >}}
flowchart LR
    A[Delegation<br/>decide what to hand off] --> B[Description<br/>say how, not just what]
    B --> C{Discernment<br/>judge the output}
    C -->|Gaps found| B
    C -->|Holds up| D[Diligence<br/>own the outcome]
    D -->|Next task| A

    style A fill:#2a78d6,stroke:#1a5fb4,color:#fff
    style B fill:#2a78d6,stroke:#1a5fb4,color:#fff
    style C fill:#eda100,stroke:#c98500,color:#fff
    style D fill:#eda100,stroke:#c98500,color:#fff
{{< /mermaid >}}

Delegation and Description are the two competencies visible in any AI demo — they're what produce the output. Discernment and Diligence are the two nobody sees on stage, and they're the two that actually determine whether that output was safe to use.

![The 4 core competencies of AI fluency, shown as an iceberg: Delegation and Description above the waterline as "what shows up after the pilot succeeds," Discernment and Diligence below it as "what AI fluency actually costs"](4d-ai-fluency-iceberg.webp "Delegation and description are the visible half of the work. Discernment and diligence are the half nobody sees in the demo.")

## Conclusion

The 4D framework in one line: decide what to delegate, describe it fully (not just the end result), judge what comes back with the same rigor you'd apply to a colleague's work, and own the outcome once it ships. Most disappointing AI experiences trace back to skipping one of these four — usually Description or Diligence — not to the model itself. That's the whole framework, and everything else about using Claude well builds on it.

## Sources

- [AI Fluency: Framework & Foundations — Claude Academy](https://academy.claude.com/courses/ai-fluency-framework-foundations)
- [AI Fluency Framework — documentation, papers, and open resources](https://aifluencyframework.org/)

## Where this fits

Part 1 of **Getting Claude Certified**. Part 2 covers [Chat, Projects, Artifacts, and Research]({{< ref "/posts/claude-cert-02-using-claude-chat-projects-artifacts-and-research/" >}}), Part 3 covers [Domain 1 — Output Evaluation and Validation]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}), which is Discernment's deep dive.
