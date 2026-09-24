---
title: "Becoming a Claude Architect: Agentic Architecture & Orchestration — Domain 1"
date: 2026-09-24
description: "The heaviest domain on the Claude Certified Architect – Foundations exam, at 27%. The agentic loop, coordinator/subagent orchestration, subagent configuration, deterministic enforcement with hooks, task decomposition, and session management — the seven task areas of Domain 1."
tags:
  - claude
  - anthropic
  - certification
  - claude-architect
  - agentic-architecture
  - claude-agent-sdk
  - subagents
categories:
  - Claude
series:
  - becoming-a-claude-architect
series_order: 2
showAuthor: true
image: cover.png
---

## What this is about

Domain 1 — **Agentic Architecture & Orchestration** — is the single heaviest domain on the Claude Certified Architect – Foundations exam, worth 27% on its own. The exam guide breaks it into seven task areas: the agentic loop, multi-agent orchestration, subagent configuration, multi-step workflows, SDK hooks, task decomposition, and session management. That's a lot of ground, so this post condenses it into the five ideas that actually carry the weight, with the smaller two folded into a quick round-up at the end.

## Key point 1: the agentic loop runs on `stop_reason`, not on parsing Claude's words

The whole agentic loop comes down to one signal: **`stop_reason`**. Your application sends a request, Claude responds, and you check that field. `stop_reason: "tool_use"` means Claude has decided to call one or more tools — you execute them, package the output as `tool_result` blocks, and send a new request with the results appended. The loop repeats **while `stop_reason == "tool_use"`**. Anything else — most commonly `"end_turn"` — means Claude has produced its final answer and the loop exits.

The architect-level point here is the anti-pattern to avoid: don't try to detect "is Claude done?" by parsing the text of its reply for phrases like "I'm finished" or "here's the answer." That's fragile and model-dependent. `stop_reason` is a structured, contractual signal built for exactly this — use it.

## Key point 2: multi-agent orchestration is a hub, not a mesh

When one agent isn't enough, the pattern the exam tests is **coordinator/subagent hub-and-spoke**: a single coordinator agent manages all inter-subagent communication, error handling, and information routing. Subagents don't talk to each other directly — everything routes through the coordinator. This keeps failure handling centralized and avoids the combinatorial mess of every agent needing to know about every other agent.

Two design habits matter inside that pattern: **dynamic subagent selection** (the coordinator decides which subagent(s) a given task actually needs, rather than always fanning out to all of them) and **scope partitioning** — dividing the work so subagents aren't duplicating effort on overlapping pieces of the same problem. Well-designed orchestration also allows for **iterative refinement loops**, where a subagent's output can trigger another pass rather than the coordinator treating every result as final.

{{< mermaid >}}
flowchart LR
    U[Request] --> C[Coordinator agent]
    C --> S1[Subagent A]
    C --> S2[Subagent B]
    C --> S3[Subagent C]
    S1 --> C
    S2 --> C
    S3 --> C
    C --> R[Routed result]

    style C fill:#2a78d6,stroke:#1c5cab,color:#fff
    style S1 fill:#c9ddf6,stroke:#86b6ef,color:#0b0b0b
    style S2 fill:#c9ddf6,stroke:#86b6ef,color:#0b0b0b
    style S3 fill:#c9ddf6,stroke:#86b6ef,color:#0b0b0b
{{< /mermaid >}}

Notice what's *not* in that diagram: no arrows between the subagents. That's the hub-and-spoke discipline — every path runs through the coordinator.

## Key point 3: subagents don't inherit context, you have to hand it to them

This is the detail that trips people up most: spawning a subagent (via the Agent tool — internally still built on the `Task` mechanism, so a coordinator's `allowedTools` needs to include it) does **not** automatically hand that subagent the parent conversation's history. A non-forked subagent starts fresh — it gets its own system prompt and whatever you put in the Agent tool's prompt string, and nothing else from the parent. No prior tool results, no earlier reasoning, no assumed shared context.

The architectural implication: if a subagent needs a file path, an error message, an earlier decision, or any other detail from the parent's work so far, that detail has to be written explicitly into the prompt you hand it. This is also *why* subagents are useful for context isolation — a research subagent can read dozens of files without any of that content leaking into the main conversation, because only its final message returns to the parent. The isolation and the "you must pass context explicitly" rule are the same mechanism, seen from two sides.

## Key point 4: for compliance-critical steps, enforce with hooks — don't just ask nicely in a prompt

A prompt instruction ("always validate the amount before submitting a payment") is guidance, not a guarantee — an agent under enough context pressure can still skip it. When a step genuinely cannot be allowed to happen out of order or unchecked — the exam guide's example is financial operations — the architect-level answer is **programmatic enforcement**: hooks and prerequisite gates that run in code, not in the model's discretion.

The Claude Agent SDK's hooks fire on specific lifecycle events — a tool about to run (`PreToolUse`), a tool that just returned (`PostToolUse`), a subagent starting or stopping, and others. A `PostToolUse` hook, for example, can inspect and normalize a tool's output, or block a non-compliant result, before it ever reaches the next step of the agentic loop. The distinction to hold onto for the exam: prompt-based guidance shapes behavior probabilistically; hooks enforce it deterministically. Reach for hooks when "probably follows the rule" isn't good enough.

## A quick note on scale: task decomposition and session management

Two smaller pieces round out the domain. **Task decomposition** is the choice between a fixed, sequential pipeline (prompt chaining — do A, then B, then C, always in that order) and adaptive decomposition, where the next step is chosen based on what the previous step actually found. **Session management** covers resuming a named session to continue exactly where an agent left off, `fork_session` to branch off and explore an alternative direction without disturbing the original conversation's history, and knowing when a fresh session with an injected summary beats resuming a long one outright (shorter context, but you control exactly what carries forward).

## How much this matters

![Horizontal bar chart titled "Domain 1 carries more weight than any other single domain," showing all 5 Claude Certified Architect – Foundations exam domains with Agentic Architecture and Orchestration highlighted in blue at 27%, ahead of Claude Code Configuration and Workflows and Prompt Engineering and Structured Output tied at 20%, Tool Design and MCP Integration at 18%, and Context Management and Reliability at 15%](domain-1-weight-chart.webp "More than a quarter of the entire exam rides on getting this one domain right")

## Conclusion

Domain 1 in one pass: the agentic loop is a `stop_reason` state machine, not a text-parsing problem. Multi-agent work should route through a coordinator, never a subagent mesh. Subagents start with a blank context — hand them what they need explicitly. Compliance-critical steps get enforced with hooks, not just requested in a prompt. And task decomposition/session management round out the domain as the supporting pieces around those four bigger ideas. At 27% of the exam, this is the domain most worth over-preparing.

## Sources

- [Claude Certified Architect – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542750%2FClaude+Certified+Architect+%E2%80%93+Foundations+Exam+Guide.pdf) — Domain 1 task statements
- [How tool use works — Claude Platform Docs](https://platform.claude.com/docs/en/agents-and-tools/tool-use/how-tool-use-works) — `stop_reason`, `tool_use`, `end_turn`
- [Subagents in the SDK — Claude API Docs](https://code.claude.com/docs/en/agent-sdk/subagents) — coordinator pattern, context inheritance, tool restrictions
- [Intercept and control agent behavior with hooks — Claude API Docs](https://code.claude.com/docs/en/agent-sdk/hooks) — `PreToolUse`/`PostToolUse`
- [Work with sessions — Claude API Docs](https://code.claude.com/docs/en/agent-sdk/sessions) — resume vs. fork vs. fresh session

The research and the technical accuracy check against the official docs are AI-assisted; the framing, the "what this means for the exam" judgment calls, and any war stories are mine.

## Where this fits

Part 2 of **Becoming a Claude Architect**, following [the series overview]({{< ref "/posts/claude-architect-01-overview/" >}}). Part 3 takes on Domain 2 — Tool Design & MCP Integration.
