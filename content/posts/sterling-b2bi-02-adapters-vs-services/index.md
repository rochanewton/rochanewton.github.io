---
title: "Adapters vs. Services in IBM Sterling B2B Integrator: The Distinction That Actually Matters"
date: 2026-09-08
description: "Why 'adapter' and 'service' aren't interchangeable jargon in Sterling B2B Integrator, and why getting this straight saves you real time when a Business Process breaks at 2am."
tags: ["ibm-sterling", "b2bi", "mft", "middleware", "architecture"]
categories: ["Middleware"]
series: ["sterling-b2bi-architecture"]
series_order: 2
showAuthor: true
image: "cover.png"
---

A few weeks into my first Sterling project, someone on a call asked me to "check the adapter" for a failing file transfer. I went straight to the adapter config, found nothing wrong, and spent another twenty minutes convinced I was losing my mind before I realized the actual failure was three steps later, inside a service doing field validation. Nobody had lied to me — they'd just used "adapter" the way most people use "the internet": as a catch-all for the whole pipe, not the specific part. That mix-up cost me twenty minutes. It's cost other people entire afternoons.

So this post is the one I wish someone had sent me back then: what an adapter actually is, what a service actually is, and where the line between them sits.

## The one-sentence version

Every adapter is a service. Not every service is an adapter.

That's the whole distinction, and it's worth sitting with for a second, because it explains almost every confusing conversation you'll have about this platform. "Service" is the broad category — a unit of work the Business Process Engine can execute as a step. "Adapter" is a specific kind of service: one whose job is to talk to something outside Sterling B2B Integrator.

## What makes something a service

IBM's documentation defines a service as a set of instructions the Business Process Engine uses to carry out an activity inside a Business Process. That's deliberately broad, because services cover a huge range of work: mapping a document from one format to another, validating a field against a schema, encrypting a payload, checking a condition and branching, even pausing a process to wait for a human to click "approve" in a web form.

The thread connecting all of that is that a service does its work using data the Business Process already has, or produces data the Business Process will use next. It doesn't need to reach outside the system to do its job.

## What makes something an adapter

Adapters are the subset of services whose entire purpose is reaching outside the system — connecting the Business Process Engine to "dissimilar systems and applications" that live outside the Sterling B2B Integrator environment ([IBM Documentation](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=integrator-services-adapters)). An SFTP adapter opens a connection to a partner's SFTP server. An AS2 adapter speaks the AS2 protocol to a trading partner's gateway. A JDBC adapter talks to an external database. Same underlying mechanism as any other service — the Business Process Engine calls it, it runs, it returns a result — but the work itself happens somewhere else.

<!--
IMAGE IDEA: side-by-side screenshot from the admin console showing an
Adapter configuration screen (e.g. SFTP Adapter) next to a Service
configuration screen (e.g. a mapping or validation service), so the visual
similarity — and the practical difference — is obvious at a glance. To add:
![Adapter configuration next to a Service configuration in the Sterling admin console](adapter-vs-service-config.png)
-->

There's a useful three-way split worth knowing, because it comes up constantly once you start reading Business Process logs: internal services process parameters and produce results without ever leaving the system; input and output adapters are the ones that reach outward — receiving from or sending to something external; and a separate category, human interaction services, exist purely to pause a process until a person acts, typically through a web browser approving or rejecting a step. That last category trips people up the most, because it's technically "just a service," but it behaves nothing like the mapping-and-validation services people picture by default.

## Why the distinction actually matters

Here's the part that's easy to miss until it costs you time: adapters and services fail differently, and they get diagnosed in different places.

An adapter failure is almost always about the outside world — a partner's server is down, a certificate expired, a firewall rule changed, a network path got blocked. You fix it by checking connectivity, credentials, and the partner's side of the handshake. The Business Process itself is usually innocent; it's just waiting on a door that won't open.

A service failure is almost always about the data. A map choked on an unexpected field. A validation rule rejected something that used to pass. A condition branched somewhere nobody expected. You fix it by looking at the actual document moving through the process, not at connectivity settings.

Confuse the two and you end up doing exactly what I did on that first project: checking network settings for a data problem, or picking apart a map for a problem that was actually a partner's server timing out. The fastest diagnostic question I know for Sterling incidents is simply: "did this fail trying to reach something outside the system, or while working on data already inside it?" That question alone routes you to the right half of the Business Process almost every time.

## Where this sits in the bigger picture

Adapters sit at the two edges of the flow from [Part 1](/posts/sterling-b2bi-01-overview/) — receiving a file from a Perimeter Server on the way in, or handing a file off to a partner on the way out. Services sit in the middle, doing everything that happens to a file once it's inside the walls: mapping, validating, routing, occasionally waiting on a human. A Business Process is really just a sequence of calls to both, with branching logic stitching them together.

{{< mermaid >}}
flowchart LR
    subgraph Outside["Outside the System"]
        Partner["Trading Partner"]
    end

    subgraph BP["Business Process"]
        direction TB
        A1["Input Adapter<br/>(SFTP / AS2 / HTTP)"]
        S1["Service<br/>Validate"]
        S2["Service<br/>Map"]
        S3["Human Interaction Service<br/>(optional approval step)"]
        A2["Output Adapter<br/>(SFTP / AS2 / Connect:Direct)"]
        A1 --> S1 --> S2 --> S3 --> A2
    end

    Partner -->|inbound file| A1
    A2 -->|outbound file| Partner

    classDef adapter fill:#0f62fe,color:#fff,stroke:#0f62fe
    classDef service fill:#393939,color:#fff,stroke:#393939
    class A1,A2 adapter
    class S1,S2,S3 service
{{< /mermaid >}}

Blue is "leaves the system." Gray is "stays inside." When something breaks, that color is the first thing I check.

## Sources & further reading

- [Sterling B2B Integrator — Services and Adapters](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=integrator-services-adapters)
- [Sterling B2B Integrator — Services and Adapters (A–L)](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=adapters-sterling-b2b-integrator-services-l)
- [Sterling B2B Integrator — Services and Adapters (M–Z)](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=adapters-sterling-b2b-integrator-services-m-z)
- [Business Processes](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=integrator-business-processes)

As with Part 1, the framing and the war stories are mine — the definitions are IBM's.

## What's next

Next up: **Business Processes and BPML (Business Process Model Language)**, the actual workflow engine tying every adapter and service call together — including why the visual Graphical Process Modeler and the raw BPML underneath it are worth understanding as two views of the same thing, not two separate tools.
