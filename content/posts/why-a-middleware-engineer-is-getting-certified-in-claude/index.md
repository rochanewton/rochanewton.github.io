---
title: "Why a Middleware Engineer Is Getting Certified in Claude"
date: 2026-09-13
description: "Notes on the Claude Certified Architect – Foundations exam — what it actually validates, its five domains, and why agentic-system architecture maps more directly onto middleware and IT-ops work than it might look at first glance."
tags:
  - claude
  - anthropic
  - agentic-architecture
  - mcp
  - ai-ops
  - certification
categories:
  - Claude
showAuthor: true
image: cover.png
---

## This isn't a "learn to prompt better" cert

When people hear I'm studying for an Anthropic certification, the first assumption is usually that it's about writing better prompts. It isn't. The **Claude Certified Architect – Foundations** exam sits above the Associate and Developer tiers precisely because it skips general usage and application development and goes straight at a narrower question: can you design and operate production agentic systems — multi-agent workflows, tool integrations, and automation that has to keep working when nobody's watching it. That's a systems-design problem, not a wording problem, and it's why I ended up putting it on the same roadmap as my IBM Sterling, Terraform, and AWS certifications rather than treating it as a side interest.

The pitch, in plain terms: banks and large enterprises are starting to automate monitoring, support, and operational workflows with agents the same way they automated file transfer and integration twenty years ago. My background is exactly that earlier wave — building and automating middleware operations — so this felt less like a pivot and more like the next layer on top of work I already do.

## What the exam actually covers

Anthropic breaks the exam into five weighted domains. Here's how they stack up:

| Domain | Weight | What it covers |
|---|---|---|
| Agentic Architecture & Orchestration | 27% | Designing agentic loops, multi-agent coordination, subagent spawning, task decomposition, session state management |
| Claude Code Configuration & Workflows | 20% | `CLAUDE.md` file hierarchies, path-scoped rules, custom skills with context restrictions, CI/CD integration |
| Prompt Engineering & Structured Output | 20% | Explicit review criteria, few-shot examples for ambiguous scenarios, JSON schemas with tool calling, multi-pass validation |
| Tool Design & MCP Integration | 18% | Writing effective tool descriptions, structured error responses, configuring Model Context Protocol servers |
| Context Management & Reliability | 15% | Preserving critical information across long conversations, escalation patterns, error propagation in multi-agent setups |

The heaviest domain — agentic architecture and orchestration, at 27% — is the one that reads most like a systems design exam: how a loop actually runs end-to-end (plan, call a tool, observe the result, iterate, decide when to stop), when a task should be handed to a subagent instead of handled inline, and how you pass context between agents without losing the one detail that mattered. None of that is prompt wording. It's the same kind of design thinking as deciding whether a file transfer should be handled by a [Business Process](/posts/sterling-b2bi-03-business-processes-bpml/) or delegated to a separate adapter — just with a different runtime underneath it.

## Where this overlaps with middleware work

The overlap is closer than it looks on paper, domain by domain:

**Orchestration is orchestration.** Deciding when an agent hands work to a subagent versus handling it inline is the same category of decision as deciding whether a [Business Process](/posts/sterling-b2bi-03-business-processes-bpml/) calls out to a separate service or inlines the logic. Both come down to isolating failure domains and keeping state legible across the handoff.

**MCP tool design is adapter design.** The exam's emphasis on writing tool descriptions an agent can reliably use, and structuring error responses with proper categorization, is the same discipline as designing a clean [Adapter or Service](/posts/sterling-b2bi-02-adapters-vs-services/) contract — a caller (human, agent, or engine) needs to know exactly what a component does and exactly how it fails.

**Escalation patterns already exist in my world.** Knowing when an agent should stop and hand off to a human is conceptually the same problem as the alerting and retry logic already built into a mature B2Bi environment — the interesting design question in both cases is where the escalation boundary sits, not whether one exists.

**Context management is state management.** Preserving the one critical fact across a long agent session is a smaller-scale version of the same problem [Perimeter Servers and Mailboxes](/posts/sterling-b2bi-05-mailboxes-file-gateway/) solve at the infrastructure layer — don't lose track of what matters as the process runs long.

None of this makes the exam easy — the domains around structured output and Claude Code configuration specifically (`CLAUDE.md` hierarchies, path-scoped rules, custom skills) are new vocabulary, not just new packaging on old ideas. But it means I'm not starting from zero on the architectural instincts the exam is actually testing.

## How I'm preparing

Anthropic's own documentation ([docs.claude.com](https://docs.claude.com)) is the primary source here — the exam draws from documented behavior in the Agent SDK, MCP, and Claude Code sections, not from folklore or third-party guesses about how the model behaves. Since this is a new certification program, practice-question banks are inconsistent in quality, so I'm treating the official docs as ground truth over any single prep site.

The other half is hands-on time: actually building with Claude Code and the Agent SDK, deliberately touching each of the five domains above at least once rather than passively reading about them. Writing an MCP tool description, configuring a `CLAUDE.md` hierarchy, and watching a multi-agent handoff actually happen teaches things a study guide can't.

## Sources & further reading

- [Claude Code documentation — Anthropic](https://docs.claude.com)
- [Model Context Protocol documentation](https://docs.claude.com)

As with the rest of this site: the domain definitions and exam structure are Anthropic's, the framing and the middleware comparisons are mine.

## What's next

This is the first post I've put under a new **IA** category rather than Middleware — it may end up being a one-off reflection, or the start of an occasional thread on where agentic tooling and middleware operations actually meet. Time, and the exam result, will tell.
