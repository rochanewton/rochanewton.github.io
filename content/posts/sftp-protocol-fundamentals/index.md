---
title: "SFTP, FTP, FTPS: Protocol Behind the Adapters"
date: 2026-09-10
description: "FTP, FTPS, and SFTP explained protocol by protocol — how each one actually works, ports, security, when to use and when to avoid — then a deep focus on SFTP/SSH: key pairs, key formats, ciphers, and MACs, since that's what carries most B2Bi partner traffic."
tags:
  - sftp
  - ftp
  - ftps
  - ssh
  - networking
  - security
  - ibm-sterling
  - mft
  - middleware
categories:
  - Middleware
series:
  - sterling-b2bi-architecture
series_order: 4
showAuthor: true
image: cover.png
---

## Three protocols, one job, very different guts

FTP, FTPS, and SFTP all claim to do the same thing — move a file from one place to another — and partners use the names almost interchangeably, which is exactly the problem. They are three genuinely different protocols with different port models, different security properties, and different failure modes, and the [SFTP Server Adapter and SFTP Client Adapter](/posts/sterling-b2bi-02-adapters-vs-services/) you configure in Sterling only make sense once you know which one you're actually running. This post goes through each one on its own terms, then spends the back half on SFTP specifically, since that's what carries the overwhelming majority of partner traffic in B2Bi.

## What is FTP

**File Transfer Protocol**, defined all the way back in [RFC 959](https://www.rfc-editor.org/rfc/rfc959) (1985), is the oldest of the three and the one everything else is reacting to. Its defining, and defeating, characteristic is that it uses **two separate TCP connections**: a control connection that stays open for the session and carries commands and responses, and a completely separate data connection that gets opened fresh for every file transfer or directory listing.

{{< mermaid >}}
sequenceDiagram
    participant Client
    participant Server

    Client->>Server: TCP connect, port 21 (control)
    Server->>Client: Welcome banner
    Client->>Server: USER / PASS (plaintext)
    Server->>Client: Login OK
    Note over Client,Server: Control connection stays open

    rect rgb(40,40,40)
    Note over Client,Server: Active mode
    Client->>Server: PORT (client's IP:port to connect back to)
    Server->>Client: Connects from port 20 to client's port
    end

    rect rgb(40,40,40)
    Note over Client,Server: Passive mode
    Client->>Server: PASV
    Server->>Client: Here's a random high port to connect to
    Client->>Server: Connects to that port
    end

    Note over Client,Server: File data flows over this SECOND,<br/>separate connection — unencrypted
{{< /mermaid >}}

- **Ports:** 21 for control, plus either port 20 (active mode, server connects back to the client) or a random high port negotiated via `PASV` (passive mode, client connects out to the server). Active mode expects the server to open an inbound connection to the client — which almost never survives a NAT or a firewall today, so passive mode became the practical default.
- **Security:** none, by default. Username, password, commands, and the file contents themselves all cross the wire in plaintext. Anyone positioned on the network path can read credentials and data with a packet capture and zero effort.
- **Why it's still around:** legacy systems, internal-only transfers on networks already considered trusted, and some genuinely ancient partner integrations that predate anyone currently working on them.
- **Why not to use it for partner exchange:** plaintext credentials and plaintext file contents over the open internet is not a defensible position in 2026, full stop. If a partner asks for plain FTP today, that's a conversation, not a configuration task.

## What is FTPS

**FTP over TLS/SSL** (also written FTPES for the explicit variant) is FTP's attempt to fix the plaintext problem without redesigning the protocol — it wraps the *same* two-connection FTP model in TLS. This gets you encryption, but it inherits FTP's fundamental architecture problem: two connections still means two things to secure and two things that can fail independently.

{{< mermaid >}}
sequenceDiagram
    participant Client
    participant Server

    rect rgb(40,40,40)
    Note over Client,Server: Explicit FTPS (FTPES) — port 21
    Client->>Server: TCP connect, port 21
    Client->>Server: AUTH TLS
    Server->>Client: TLS handshake begins
    Note over Client,Server: Control connection now encrypted
    Client->>Server: USER / PASS (now encrypted)
    Client->>Server: PBSZ / PROT P (request encrypted data channel)
    Client->>Server: PASV → data connection, also TLS-wrapped
    end

    rect rgb(40,40,40)
    Note over Client,Server: Implicit FTPS — port 990
    Client->>Server: TCP connect, port 990
    Note over Client,Server: TLS handshake happens immediately,<br/>before any FTP command is sent
    end
{{< /mermaid >}}

- **Ports:** explicit FTPS negotiates TLS on the standard port 21 after connecting (`AUTH TLS`); implicit FTPS expects TLS immediately on a dedicated port, conventionally 990. Both still need a second data connection, which — because it's now TLS-wrapped too — makes passive-mode port ranges through a firewall even more of a headache than plain FTP, since the firewall has to allow a TLS session it can't inspect.
- **Security:** genuinely better than FTP — credentials and data are encrypted in transit, assuming TLS is configured correctly (cert validation, no ancient TLS versions left enabled). Still authenticates with a username and password by default, so you're trusting transport encryption alone unless certificate-based client auth is layered on top.
- **When to use it:** a partner's infrastructure standardized on FTPS specifically (common in some industries where it's a compliance default) and won't move to SFTP. It's a legitimate, secure-enough choice when configured properly.
- **Why I still default to SFTP over it:** the two-connection model doesn't go away just because it's encrypted — you're still fighting passive-mode port ranges and NAT/firewall interaction, just now with TLS in the mix too. SFTP sidesteps the entire category of problem.

## What is SFTP / SSH / SCP

This is the one that actually matters most for B2Bi, so it gets the rest of this post. First, the naming has to be untangled, because "SFTP is FTP over SSH" is the single most common thing people get wrong about it — and it isn't true. **SFTP — the SSH File Transfer Protocol — is a subsystem of [SSH](https://www.openssh.org/) itself**, not FTP wrapped in anything. It shares nothing with FTP's command set or connection model. One TCP connection, one negotiated encrypted channel, file operations defined as part of the SSH protocol family from the ground up.

{{< mermaid >}}
sequenceDiagram
    participant Client
    participant Server

    Client->>Server: TCP connect, port 22
    Client->>Server: SSH protocol version exchange
    Note over Client,Server: Algorithm negotiation:<br/>key exchange method, ciphers, MACs
    Client->>Server: Key exchange (e.g. curve25519-sha256)
    Server->>Client: Host key presented
    Note over Client,Server: Client checks host key against known_hosts —<br/>fails closed on mismatch
    Client->>Server: Authenticate (public key or password)
    Server->>Client: Authentication result
    Note over Client,Server: Single encrypted channel now established
    Client->>Server: Request "sftp" subsystem
    Note over Client,Server: All file operations (open, read, write,<br/>stat, rename, delete) run as binary<br/>packets inside this one channel
{{< /mermaid >}}

- **Ports:** one. Port 22, same as any SSH connection. No second data connection, no passive-mode range, nothing extra to open on a firewall.
- **Security:** strong by design — every packet, control and data alike, rides the same encrypted, integrity-checked channel established during the SSH handshake. Authentication supports both passwords and public-key auth (more on that below), and the server proves its own identity via its host key, which the client is supposed to verify against a trusted `known_hosts` entry before trusting anything that follows.
- **When to use it:** this is the default choice for new partner connections unless a partner's own security or compliance requirements specifically dictate something else. It's what I reach for first, and it's the overwhelming majority of what B2Bi partner traffic runs over in practice.
- **Why not FTP or FTPS instead:** no plaintext option to accidentally misconfigure into (FTP), and no second connection fighting your firewall (FTPS) — SFTP's single-channel model is just structurally simpler to secure correctly.

**SCP** deserves a mention here because it's SSH's *other* file-transfer subsystem and gets confused with SFTP constantly. [`scp(1)`](https://man.openbsd.org/scp.1) is older and much simpler than SFTP — effectively `cp` with an SSH transport, no directory listing, no resume support, no atomic rename. Modern OpenSSH has been quietly reimplementing SCP's client on top of SFTP internals for years, specifically because SFTP's protocol design is better in almost every respect. If you have a choice between the two today, choose SFTP — it's the actively maintained, more capable protocol, and it's what Sterling's client and server adapters implement.

Reference material worth having bookmarked rather than trusting secondhand explanations: [`ssh(1)`](https://man.openbsd.org/ssh.1) and [`sftp(1)`](https://man.openbsd.org/sftp.1), the canonical OpenBSD/OpenSSH man pages.

### Quick comparison

| | FTP | FTPS | SFTP |
|---|---|---|---|
| Connections | 2 (control + data) | 2, TLS-wrapped | 1 |
| Port(s) | 21 + dynamic/20 | 21 or 990 + dynamic | 22 |
| Encryption | None | TLS | SSH transport encryption |
| Auth | Username/password, plaintext | Username/password (+ optional client certs) | Password or public key |
| Firewall/NAT friendliness | Poor | Poor (TLS-wrapped data channel) | Good — single connection |
| Sterling adapter | FTP Adapter | FTP Adapter (SSL enabled) | SFTP Client/Server Adapter |

## SSH key pairs

Public-key authentication is the one you actually want for anything automated or partner-facing — no credential sitting in a script or scheduled job, no password rotation argument with a partner's security team, and it's what most SFTP Server Adapter trading partner configurations in B2Bi are built around.

**What it is:** a mathematically linked pair of keys generated together. The **private key** stays exactly where it was generated and is never transmitted anywhere, by design — if it leaves that machine, the key pair is considered compromised. The **public key** is the half meant to be shared freely; it gets dropped into an `authorized_keys` file on a plain OpenSSH server, or registered as the partner's known public key inside Sterling's trading partner configuration. Authentication works because the client can prove possession of the private key (by signing a challenge) without ever sending it anywhere — the server only ever needs the public half to verify that signature.

[`ssh-keygen(1)`](https://man.openbsd.org/ssh-keygen.1) is the tool that generates both halves.

**Key types and lengths:**

- **RSA** — the old reliable, and still what most legacy MFT stacks and older mainframe-adjacent tooling expect. 2048-bit is the practical floor today (modern OpenSSH refuses anything smaller by default); 3072- or 4096-bit is the safer choice for anything long-lived. `ssh-keygen -t rsa -b 4096`.
- **ed25519** — the modern default. Fixed key size (no length knob to get wrong), faster to generate and verify, and considered at least as strong as RSA-3072/4096 with far less key material. `ssh-keygen -t ed25519`. This is what I reach for first for any new key pair unless a partner's tooling genuinely can't parse it — which, with older systems, happens more often than you'd like.
- **ECDSA** — supported, occasionally seen, rarely my first pick given the NIST-curve concerns some security teams raise; ed25519 covers the same ground with less baggage.
- **DSA** — deprecated and disabled by default in current OpenSSH entirely. A partner insisting on it is really a conversation about how old their system is.

**Key file formats — the part that causes real friction during partner key exchange:**

- **OpenSSH's own private key format** (`-----BEGIN OPENSSH PRIVATE KEY-----`) has been the default since OpenSSH 7.8, and it's what `ssh-keygen` produces unless told otherwise.
- **PEM / PKCS#1** is the older private key format, still what plenty of non-OpenSSH tooling and older libraries expect. `ssh-keygen -m PEM` forces it when the other end can't parse the newer format.
- **SECSH public key format**, defined in [RFC 4716](https://www.rfc-editor.org/rfc/rfc4716), is a *public*-key interchange format some non-OpenSSH SFTP servers and legacy MFT platforms expect instead of OpenSSH's single-line `authorized_keys`-style format. `ssh-keygen -e` exports an OpenSSH-format public key into RFC 4716 form; `-i` imports one back.

In practice: a partner hands you a public key in whatever format their system produced, it doesn't match what your side wants, and the fix is a `ssh-keygen -e`/`-i` round-trip, not a re-generated key pair. Knowing these three formats exist turns a stuck partner onboarding into a two-minute fix.

## Ciphers and MACs

**What they are:** during the SSH key exchange step in the handshake diagram above, client and server each advertise an ordered list of supported algorithms and agree on the strongest one both sides support — a **cipher** for encrypting the data stream, and a **MAC (message authentication code)** for verifying that packets haven't been tampered with in transit. This negotiation is exactly what the SFTP Server Adapter's cipher and MAC preference fields (visible in the [Part 2](/posts/sterling-b2bi-02-adapters-vs-services/) screenshots) are configuring — not something Sterling-specific, it's SSH's own algorithm negotiation surfaced through an admin console.

**Why it matters:** SSH has been around long enough to accumulate algorithms that were reasonable choices a decade ago and are now considered weak or broken. A server that still offers them isn't necessarily compromised, but it's carrying avoidable risk, and it's routinely what security scans flag on an MFT server.

**Good, current choices** (what modern OpenSSH defaults to and what I'd want a partner connection actually using):

- Ciphers: `chacha20-poly1305@openssh.com`, `aes256-gcm@openssh.com`, `aes128-gcm@openssh.com`
- MACs: the `-etm` (encrypt-then-MAC) variants — `hmac-sha2-256-etm@openssh.com`, `hmac-sha2-512-etm@openssh.com` — preferred over their non-ETM equivalents because encrypt-then-MAC avoids some cryptographic pitfalls that MAC-then-encrypt is exposed to.

**Weak or deprecated — should not appear in an active configuration:**

- Ciphers: `3des-cbc` (slow and cryptographically tired), `arcfour`/`arcfour128`/`arcfour256` (RC4-based, broken), any plain `-cbc` mode cipher where a GCM or ChaCha20 alternative is available.
- MACs: `hmac-md5` and `hmac-sha1` (MD5 and SHA-1 are both considered too weak for this use), and non-ETM MACs generally, if the ETM variant is supported by both ends.

The authoritative, current list of what OpenSSH supports — and how to set explicit preference order — lives in [`ssh_config(5)`](https://man.openbsd.org/ssh_config.5) and [`sshd_config(5)`](https://man.openbsd.org/sshd_config.5). The practical rule I follow: default to current OpenSSH recommended defaults, and only add an older cipher or MAC to the allowed list for the one specific partner connection that genuinely needs it — never globally, and never permanently without a ticket to revisit and remove it later.

## Operations that trip people up

**Partial file reads.** A partner's automated job starts polling a mailbox the instant a file starts uploading, and picks up a half-written file. The fix is operational, not protocol-level: upload to a temp filename, then rename atomically once the transfer completes. SFTP supports atomic rename as a native operation; use it.

**"It works in FileZilla but not from our system."** Almost always an authentication method mismatch (the GUI client remembered a saved password; the automated job is trying key auth with the wrong key) or a host key that changed and the automated client is failing closed on a `known_hosts` mismatch while the GUI client just clicked through a warning dialog. Check both before assuming it's a network issue.

**Thread and connection limits.** The SFTP Client Adapter config from Part 2 has explicit thread limits for a reason — a partner running a burst of parallel transfers against a shared adapter can exhaust connection slots for every other partner sharing it. Worth knowing your adapter's limits before a partner asks "can we push 200 files at once."

**Host key changes without warning.** Partners rebuild servers and rotate keys without telling you in advance. A strict `known_hosts` policy is the right default, but it means every unannounced rotation is a failed connection until someone manually verifies and accepts the new key — worth a documented, fast verification path rather than reaching for "just disable strict checking," which defeats the entire point. This happens often enough, and has enough nuance, that it gets its own post: [SSH known_hosts: How Host Key Verification Actually Works](/posts/ssh-known-hosts-host-key-verification/).

## Where this fits in Sterling

Everything above is protocol-level and applies to any FTP, FTPS, or SFTP server or client — IBM or otherwise. What Sterling adds is an admin-console UI over exactly these concepts: the SFTP Server Adapter's host identity key field *is* the server's SSH host key pair; its cipher and MAC preference lists *are* the `ssh_config`/`sshd_config` negotiation lists described above; a trading partner's registered public key *is* an `authorized_keys` entry, just stored in Sterling's trading partner configuration instead of a flat file; and the plain FTP Adapter with SSL enabled is exactly the FTPS handshake diagrammed above. None of it is Sterling reinventing these protocols — it's Sterling exposing their native configuration surface through a console, which is why understanding the protocols underneath makes the adapter screens from [Part 2](/posts/sterling-b2bi-02-adapters-vs-services/) make a lot more sense on a second look.

## Sources & further reading

- [RFC 959 — File Transfer Protocol](https://www.rfc-editor.org/rfc/rfc959)
- [OpenSSH](https://www.openssh.org/)
- [`ssh(1)`](https://man.openbsd.org/ssh.1)
- [`sftp(1)`](https://man.openbsd.org/sftp.1)
- [`scp(1)`](https://man.openbsd.org/scp.1)
- [`ssh-keygen(1)`](https://man.openbsd.org/ssh-keygen.1)
- [`ssh_config(5)`](https://man.openbsd.org/ssh_config.5)
- [`sshd_config(5)`](https://man.openbsd.org/sshd_config.5)
- [RFC 4716 — The Secure Shell (SSH) Public Key File Format](https://www.rfc-editor.org/rfc/rfc4716)
- [IBM Documentation: Services & Adapters](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=integrator-services-adapters)

As with the rest of this series: the protocol definitions, RFCs, and man page content are the authoritative sources linked above, the framing, the comparisons, and the operational advice are mine.

## What's next

Next up: **Mailboxes and File Gateway** — untangling the confusion flagged back in [Part 1](/posts/sterling-b2bi-01-overview/), with a closer look at how File Gateway's routing actually sits on top of the mailbox and adapter machinery underneath it. Read it here: [Part 5](/posts/sterling-b2bi-05-mailboxes-file-gateway/).
