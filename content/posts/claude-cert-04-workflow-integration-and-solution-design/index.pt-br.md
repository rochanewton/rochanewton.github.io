---
title: "Claude Certified Associate – Foundations: Domínio 2 — Integração de Workflow e Design de Soluções"
date: 2026-09-14
description: O Domínio 2 vale 16% da prova de certificação Claude. Não é sobre se um resultado é bom — é sobre decidir onde o Claude realmente se encaixa em um workflow, e onde não se encaixa.
tags:
  - claude
  - anthropic
  - certification
  - workflow-integration
  - solution-design
  - ai-fluency
categories:
  - Claude
series:
  - getting-claude-certified
series_order: 4
showAuthor: true
image: cover.png
---

## Do que se trata

O Domínio 2 da prova [Claude Certified Associate – Foundations](https://anthropic-partners.skilljar.com/claude-certified-associate-foundations-certification) é **Integração de Workflow e Design de Soluções**. Vale 16% — atrás apenas de Avaliação de Resultados, que a [Parte 3]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}) já cobriu. Enquanto aquele domínio perguntava "esse resultado específico é bom?", este faz uma pergunta diferente: **onde o Claude realmente se encaixa dentro de um workflow feito de múltiplas etapas, sistemas e pessoas — e onde ele não se encaixa?** Acertar uma resposta individual não importa muito se você a conectou no lugar errado do processo.

## Peso do domínio

![Gráfico de barras horizontais intitulado "Onde a prova realmente coloca o peso dela," mostrando os 7 domínios da prova Claude Certified Associate – Foundations ordenados por porcentagem: Output Evaluation and Validation com 21%, Workflow Integration and Solution Design com 16% destacado em azul, seguido por Governance Risk and Responsible Use com 15%, Prompting and Task Execution com 14%, Product and Model Selection com 12%, Configuration and Knowledge Management com 12%, e Troubleshooting and Optimization com 10%](domain-weights-chart.webp "Integração de Workflow e Design de Soluções é o segundo domínio mais pesado da prova, logo atrás de Avaliação de Resultados")

## Ponto-chave 1: três padrões de interação, não um só

O Claude se encaixa em uma solução de três formas diferentes, cada uma com um custo e uma necessidade de supervisão diferentes: **chamadas aumentadas**, em que um humano executa cada etapa e o Claude assiste uma chamada de cada vez; **workflows**, em que o Claude executa sozinho uma sequência fixa e previsível de etapas; e **agentes**, em que o Claude planeja suas próprias etapas para atingir um objetivo. A autonomia aumenta a cada estágio — e o custo de dar errado sem supervisão aumenta junto.

![Gráfico de barras horizontais intitulado "Três formas do Claude se encaixar em uma solução," mostrando autonomia e necessidade de supervisão crescentes em três padrões de interação: Chamadas aumentadas (humano executa cada etapa, menor risco), Workflows (Claude executa uma sequência fixa, moderado), e Agentes (Claude planeja suas próprias etapas, maior necessidade de supervisão)](interaction-spectrum.webp "Autonomia e o custo de dar errado sobem juntos — escolha o padrão que combina com quanta supervisão a tarefa realmente precisa")

Escolher entre os três se resume a duas perguntas: a tarefa precisa de mais de uma etapa, e ela precisa que o Claude decida as etapas sozinho?

{{< mermaid >}}
flowchart TD
    A[Nova tarefa] --> B{Mais de<br/>uma etapa?}
    B -->|Não| C[Chamada aumentada<br/>humano executa, Claude assiste]
    B -->|Sim| D{Etapas são fixas<br/>e previsíveis?}
    D -->|Sim| E[Workflow<br/>Claude executa a sequência fixa]
    D -->|Não, Claude precisa<br/>decidir as etapas| F[Agente<br/>Claude planeja e se adapta ao longo do caminho]

    style C fill:#86b6ef,stroke:#5598e7,color:#0b0b0b
    style E fill:#2a78d6,stroke:#1c5cab,color:#fff
    style F fill:#104281,stroke:#0d366b,color:#fff
{{< /mermaid >}}

Cada passo dessa árvore troca previsibilidade por alcance — um agente consegue lidar com uma tarefa que ninguém roteirizou de antemão, mas também precisa da maior supervisão para pegar quando o próprio plano dá errado.

## Ponto-chave 2: decomponha o requisito antes de escolher um padrão

Antes de escolher um padrão, divida o problema em três perguntas de propriedade: o que é trabalho do Claude, o que é trabalho do sistema existente, e o que é trabalho do humano. Pular essa etapa é como uma tarefa que deveria ser uma única chamada aumentada acaba superdimensionada como um agente, ou como um processo genuinamente de múltiplas etapas é espremido em um único prompt longo porque ninguém separou "o que o Claude faz" do "o que o banco de dados já faz".

## Ponto-chave 3: arquitetura de referência — retrieval vs. estado ao vivo

Depois que o papel do Claude está definido, a próxima decisão de design é como ele acessa a informação: **retrieval**, buscando em conteúdo indexado ou armazenado que não precisa estar atualizado ao segundo, ou **integração de estado ao vivo**, chamando um sistema ou API ao vivo quando a resposta precisa refletir o que é verdade agora. Preço, estoque e saldo de conta precisam de estado ao vivo. Uma resposta de base de conhecimento sobre uma política do trimestre passado geralmente não precisa.

## Ponto-chave 4: escolhendo o ponto de entrada

O Claude aparece por várias portas — Claude.ai, a API, SDKs, Claude Code, servidores MCP — e cada uma é a camada certa para um tipo diferente de personalização. O Claude.ai é a interface voltada ao usuário, para pessoas trabalhando diretamente com o Claude. A API e os SDKs são a camada de engenharia em tempo de build para incorporar o Claude no seu próprio produto. Servidores MCP são como o Claude alcança ferramentas e dados externos sem código de integração personalizado para cada um. Escolher o ponto de entrada errado significa resolver de novo um problema que a plataforma já resolveu em outra camada.

## Ponto-chave 5: comunicando valor e limites para os stakeholders

A última peça deste domínio não é técnica: é conseguir explicar a um stakeholder o que o Claude realmente vai fazer, o que não vai, e onde um humano ainda precisa estar envolvido — antes da solução ir ao ar, não depois que ela decepcionar alguém. Uma solução em que ninguém confia porque ninguém explicou seus limites de antemão falha por um motivo que não tem nada a ver com o modelo.

![Infográfico resumindo o framework de Integração de Workflow e Design de Soluções em cinco seções numeradas: três padrões de interação (chamadas aumentadas, workflows, agentes), decompor o requisito antes de escolher um padrão (trabalho do Claude, do sistema, do humano), arquitetura de referência (retrieval vs. estado ao vivo), escolher o ponto de entrada (Claude.ai, API, SDKs, Claude Code, servidores MCP), e comunicar valor e limites para os stakeholders](domain-2-workflow-integration-infographic.webp "O framework inteiro do Domínio 2 em uma página — feito para compartilhar como resumo autônomo")

## Conclusão

O Domínio 2 se resume a isso: escolha o padrão de interação que combina com quanta autonomia a tarefa realmente precisa (chamada aumentada, workflow ou agente), decomponha o requisito para que o Claude, o sistema existente e o humano tenham cada um uma parte clara, escolha retrieval ou estado ao vivo com base em se a resposta precisa estar atualizada, escolha o ponto de entrada da plataforma que combina com o tipo de personalização que o trabalho precisa, e seja direto com os stakeholders sobre o que a solução vai e não vai fazer. Isso é design de soluções — a camada acima de qualquer resultado individual bom.

## Fontes

- [Claude Platform & Solution Design — Anthropic Partner Academy](https://anthropic-partners.skilljar.com/claude-platform-solution-design)
- [Claude Certified Associate – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542847%2FClaude+Certified+Associate+%E2%80%93+Foundations+Exam+Guide.pdf) — PDF oficial

## Onde isso se encaixa

Parte 4 de **Getting Claude Certified**. A Parte 1 cobriu o [Framework 4D]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}), a Parte 2 cobriu [Chat, Projects, Artifacts e Research]({{< ref "/posts/claude-cert-02-using-claude-chat-projects-artifacts-and-research/" >}}), a Parte 3 cobriu o [Domínio 1 — Avaliação e Validação de Resultados]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}). A Parte 5 assume o [Domínio 3 — Governança, Risco e Uso Responsável]({{< ref "/posts/claude-cert-05-governance-risk-and-responsible-use/" >}}).
