---
title: "IBM Sterling B2B Integrator: A Quick Architecture Overview"
date: 2026-09-08
description: "The handful of pieces that make up IBM Sterling B2B Integrator, and how they fit together — a short map before the deep dives."
tags: ["ibm-sterling", "b2bi", "mft", "middleware", "architecture"]
categories: ["Middleware"]
series: ["sterling-b2bi-architecture"]
series_order: 1
showAuthor: true
---

If you've ever opened the Sterling B2B Integrator admin console for the first time, you know the feeling: adapters, services, business processes, mailboxes, envelopes, maps — all sitting in the same menu, all sounding vaguely related, none of it explained in one place. IBM's own documentation is thorough, but it's a reference, not a map.

This post is the map. Short version first, details later — I'm turning each piece below into its own post over the next few months, so treat this as the table of contents for a series, not the last word on any of it.

## What B2Bi actually is

At its core, Sterling B2B Integrator is a workflow engine for moving and transforming files between your business and your trading partners — banks, suppliers, logistics providers, whoever needs to exchange EDI documents, flat files, or XML with you reliably and traceably. Everything else in the product exists to support that one job: get a file in, do something to it, get it out, and know exactly what happened at every step.

## The pieces, in the order a file touches them

**Perimeter Servers.** When a partner connects from outside your network, they don't talk to the core engine directly. A Perimeter Server sits in the DMZ and handles the actual protocol connection (SFTP, AS2, HTTP), forwarding traffic inward over a secure channel. This is a security-architecture detail a lot of intro material skips, and it matters — it's the reason you can expose partner-facing endpoints without putting your core engine anywhere near the internet.

**Adapters.** These are what actually speak a protocol — SFTP, AS2, Connect:Direct, HTTP/S, JDBC, and dozens more. An adapter's job is narrow: receive or send a file over a specific protocol and hand it off to a Business Process.

**Business Processes (the BPML engine).** This is the heart of B2Bi. A Business Process is a workflow — modeled visually in the Graphical Process Modeler, stored as BPML (Business Process Markup Language) underneath — that strings together steps: validate this file, map it, encrypt it, route it, notify someone if it fails. Every meaningful action in B2Bi happens inside a Business Process.

**Services.** Where Adapters talk to the outside world, Services do internal work: mapping, validation, extraction, compression, custom logic. A Business Process is mostly just a sequence of Adapter and Service calls, in order, with branching for error handling.

**Maps.** Trading partners rarely send you data in the format you want it in. Maps translate between formats — EDI to XML, flat file to JSON, whatever the business needs — and are built in the Map Editor, a genuinely deep tool in its own right (worthy of its own post later in this series).

**Mailboxes.** Think of a Mailbox as a secure, permissioned drop box inside B2Bi where partners' files land and get picked up. Mailboxes are the foundation that File Gateway is built on top of — which is the single most common point of confusion I run into. File Gateway isn't a separate product competing with B2Bi; it's a purpose-built UI and routing layer sitting on top of B2Bi's mailbox and adapter capabilities, designed to make partner file exchange manageable without touching BPML directly.

**The Database.** Every Business Process's state, every document's tracking history, every audit trail — all of it lives in B2Bi's database. This is easy to overlook until your first real outage, at which point you learn fast that document tracking data is often the only way to reconstruct what actually happened to a file.

**Clustering.** For production environments that can't tolerate downtime, B2Bi supports multi-node clusters, spreading load and providing failover. Worth knowing exists; not something a new admin needs to understand on day one.

## Putting it together

{{< mermaid >}}
flowchart TB
    subgraph Partners["Trading Partners"]
        P1["Partner A"]
        P2["Partner B"]
    end

    subgraph DMZ["DMZ"]
        PS["Perimeter Server"]
    end

    subgraph Core["B2B Integrator Core"]
        AD["Adapters<br/>SFTP / AS2 / Connect:Direct / HTTP"]
        BP["Business Processes<br/>(BPML Engine)"]
        SV["Services<br/>Mapping / Validation / Routing"]
        MB["Mailboxes"]
        FG["File Gateway<br/>(UI layer over Mailboxes)"]
    end

    DB[("Database<br/>Document Tracking & State")]

    P1 --> PS
    P2 --> PS
    PS --> AD
    AD --> BP
    BP --> SV
    SV --> MB
    FG -.manages.-> MB
    BP <--> DB
    MB <--> DB
{{< /mermaid >}}

A file comes in through a Perimeter Server, hits an Adapter, gets picked up by a Business Process, passes through whatever Services that process calls (mapping, validation, whatever the workflow needs), and lands in a Mailbox — with the Database recording every step along the way. File Gateway sits on top of that same Mailbox layer, giving partner-facing operations a manageable interface instead of a BPML canvas.

## What's next

Next up in this series: **Adapters vs. Services** — the distinction that trips up almost everyone in their first few weeks with Sterling, and the one that actually matters most for troubleshooting.
