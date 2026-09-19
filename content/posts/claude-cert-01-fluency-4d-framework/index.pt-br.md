---
title: "The 4D Framework: Delegation, Description, Discernment, Diligence"
date: 2026-09-11
aliases:
  - /posts/why-a-middleware-engineer-is-getting-certified-in-claude/
  - /posts/ai-fluency-4d-framework/
description: AI Fluency não é uma pilha de truques de prompt — são quatro competências. Delegation, Description, Discernment e Diligence, condensadas no que realmente muda a forma como você trabalha com o Claude.
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

## Do que se trata

O curso AI Fluency da Anthropic divide o trabalho com IA em quatro competências em vez de uma pilha de truques de prompt: **Delegation, Description, Discernment, Diligence**. Os 4Ds. Eu esperava um curso de prompting e saí com um framework de decisão — algo menos sobre escrever prompts melhores e mais sobre decidir o que delegar, como comunicar isso, como julgar o que volta, e quem responde pelo resultado. Aqui está cada um, condensado no que realmente importa.

## Ponto-chave 1: Delegation — a decisão antes do prompt

Delegation é decidir o que é seu para fazer, o que é da IA para fazer, e o que vale a pena fazer junto — antes que qualquer coisa disso vire um prompt. Se resume a conhecer o objetivo de verdade, saber no que aquele sistema de IA específico é bom e no que não é, e só então tomar a decisão de repassar a tarefa. A parte que a maioria subestima: o que é seguro delegar muda de acordo com o contexto. Uma resposta rápida no chat e um agente autônomo rodando chamadas de ferramenta sem supervisão não recebem a mesma confiança por padrão — então a pergunta é refeita toda vez, não decidida uma vez e reaproveitada.

## Ponto-chave 2: Description — a IA não lê sua mente

Description é comunicar o que você quer de forma clara o suficiente para que a IA consiga de fato entregar — não só o resultado final, mas o método que você quer que ela siga e como ela deve se comportar enquanto trabalha com você. A maioria dos resultados decepcionantes de IA vem de especificar só o resultado final e pular os outros dois. Peça um resumo sem dizer o quão direto você quer o feedback, e não se surpreenda quando ela concordar com tudo que você escreveu.

## Ponto-chave 3: Discernment — o outro lado da description

Discernment é julgar o que volta: o resultado em si, o raciocínio por trás dele, e se a interação foi de fato responsiva à sua direção ou só concordou com tudo. A pegadinha — seu discernimento é tão forte quanto sua própria experiência no assunto. Uma afirmação errada na sua área salta aos olhos numa frase. A mesma afirmação errada fora da sua área soa completamente correta, porque para você ela é indistinguível de uma afirmação certa.

## Ponto-chave 4: Diligence — a parte que não é sobre qualidade

Diligence não é sobre conseguir um resultado melhor — é sobre assumir responsabilidade pelo que você fez para chegar até ele: ser criterioso sobre qual sistema você usa, ser honesto com as pessoas sobre o papel da IA quando elas veem o resultado, e de fato defender esse resultado depois que ele sai com o seu nome. A parte mais pulada é justamente defender o resultado — ninguém checa isso até que algo esteja errado na frente de alguém importante, e "a IA escreveu essa parte" não sustenta esse momento.

## Como os quatro se encaixam

{{< mermaid >}}
flowchart LR
    A[Delegation<br/>decidir o que repassar] --> B[Description<br/>dizer como, não só o quê]
    B --> C{Discernment<br/>julgar o resultado}
    C -->|Lacunas encontradas| B
    C -->|Se sustenta| D[Diligence<br/>assumir o resultado]
    D -->|Próxima tarefa| A

    style A fill:#2a78d6,stroke:#1a5fb4,color:#fff
    style B fill:#2a78d6,stroke:#1a5fb4,color:#fff
    style C fill:#eda100,stroke:#c98500,color:#fff
    style D fill:#eda100,stroke:#c98500,color:#fff
{{< /mermaid >}}

Delegation e Description são as duas competências visíveis em qualquer demonstração de IA — são elas que produzem o resultado. Discernment e Diligence são as duas que ninguém vê no palco, e são elas que de fato determinam se aquele resultado era seguro de usar.

![As 4 competências centrais da fluência em IA, mostradas como um iceberg: Delegation e Description acima da linha d'água como "o que aparece depois que o piloto dá certo," Discernment e Diligence abaixo dela como "o que a fluência em IA realmente custa"](4d-ai-fluency-iceberg.webp "Delegation e description são a metade visível do trabalho. Discernment e diligence são a metade que ninguém vê na demonstração.")

## Conclusão

O framework 4D em uma linha: decida o que delegar, descreva por completo (não só o resultado final), julgue o que volta com o mesmo rigor que aplicaria ao trabalho de um colega, e assuma o resultado depois que ele sai. A maioria das experiências decepcionantes com IA vem de pular uma dessas quatro — geralmente Description ou Diligence — não do modelo em si. Esse é o framework inteiro, e tudo mais sobre usar o Claude bem se constrói em cima dele.

## Fontes

- [AI Fluency: Framework & Foundations — Claude Academy](https://academy.claude.com/courses/ai-fluency-framework-foundations)
- [AI Fluency Framework — documentação, artigos e recursos abertos](https://aifluencyframework.org/)

## Onde isso se encaixa

Parte 1 de **Getting Claude Certified**. A Parte 2 cobre [Chat, Projects, Artifacts e Research]({{< ref "/posts/claude-cert-02-using-claude-chat-projects-artifacts-and-research/" >}}), a Parte 3 cobre [Domínio 1 — Avaliação e Validação de Resultados]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}), que é o aprofundamento de Discernment.
