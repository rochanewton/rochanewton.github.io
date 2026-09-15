---
title: "The 4D Framework: Delegation, Description, Discernment, Diligence"
date: 2026-09-15
aliases:
  - /posts/why-a-middleware-engineer-is-getting-certified-in-claude/
description: "Anthropic's AI Fluency framework breaks working with AI into four competencies instead of a pile of prompt tricks. Here's what each one actually means in practice, and where I've seen myself skip straight past one of them."
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

## Prompting is the smallest part of this

Anthropic's **AI Fluency: Framework & Foundations** course — one of the three that make up the Claude Certified Associate – Foundations curriculum — names those four things directly: **Delegation, Description, Discernment, Diligence**. The 4Ds. I went in expecting a prompting course and came out with a decision framework instead, which is a better outcome. This kicks off a series where I'll work through what actually helped while studying for the certification, and more generally what's made the biggest difference in how I use Claude day to day — useful whether or not the exam itself is the goal.

## The four competencies

The four competencies as one picture, split above and below the waterline, since two of them are about what you produce and two are about what you don't see unless you go looking for it:

![The 4 core competencies of AI fluency, shown as an iceberg: Delegation and Description above the waterline as "what shows up after the pilot succeeds," Discernment and Diligence below it as "what AI fluency actually costs"](4d-ai-fluency-iceberg.webp "The framing I keep coming back to: delegation and description are the visible half of the work, discernment and diligence are the half nobody sees in the demo")

That's the whole framework in one image, but each quadrant deserves more than an icon and a caption.

## Delegation: the decision before the prompt

Delegation is deciding what work is appropriate for you to do, what's appropriate for AI, and what genuinely benefits from doing together — before any of that turns into an instruction. Anthropic breaks it into three pieces: **Problem Awareness** (do you actually understand the goal and the shape of the work), **Platform Awareness** (do you know what this specific AI system is actually good and bad at), and **Task Delegation** itself, which is the distribution decision that only makes sense once the first two are in place.

The part I underestimated is Platform Awareness. It's tempting to treat "AI" as one undifferentiated capability level and delegate the same way regardless of which system or which mode you're in. In practice, what's safe to hand off changes based on what you're actually working with — a quick chat answer, an agent running tool calls unattended, a long research task — and Delegation done well means re-asking the question every time, not deciding once and reusing the answer forever.

## Description: AI can't read your mind

Description is communicating with AI in a way that actually creates a working collaboration, and it splits into three layers that map to three different questions: **Product Description** (what do you want, in what format, for what audience), **Process Description** (how should it get there — is there a method or sequence you want followed), and **Performance Description** (how should it behave while working with you — terse or thorough, quick to push back or quick to agree).

Most disappointing AI output I've seen — mine included — traces back to skipping Process or Performance entirely and only ever specifying Product. You say what you want, get something plausible-looking back, and only notice in hindsight that you never said how you wanted it approached, or how blunt you wanted the feedback along the way. Anthropic's framing that stuck with me: AI systems are interactive partners, not vending machines. A vending machine doesn't need Process or Performance instructions. A partner does.

## Discernment: the flip side of description

If Description is you communicating outward, Discernment is judging what comes back — and it mirrors the same three-part structure. **Product Discernment** evaluates the output itself: is it accurate, coherent, actually relevant to what you asked. **Process Discernment** looks at how the AI got there: did the reasoning have gaps, did it skip a step it should have caught. **Performance Discernment** evaluates the interaction itself: was it actually responsive to your direction, or just agreeable.

Here's the uncomfortable part Anthropic's material is honest about: your Discernment is only as good as your own expertise in the subject. Ask an AI to explain something you already know well, and you'll catch a wrong claim in a sentence. Ask it about something you don't know, and the same wrong claim reads as confidently correct — because to you, it is indistinguishable from a right one. That's not a reason to avoid using AI outside your expertise. It's a reason to be more careful, not less, exactly where you're least equipped to catch a mistake — which is the opposite of how most people actually behave.

## Diligence: the part that isn't about quality at all

Diligence is different from the other three because it isn't really about getting better output — it's about taking responsibility for what you did to get it. Three components again: **Creation Diligence** (are you thoughtful about which AI system you're using and what you're feeding it), **Transparency Diligence** (are you honest with the people who'll see the result about AI's role in producing it), and **Deployment Diligence** (are you actually standing behind the output once it goes out under your name).

Deployment Diligence is the one I think gets skipped most often, because it's invisible right up until it isn't. Nobody asks whether you verified an AI-assisted deliverable until the moment it's wrong in front of someone who matters — at which point "the AI wrote that part" is not an acceptable answer. Diligence means the accuracy of the output is yours to answer for, full stop, regardless of what produced the first draft.

## A diligence statement, since I just wrote about the concept

In the spirit of the Diligence competency this post is literally about: I collaborated with Claude to research, structure, and draft this post from my own notes on Anthropic's AI Fluency course. The four-competency breakdown and the framing choices are mine; I reviewed the content against my source notes for accuracy before publishing, and I stand behind what's written here as an accurate representation of the framework and my own take on it.

## Sources & further reading

- [AI Fluency: Framework & Foundations — Claude Academy](https://academy.claude.com/courses/ai-fluency-framework-foundations)
- [AI Fluency Framework — documentation, papers, and open resources](https://aifluencyframework.org/)

As with the rest of this site: the framework and its terminology are Anthropic's, the practitioner framing and the examples of where each competency tends to get skipped are mine.

## Where this fits

This is Part 1 of **Getting Claude Certified** — an ongoing series of tips, study notes, and lessons learned from working toward Anthropic's Claude certifications, and from using Claude seriously day to day. The 4D framework goes first because everything else in the certification, and honestly everything else about using AI well, builds on it.
