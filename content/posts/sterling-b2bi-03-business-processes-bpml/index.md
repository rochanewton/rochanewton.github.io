---
title: "Business Processes and BPML in IBM Sterling B2B Integrator: Two Views of the Same Engine"
date: 2026-09-09
description: What a Business Process actually is, what BPML is, why the Graphical Process Modeler and raw BPML are the same thing seen two ways, and the elements and scenarios that matter most when one breaks.
tags:
  - ibm-sterling
  - b2bi
  - mft
  - middleware
  - architecture
  - bpml
categories:
  - Middleware
series:
  - sterling-b2bi-architecture
series_order: 3
showAuthor: true
image: cover.png
---
## What is a Business Process

A **Business Process** is the workflow that strings adapters and services together into something that actually does a job: receive a file, validate it, map it, encrypt it, hand it to an adapter for delivery, log every step along the way. It's the thing [Part 1](/posts/sterling-b2bi-01-overview/) called "the closest thing the platform has to a heart" — because almost nothing meaningful happens in Sterling B2B Integrator outside of one running.

Structurally, a Business Process is just a sequence of steps with branching logic: call this service, check this condition, call that adapter, handle it differently if something goes wrong. Nothing about that description requires a diagram. Which is exactly the point.

## What is BPML

**BPML** — Business Process Markup Language — is the XML-based language a Business Process is actually written in underneath. Every box you drag in the visual designer becomes an element in this markup; every arrow becomes the nesting and sequencing of those elements. It's not a simplified summary of the process — it's the literal, complete definition the Business Process Engine executes. Nothing runs that isn't in the BPML, including anything the visual designer generated for you without asking.

## GPM and BPML are the same thing, viewed differently

The **Graphical Process Modeler (GPM)** is the tool most people learn first: drag a service icon onto the canvas, connect it to the next step, and the tool builds the process visually. What's easy to miss starting out is that the GPM isn't a separate, simplified way of building a Business Process — it's a real-time translator. IBM's own documentation describes it as a Web-deployed graphical interface tool used to create and modify Business Processes ([IBM Documentation](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=processes-graphical-process-modeler)), and under the hood it converts every graphical model you build directly into BPML — and just as easily converts existing BPML back into the diagram, letting you toggle between the two views of the exact same process at any point.

That reversibility is the part worth internalizing: nothing is lost going from diagram to code or back. A Business Process built entirely by dragging icons and a Business Process typed by hand in a text editor are functionally identical once saved — the engine doesn't know or care which one you used.

## The BPML elements you'll actually use

BPML has a fairly large vocabulary, but a handful of elements cover the overwhelming majority of what you'll read and write:

**OPERATION.** The workhorse element — this is the BPML component used to call a service or adapter from within a Business Process ([IBM Documentation](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=bpml-business-process-components)). Every icon you drag in the GPM that represents a service or adapter compiles down to an OPERATION underneath. If you're hunting for where a specific service gets invoked, you're hunting for an OPERATION block.

**SEQUENCE.** The structural element that says "these steps happen in this order." Most of a Business Process is one big SEQUENCE with other elements nested inside it — it's the skeleton everything else hangs off.

**CHOICE.** Conditional branching — do this if a condition is true, do something else if it isn't. This is where partner-specific routing logic usually lives: "if trading partner is X, use map A; otherwise use map B."

**ASSIGN.** Moves data between the Business Process's working memory and a service's input or output parameters. Unglamorous, but this is where a huge share of "the map got the wrong field" bugs actually originate — not in the map itself, but in an ASSIGN that pointed it at the wrong piece of data.

**ONFAULT.** Error handling. When a step inside a SEQUENCE fails, an ONFAULT block lets you catch that failure and do something deliberate about it — retry, notify, route to a dead-letter mailbox — instead of letting the process die silently. A Business Process with no ONFAULT handling isn't wrong, exactly, but it's the single most common reason "the file just disappeared" turns into a long investigation.

## Scenarios: reading and writing BPML in practice

**Scenario 1 — Building a new inbound Business Process from scratch.** This is GPM's home turf: drag an adapter icon, drag a validation service, drag a mapping service, connect them, save. For a first draft, the visual tool is faster than typing BPML by hand, and it's much harder to produce invalid XML by accident.

**Scenario 2 — The GPM is slow or unavailable, and a process needs a small fix right now.** This is exactly the moment that senior engineer was demonstrating. Opening the .bpml file directly in a text editor, finding the OPERATION or ASSIGN block in question, and editing it by hand is entirely valid — the engine doesn't care how the file was produced. Being comfortable reading raw BPML turns "I need the GPM to load" into "I need a text editor," which matters more than it sounds like during an actual incident.

**Scenario 3 — The same small change needs to go into fifty Business Processes.** Clicking through fifty processes in the GPM one at a time is a bad afternoon. Scripting a find-and-replace across fifty .bpml files is not. This is the scenario where knowing BPML isn't just a debugging skill — it's the difference between an hour of work and a week of it.

**Scenario 4 — A process is failing and nobody knows where.** Start with the ONFAULT blocks — or the lack of them. If a SEQUENCE has no error handling around the step that's failing, that's usually the fastest fix available: wrap it, log what actually failed, and the next failure explains itself instead of requiring another investigation from scratch.

## Why the distinction actually matters

The GPM is the better tool for building and understanding a process's shape — the boxes-and-arrows view makes the overall flow obvious in a way that nested XML tags don't. Raw BPML is the better tool for precision, bulk changes, and anything that has to happen when the visual tool is slow, unavailable, or simply overkill for a two-line fix.

Neither one is the "real" Business Process and the other a shortcut. They're the same definition, and the right one to use depends entirely on what you're trying to do at that moment — build something new, or fix something specific, fast.

## Where this sits in the bigger picture

Every adapter and service call from [Part 1](/posts/sterling-b2bi-01-overview/) and [Part 2](/posts/sterling-b2bi-02-adapters-vs-services/) happens because a Business Process's BPML told the engine to make it happen, in that order, with that error handling. The GPM and the raw BPML are just two doors into editing the same file:

{{< mermaid >}}
flowchart TB
    subgraph Authoring["Two Ways In"]
        GPM["Graphical Process Modeler<br/>(drag, connect, toggle view)"]
        TXT["Text Editor<br/>(edit .bpml directly)"]
    end

    BPML[("BPML<br/>(the actual definition)")]
    ENGINE["Business Process Engine"]

    GPM <-->|generates / renders| BPML
    TXT <-->|reads / writes| BPML
    BPML --> ENGINE

    ENGINE --> OP1["OPERATION<br/>(call an Adapter)"]
    ENGINE --> OP2["OPERATION<br/>(call a Service)"]
    ENGINE --> CH["CHOICE<br/>(branch)"]
    ENGINE --> OF["ONFAULT<br/>(handle failure)"]
{{< /mermaid >}}

Both authoring paths converge on the exact same BPML, and the engine that actually runs it has no idea — and no reason to care — which door you used.

## Sources & further reading

- [Graphical Process Modeler](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=processes-graphical-process-modeler)
- [BPML Business Process Components](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=bpml-business-process-components)
- [Business Processes](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=integrator-business-processes)
- [Add error handling to a Business Process](https://www.ibm.com/docs/en/b2b-integrator/5.2?topic=processes-add-error-handling-business-process)
- [IBM Support: Business Process does not invoke any OnFault when a service fails with error](https://www.ibm.com/support/pages/business-process-does-not-invoke-any-onfault-when-service-fails-error)

As with the rest of this series, the framing, the scenarios, and the war stories are mine — the definitions and the BPML element behavior are IBM's.

## What's next

Next up: **Mailboxes and File Gateway** — untangling the confusion flagged back in [Part 1](/posts/sterling-b2bi-01-overview/), with a closer look at how File Gateway's routing actually sits on top of the mailbox and adapter machinery underneath it.
