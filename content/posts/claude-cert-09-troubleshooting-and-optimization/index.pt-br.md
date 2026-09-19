---
title: "Claude Certified Associate – Foundations: Domínio 7 — Troubleshooting e Otimização"
date: 2026-09-19
description: "O Domínio 7 da prova de certificação Claude, 10% dela, é o menor domínio e o que fecha o ciclo: diagnosticar por que um resultado teve desempenho abaixo do esperado, corrigir, e fazer a correção durar em vez de repeti-la."
tags:
  - claude
  - anthropic
  - certification
  - troubleshooting
  - optimization
  - ai-fluency
categories:
  - Claude
series:
  - getting-claude-certified
series_order: 9
showAuthor: true
image: cover.png
---

## Do que se trata

O Domínio 7 da prova [Claude Certified Associate – Foundations](https://anthropic-partners.skilljar.com/claude-certified-associate-foundations-certification) é **Troubleshooting e Otimização**. Vale 10% — o domínio mais leve da prova. Mas é o que fecha o ciclo dos outros seis: tudo, do prompting à configuração à seleção de modelo, eventualmente produz um resultado abaixo do esperado, e esse domínio é a disciplina de rastrear essa falha até a causa raiz, corrigi-la, e garantir que a correção persista em vez de ser redescoberta na semana seguinte.

![Gráfico de barras horizontais intitulado "Onde a prova realmente coloca o peso dela," mostrando os 7 domínios da prova Claude Certified Associate – Foundations ordenados por porcentagem: Output Evaluation and Validation com 21%, Workflow Integration and Solution Design com 16%, Governance Risk and Responsible Use com 15%, Prompting and Task Execution com 14%, Product and Model Selection com 12%, Configuration and Knowledge Management com 12%, e Troubleshooting and Optimization com 10% destacado em azul](domain-weights-chart.webp "Troubleshooting and Optimization é o domínio mais leve da prova — mas é aquele por onde todo os outros eventualmente passam")

## Ponto-chave 1: quatro padrões de falha, quatro correções diferentes

O desempenho abaixo do esperado quase sempre se rastreia a um de quatro padrões, e cada um deixa uma assinatura de sintoma distinta. A **sub-especificação** — o prompt deixa inferência demais a cargo do Claude — aparece como formato de saída inconsistente em execuções por outro lado parecidas. A **sobrecarga de contexto** — informação demais competindo e sufocando instruções iniciais — aparece como qualidade que estava boa e foi silenciosamente decaindo conforme a sessão crescia. A **funcionalidade ou modelo errado** — a tarefa precisa de outra ferramenta completamente — aparece como um prompt correto mas com um teto limitado pela configuração por trás dele. A **configuração desatualizada** — instruções, conhecimento ou uma Skill refletindo um processo antigo — aparece como um resultado que estava correto por meses e de repente errado sem nenhuma razão do lado do prompt. Nomear o padrão antes de buscar uma correção já é a maior parte do diagnóstico.

![Quatro cartões intitulados "Quatro padrões de falha, quatro correções diferentes": Under-specification com sintoma formato de saída inconsistente, Context overload com sintoma qualidade que decaiu silenciosamente, Wrong feature or model com sintoma um teto limitado apesar de um prompt correto, Stale configuration com sintoma um resultado correto que de repente quebrou](failure-patterns.webp "Combine o sintoma com o padrão antes de mexer em qualquer coisa — os quatro padrões raramente compartilham uma correção")

## Ponto-chave 2: corrija o mais barato primeiro

A sequência de diagnóstico vai do menor custo ao maior: verifique o prompt e as instruções antes de trocar de modelo, verifique a configuração antes de reconstruir o workflow. Recorrer a um modelo maior ou a um redesenho completo do workflow antes de descartar uma instrução vaga ou uma configuração desatualizada consome tempo e muitas vezes nem resolve o problema, porque a causa raiz nunca foi capacidade de modelo, para começo de conversa.

{{< mermaid >}}
flowchart TD
    A[Resultado abaixo do esperado] --> B{O prompt ou a instrução<br/>é específico o bastante?}
    B -->|Não| C[Corrija o prompt/instruções<br/>mais barato, tente primeiro]
    B -->|Sim| D{A configuração está<br/>desatualizada ou ausente?}
    D -->|Sim| E[Atualize instruções,<br/>conhecimento ou Skill]
    D -->|Não| F{É a funcionalidade ou<br/>nível de modelo certo?}
    F -->|Não| G[Troque o ponto de entrada<br/>ou o nível de modelo]
    F -->|Sim| H[Redesenhe o workflow<br/>último recurso, maior custo]

    style C fill:#86b6ef,stroke:#5598e7,color:#0b0b0b
    style E fill:#2a78d6,stroke:#1c5cab,color:#fff
    style G fill:#104281,stroke:#0d366b,color:#fff
    style H fill:#d03b3b,stroke:#a32e2e,color:#fff
{{< /mermaid >}}

## Ponto-chave 3: transforme crítica vaga em ajuste específico

"Deixa melhor" não é acionável — não dá ao Claude nada de novo para agir, então a próxima tentativa decai do mesmo jeito que a primeira. Nomear a dimensão exata que falhou é o que de fato muda o resultado: não "o tom está errado", mas "tire os pontos de exclamação e corte toda frase que repete a anterior." A diferença entre uma correção **capturada** e uma **perdida** é se esse ajuste específico é escrito em uma instrução permanente, ou só aplicado uma vez, no momento, e esquecido na sessão seguinte.

## Ponto-chave 4: encontre atrito com três sinais, depois promova a correção

Três sinais apontam para uma correção que vale a pena tornar permanente: **repetição** (você está digitando a mesma correção em sessões diferentes), **correção** (você está editando o mesmo tipo de erro para fora do resultado toda vez), e **variância** (o mesmo pedido produz qualidade bem diferente dependendo de quem pergunta ou de quando). Assim que um sinal aparece, a correção precisa de um lar — e o teste para qual é simples: uma **regra** sobre comportamento vai nas instruções permanentes, um fato de **referência** vai na base de conhecimento, um **procedimento** com múltiplas etapas vira uma Skill. Promover a correção para o slot certo é o que impede a correção de se repetir.

## Ponto-chave 5: meça a melhoria contra a métrica que importa

Uma auditoria de workflow que vai de 45 minutos para 25 minutos só conta se os 45 minutos eram de fato o gargalo e os 25 minutos são medidos da mesma forma — mesma tarefa, mesmo padrão de revisão, não um mais frouxo. A tentação é otimizar o que for mais fácil de medir; a disciplina é otimizar a métrica que era de fato a reclamação original, seja ela tempo, número de revisões, ou com que frequência um humano precisa intervir.

![Infográfico intitulado "Troubleshooting and Optimization: encontre o problema. Aplique a correção certa. Faça durar," cobrindo o Domínio 7 da prova Claude Certified Associate – Foundations (10%): quatro padrões de falha e suas correções (sub-especificação, sobrecarga de contexto, funcionalidade ou modelo errado, configuração desatualizada), um fluxo de decisão de corrigir-o-mais-barato-primeiro, transformar crítica vaga em ajuste específico, encontrar atrito com três sinais e promover correções para instruções permanentes, base de conhecimento ou Skill, e medir melhoria contra a métrica certa](domain-7-troubleshooting-infographic.webp "O ciclo completo de diagnóstico até otimização do Domínio 7 em uma folha de referência")

## Conclusão

O Domínio 7 em uma passada: nomeie o padrão de falha antes de buscar uma correção — sub-especificação, sobrecarga de contexto, funcionalidade ou modelo errado, configuração desatualizada, cada um deixa um sintoma diferente. Corrija o mais barato primeiro: prompt e instruções antes de trocar de modelo, configuração antes de redesenhar o workflow. Transforme crítica vaga em um ajuste específico e capturável em vez de uma correção pontual. Observe repetição, correção e variância, depois promova a correção para o lar certo — regra, referência ou procedimento. E meça a melhoria contra a métrica que era de fato a reclamação, não a que for mais fácil de acompanhar.

## Fontes

- [Troubleshooting & Optimization — Anthropic Partner Academy](https://anthropic-partners.skilljar.com/path/claude-certified-associate-foundations/troubleshooting-optimization)
- [Claude Certified Associate – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542847%2FClaude+Certified+Associate+%E2%80%93+Foundations+Exam+Guide.pdf) — PDF oficial

## Onde isso se encaixa

Parte 9 de **Getting Claude Certified**. A Parte 1 cobriu o [Framework 4D]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}), a Parte 2 cobriu [Chat, Projects, Artifacts e Research]({{< ref "/posts/claude-cert-02-using-claude-chat-projects-artifacts-and-research/" >}}), a Parte 3 cobriu o [Domínio 1 — Avaliação e Validação de Resultados]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}), a Parte 4 cobriu o [Domínio 2 — Integração de Workflow e Design de Soluções]({{< ref "/posts/claude-cert-04-workflow-integration-and-solution-design/" >}}), a Parte 5 cobriu o [Domínio 3 — Governança, Risco e Uso Responsável]({{< ref "/posts/claude-cert-05-governance-risk-and-responsible-use/" >}}), a Parte 6 cobriu o [Domínio 4 — Prompting e Execução de Tarefas]({{< ref "/posts/claude-cert-06-prompting-and-task-execution/" >}}), a Parte 7 cobriu o [Domínio 5 — Seleção de Produto e Modelo]({{< ref "/posts/claude-cert-07-product-and-model-selection/" >}}), a Parte 8 cobriu o [Domínio 6 — Configuração e Gestão de Conhecimento]({{< ref "/posts/claude-cert-08-configuration-and-knowledge-management/" >}}). São os 7 domínios da prova completos — a série se encerra aqui.
