---
title: "Perimeter Servers in IBM Sterling B2B Integrator: Why the DMZ Box Calls Home Instead of the Other Way Around"
date: 2026-09-08
description: What a Perimeter Server actually is, the reverseConnect mechanic that lets the DMZ box dial in instead of opening a hole into your core network, embedded vs. remote perimeter servers, how this differs from Sterling Secure Proxy, and the real troubleshooting scenarios that come up running one.
tags:
  - ibm-sterling
  - b2bi
  - mft
  - middleware
  - architecture
  - perimeter-server
  - dmz
  - network-security
categories:
  - IBM Sterling
series:
  - sterling-b2bi-architecture
series_order: 6
showAuthor: true
image: cover.png
---

## The connection runs backward from what you'd guess

Most people's first assumption about a box sitting in the DMZ is that your trusted, internal network reaches out to it — the secure side initiates, the exposed side listens. A Perimeter Server does the opposite. The core B2Bi engine sitting safely inside your network never opens a connection out into the DMZ at all. Instead, the Perimeter Server — the box actually facing partners and the internet — dials *back in* to the core engine and holds that connection open. Partner traffic lands on the DMZ box first, and only then gets forwarded inward over a channel the DMZ side itself established.

I called this component out in [Part 1]({{< ref "/posts/sterling-b2bi-01-overview/" >}}) and promised to come back to it, because most intro material skips it entirely — which is a shame, since it's the actual reason a Sterling deployment diagram has boxes sitting outside the firewall in the first place, and it's the detail that makes the whole DMZ story click once you understand which direction the wire actually runs. Side by side, the assumption and the reality look like this:

{{< mermaid >}}
flowchart TB
    subgraph Assumed["What you'd assume"]
        direction LR
        C1["Core Engine\n(trusted zone)"]
        FW1{{"Inner Firewall"}}
        PS1["Perimeter Server\n(DMZ)"]
        C1 -- "Core opens a new\nconnection into the DMZ" --> FW1
        FW1 -- "requires an inbound\nallow rule from the DMZ" --> PS1
    end

    subgraph Actual["What actually happens"]
        direction LR
        PS2["Perimeter Server\n(DMZ)"]
        FW2{{"Inner Firewall"}}
        C2["Core Engine\n(trusted zone)"]
        PS2 -- "PS dials out\n(reverseConnect)" --> FW2
        FW2 -- "outbound-only rule —\nno inbound hole needed" --> C2
    end

    style FW1 fill:#4a1a1a,stroke:#c0392b
    style FW2 fill:#12331a,stroke:#27ae60
{{< /mermaid >}}

The top half is the rule your inner firewall would need if the core engine reached outward into the DMZ — an inbound allow rule that lets a DMZ host initiate traffic into the trusted zone, which is precisely the kind of hole a DMZ exists to prevent. The bottom half is what a Perimeter Server actually requires: an outbound-only rule, and nothing listening for connections from the DMZ side at all.

## What a Perimeter Server is

A Perimeter Server is a lightweight, standalone process that sits in the DMZ and terminates the protocol handshake with the outside world — SFTP, FTP/FTPS, HTTP/S, AS2, Connect:Direct, OdetteFTP, SOAP — on B2Bi's behalf. It doesn't run Business Processes, doesn't touch mailboxes, and doesn't hold trading partner configuration. Its entire job is socket management: accept the connection, manage the session and thread, and hand the traffic off to the real engine over a secure channel, so the engine itself — with the database, the document tracking history, every partner's file — never has to sit anywhere near a public-facing interface ([IBM Documentation](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=servers-perimeter-in-sterling-b2b-integrator)).

That's the whole value proposition in one sentence: it lets you expose partner-facing endpoints without ever putting the core engine within reach of the public internet. Beyond the security boundary, IBM also documents a performance angle — session and thread management on the DMZ box reduces the load the core engine has to carry directly, which matters more than it sounds like once you're running dozens of partners with very different traffic profiles through the same node.

## Embedded vs. remote: two very different deployments hiding behind one name

"Perimeter Server" refers to two distinct setups, and conflating them is a common source of confusion:

**Embedded (local) Perimeter Server.** Bundled directly inside B2Bi itself — no separate install, no DMZ placement. It exists so adapters that expect a perimeter server assignment have something to point at in a lab, a dev environment, or any deployment where you genuinely don't need a DMZ boundary. It provides none of the actual security separation a remote one does.

**Remote (installed) Perimeter Server.** A separate installation, deployed on its own host physically or logically inside the DMZ, independent of the B2Bi installation itself. This is the one doing real work in any production topology — the one partner traffic actually hits.

Multiple remote Perimeter Servers can run against a single B2Bi node at once, which is what lets you segment traffic deliberately: one DMZ box handling high-volume SFTP from your largest trading partners, a separate one for a partner whose security team insists on physically isolated infrastructure, without touching the core engine's configuration to add either. That per-adapter assignment is exactly the field you'd have glossed over in [Part 2's]({{< ref "/posts/sterling-b2bi-02-adapters-vs-services/" >}}) SFTP Client Adapter screenshot — "system name, environment, a perimeter server assignment, and thread limits" was doing a lot of quiet work in that one line.

## The reverseConnect mechanic

Here's the part that surprises people who've worked with reverse proxies before and expect the usual direction of trust: the remote Perimeter Server initiates the connection to the core engine, not the other way around. IBM's own support documentation for the `remote_perimeter.properties` file that configures this lists exactly the parameters you'd expect for that model — `reverseConnect`, `remoteAddress`, `remotePort`, and a local `port` ([IBM Support](https://www.ibm.com/support/pages/need-more-information-about-remoteperimeterproperties-parameters-remote-perimeter-server-sterling-b2b-integrator)) — and community documentation of the same mechanism describes the remote Perimeter Server establishing a persistent connection back to the core system, commonly on port 9999 ([Pronteff](https://pronteff.com/ibm-sterling-perimeter-server/)).

Why build it this way instead of letting the core engine reach out to the DMZ? Because it means your inner firewall never needs an inbound rule that lets a DMZ host initiate traffic into your trusted network's listening ports — the DMZ box only ever *originates* the one connection it needs, and everything after that rides inside it. That single design decision is the reason the topology works at all without opening the exact kind of hole a DMZ exists to prevent.

{{< mermaid >}}
sequenceDiagram
    participant Partner
    participant PS as Perimeter Server (DMZ)
    participant Core as B2Bi Core Engine (trusted zone)

    Note over PS,Core: Persistent connection established first —<br/>PS dials Core, not the other way around
    PS->>Core: Outbound connect (reverseConnect, typically port 9999)
    Core-->>PS: Connection accepted, held open

    Partner->>PS: Connect (SFTP / AS2 / HTTP)
    PS->>PS: Terminate protocol handshake
    PS->>Core: Forward session over the existing channel
    Core->>Core: Hand off to Adapter → Business Process
    Note over Partner,Core: Inner firewall never has to accept<br/>an inbound connection initiated from the DMZ
{{< /mermaid >}}

That sequence hides an important detail: at the network layer, there are really two separate connections doing two separate jobs, not one. Laid out as a topology instead of a timeline, it looks like this:

{{< mermaid >}}
flowchart LR
    subgraph Internet["Internet"]
        Partner["Trading Partner"]
    end

    subgraph DMZ["DMZ"]
        PS["Perimeter Server"]
    end

    subgraph Trusted["Trusted Zone"]
        Core["B2Bi Core Engine"]
    end

    PS == "1 — outbound, PS-initiated\npersistent control channel\n(reverseConnect, port 9999)" ==> Core
    Partner -- "2 — inbound to PS only\n(SFTP / AS2 / HTTP)" --> PS
    PS -. "3 — partner session tunneled\nover the channel opened in step 1" .-> Core
{{< /mermaid >}}

Step 1 has to happen first and stays up continuously — it's infrastructure, not per-session traffic. Step 2 is the only connection a partner ever makes, and it terminates at the Perimeter Server; it never becomes a second, independent connection reaching into the trusted zone. Step 3 isn't a new connection at all — it's the partner's session riding inside the channel that already exists from step 1. From the inner firewall's point of view, exactly one connection ever crosses the boundary, and the DMZ box is the one that opened it.

*(Screenshot placeholder: the "Add Perimeter Server" screen in the admin console — Deployment > Perimeter Servers > Add — showing the name, description, and the local/embedded vs. remote type selector. Worth a second screenshot of a configured remote Perimeter Server's detail view if the `remote_perimeter.properties` values are visible there.)*

## Perimeter Server vs. Sterling Secure Proxy — not the same product

This is the other recurring source of confusion, and it's worth being precise about it: **Sterling Secure Proxy (SSP)** is a separate IBM product, a full reverse-proxy and DMZ security gateway with its own session-breaking, protocol filtering, and credential-mapping capabilities well beyond what a Perimeter Server does. They get conflated constantly because SSP deployments also involve a "Parameter Server" component installed in front of it and because both products live in the same DMZ-facing part of a Sterling architecture diagram ([IBM Support](https://www.ibm.com/support/pages/what-parameter-server-needs-be-installed-ibm-sterling-secure-proxy)). If a job posting or a colleague says "perimeter server" and means session-breaking proxy behavior, full protocol inspection, or credential mapping between an external and internal identity, they're almost certainly describing SSP, not the plain Perimeter Server this post covers. The plain Perimeter Server is a much narrower, much simpler component — it moves bytes securely across the DMZ boundary; it doesn't inspect, transform, or authenticate anything on its own.

## Operational scenarios

**"Partners can connect but files never show up."** Check which Perimeter Server the failing adapter is actually assigned to before anything else — with multiple remote Perimeter Servers on one node, a partner landing on the wrong one (or one that's down) looks identical to a network problem from the partner's side, but it's a configuration mismatch on yours.

**`CloseCode.NO_AVAILABLE_PORT` in `perimeter.log`.** This one shows up as a bind failure — `java.net.BindException: Cannot assign requested address` — when the Perimeter Server can't allocate a port for a new session ([IBM Support](https://www.ibm.com/support/pages/perimeter-server-connection-sterling-b2b-integrator-remote-perimeter-server-dmz-fails-closecodenoavailableport)). In practice this is almost always port exhaustion under load or a local firewall/OS rule capping the ephemeral port range on the DMZ host — check the DMZ host's own port range and any host-level firewall rules before assuming it's a B2Bi-side problem. Worth remembering this is genuinely separate from the mailbox and Business Process world — it's a lower-level, network-layer failure.

**Two log files, two different failure classes.** Perimeter connection and session issues live in `perimeter.log`, on the Perimeter Server host itself. Issues on the core engine side of the handoff — the Perimeter Services Manager registering or losing a connected Perimeter Server — show up in the core engine's own logs instead. Chasing a connectivity issue in the wrong log is a fast way to lose twenty minutes for nothing; if a partner-facing protocol adapter is failing to receive connections at all, `perimeter.log` on the DMZ box is the first stop, not the core engine's application log.

**A Perimeter Server "goes missing" after a restart.** Because the DMZ side owns the connection, a restart order matters: if the core engine comes back up before the remote Perimeter Server reconnects, adapters assigned to that Perimeter Server will show it as unavailable until the DMZ-side process re-establishes its outbound connection. This is expected behavior, not corruption — it just means restart runbooks for a B2Bi environment with remote Perimeter Servers need to account for both sides coming back, not just the core engine.

## Where this fits in the series

Perimeter Server is the piece from [Part 1's]({{< ref "/posts/sterling-b2bi-01-overview/" >}}) topology diagram that got a one-paragraph mention and nothing else until now. It's the first thing a partner's connection touches — before the [Adapter]({{< ref "/posts/sterling-b2bi-02-adapters-vs-services/" >}}), before the Business Process, before the file ever reaches a [Mailbox]({{< ref "/posts/sterling-b2bi-05-mailboxes-file-gateway/" >}}). Every piece from that original diagram now genuinely has its own post behind it.

## Sources & further reading

- [Perimeter servers in Sterling B2B Integrator — IBM Documentation](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=servers-perimeter-in-sterling-b2b-integrator)
- [Perimeter Server overview — IBM Documentation (6.1.2)](https://www.ibm.com/docs/en/b2b-integrator/6.1.2?topic=servers-perimeter-server-overview)
- [Need more information about remote_perimeter.properties parameters — IBM Support](https://www.ibm.com/support/pages/need-more-information-about-remoteperimeterproperties-parameters-remote-perimeter-server-sterling-b2b-integrator)
- [Perimeter Server connection fails with CloseCode.NO_AVAILABLE_PORT — IBM Support](https://www.ibm.com/support/pages/perimeter-server-connection-sterling-b2b-integrator-remote-perimeter-server-dmz-fails-closecodenoavailableport)
- [What Parameter Server needs to be installed with IBM Sterling Secure Proxy? — IBM Support](https://www.ibm.com/support/pages/what-parameter-server-needs-be-installed-ibm-sterling-secure-proxy)
- [What is IBM Sterling Perimeter Server? — Pronteff](https://pronteff.com/ibm-sterling-perimeter-server/)

As with the rest of this series: the definitions and the documented parameters are IBM's (and IBM Support's), the framing, the diagram, and the operational scenarios are mine.

## What's next

Next up: **The Map Editor** — the translation layer flagged back in [Part 1]({{< ref "/posts/sterling-b2bi-01-overview/" >}}), and the source of some of the gnarliest bugs I've chased in production.
