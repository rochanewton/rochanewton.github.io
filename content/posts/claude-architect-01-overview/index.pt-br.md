---
title: "Tornando-se um Claude Architect: Visão Geral — Claude Certified Architect – Foundations"
date: 2026-09-24
description: "Uma nova certificação, uma nova série. O Claude Certified Architect – Foundations testa se você consegue projetar sistemas com Claude que outras pessoas vão construir em cima — não só usar bem o Claude. Veja o que a prova cobre e o que esta série vai percorrer."
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

## Do que se trata

O **Claude Certified Architect – Foundations** é a certificação da Anthropic para projetar sistemas com Claude, não só usá-los. Enquanto a prova Claude Certified Associate testa se você consegue operar o Claude com disciplina profissional — bons prompts, julgamento sólido sobre o resultado, o ponto de entrada certo para o trabalho —, a prova Architect testa um nível acima: você consegue projetar o sistema agêntico, as integrações de ferramentas e a configuração sobre os quais outras pessoas vão construir. O candidato ideal tem 6+ meses de experiência prática construindo com a API do Claude, o Claude Agent SDK, o Claude Code e o Model Context Protocol (MCP) — essa não é uma primeira certificação, é a próxima.

Isso abre uma nova série, **Tornando-se um Claude Architect**, separada da minha série [Getting Claude Certified]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}) sobre a prova Associate. Se você ainda não fez essa, é o ponto natural para começar — esta série assume que os hábitos de fluência daquela já estão consolidados.

## Ponto-chave 1: a prova, em números

60 itens, múltipla escolha e múltipla resposta, 120 minutos, aplicada com proctoring online ou em centro de testes. A aprovação é uma pontuação escalonada de 720 em uma escala de 100 a 1.000 — a Anthropic não publica a conversão de acertos brutos para pontuação escalonada, então "720" não é "72% das questões certas", é uma régua calibrada. A credencial custa $125 e vale por 12 meses, e o resultado volta como aprovado/reprovado mais um detalhamento de percentual de acerto por domínio, então você sabe exatamente onde focar numa segunda tentativa.

## Ponto-chave 2: cinco domínios, um claramente mais pesado

{{< mermaid >}}
flowchart LR
    A[Agentic Architecture<br/>& Orchestration — 27%] --> F[Prova Architect]
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

![Gráfico de barras horizontais intitulado "Onde a prova Architect coloca o peso dela," mostrando os 5 domínios da prova Claude Certified Architect – Foundations ordenados por porcentagem: Agentic Architecture and Orchestration com 27%, Claude Code Configuration and Workflows com 20%, Prompt Engineering and Structured Output com 20%, Tool Design and MCP Integration com 18%, e Context Management and Reliability com 15%](domain-weights-chart.webp "Agentic Architecture and Orchestration sozinho vale mais que os dois domínios mais leves somados")

Agentic Architecture & Orchestration carrega mais peso que qualquer outro domínio isolado — mais de um quarto da prova —, o que mostra onde a Anthropic acredita estar a real lacuna de habilidade entre alguém que usa bem o Claude e alguém que projeta sistemas com Claude: não em conhecer a superfície da API, mas em projetar como o trabalho autônomo é orquestrado, repassado e mantido confiável.

## Ponto-chave 3: habilidade de uso e habilidade de arquitetura são provas diferentes por um motivo

Ser bom em prompting não torna alguém automaticamente bom em decidir quando um workflow deveria virar um sistema multiagente, como deveria ser a interface de uma ferramenta para um LLM que a chama às cegas, ou como um deployment do Claude Code deveria ser configurado para um time confiar nele em produção. A prova Associate testa julgamento dentro de uma única conversa. A prova Architect testa julgamento sobre o sistema ao redor da conversa — as partes que um bom prompt sozinho não resolve.

## Ponto-chave 4: o que esta série vai cobrir

Mais seis posts seguem este, cada um cobrindo um domínio na ordem do guia da prova: Agentic Architecture & Orchestration, Tool Design & MCP Integration, Claude Code Configuration & Workflows, Prompt Engineering & Structured Output, e Context Management & Reliability. A série se encerra com um conjunto interativo de 100 questões práticas — 20 por domínio, clique numa resposta e veja na hora se está certa — construído como material de estudo não oficial depois que os cinco posts de domínio estiverem prontos.

## Conclusão

O Claude Certified Architect – Foundations em uma passada: é a certificação seguinte depois da Associate, não uma versão mais difícil da mesma — ela testa design de sistemas, não disciplina de uso. 60 itens, 120 minutos, um 720 escalonado para passar. Agentic Architecture & Orchestration é o domínio a levar mais a sério, com 27% da prova, com Claude Code Configuration & Workflows e Prompt Engineering & Structured Output empatados logo atrás, com 20% cada. Seis posts domínio por domínio e um quiz prático vêm a seguir.

## Fontes

- [Claude Certified Architect – Foundations Certification — Anthropic Partner Academy](https://anthropic-partners.skilljar.com/claude-certified-architect-foundations-certification)
- [Claude Certified Architect – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542750%2FClaude+Certified+Architect+%E2%80%93+Foundations+Exam+Guide.pdf) — PDF oficial

## Onde isso se encaixa

Parte 1 de **Tornando-se um Claude Architect**. Esta série continua a partir de [Getting Claude Certified]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}), minha série de 9 partes sobre a prova Claude Certified Associate – Foundations — comece por lá se você ainda está começando com o Claude. A Parte 2 assume o Domínio 1 — Agentic Architecture & Orchestration.
