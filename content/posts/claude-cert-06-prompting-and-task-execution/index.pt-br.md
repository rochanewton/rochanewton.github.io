---
title: "Claude Certified Associate – Foundations: Domínio 4 — Prompting e Execução de Tarefas"
date: 2026-09-16
description: A mesma solicitação, formulada de duas formas, produz dois níveis diferentes de resultado. O Domínio 4 da prova de certificação Claude, 14% dela, trata prompting como estrutura que se aprende, não um dom que algumas pessoas têm.
tags:
  - claude
  - anthropic
  - certification
  - prompting
  - task-execution
  - ai-fluency
categories:
  - Claude
series:
  - getting-claude-certified
series_order: 6
showAuthor: true
image: cover.png
---

## Do que se trata

O Domínio 4 da prova [Claude Certified Associate – Foundations](https://anthropic-partners.skilljar.com/claude-certified-associate-foundations-certification) é **Prompting e Execução de Tarefas**. Vale 14%. O enquadramento que importa aqui: peça ao Claude "escreva algo sobre nossos resultados do Q3" e você recebe um parágrafo genérico. Especifique o público, os três resultados que importam, o formato e o tamanho, e você recebe um rascunho quase pronto para enviar. O modelo não ficou mais inteligente entre uma solicitação e outra. O prompt que mudou. Este domínio trata prompting como uma disciplina de comunicação com estrutura que se aprende, não um dom que algumas pessoas têm.

![Gráfico de barras horizontais intitulado "Onde a prova realmente coloca o peso dela," mostrando os 7 domínios da prova Claude Certified Associate – Foundations ordenados por porcentagem: Output Evaluation and Validation com 21%, Workflow Integration and Solution Design com 16%, Governance Risk and Responsible Use com 15%, Prompting and Task Execution com 14% destacado em azul, seguido por Product and Model Selection com 12%, Configuration and Knowledge Management com 12%, e Troubleshooting and Optimization com 10%](domain-weights-chart.webp "Prompting e Execução de Tarefas é o quarto domínio mais pesado da prova")

## Ponto-chave 1: a pilha de cinco componentes

Cinco componentes carregam quase todo o peso de um prompt profissional: **Role** (quem o Claude deve ser para esta tarefa), **Context** (o contexto que o Claude não consegue saber a menos que você forneça), **Task** (uma ação inequívoca), **Constraints** (tamanho, tom, o que incluir ou evitar), e **Output format** (o formato do resultado). Nem todo prompt precisa dos cinco — uma pergunta rápida precisa de uma tarefa e talvez uma restrição. Context é o que os profissionais mais pulam, porque ele existe só na sua cabeça e nunca chega ao prompt.

![Diagrama de cinco linhas intitulado "A pilha de cinco componentes do prompt," cada linha codificada por cor e rotulada: Role (quem o Claude deve ser), Context (o contexto que o Claude não consegue saber sem ser informado), Task (uma ação inequívoca), Constraints (tamanho, tom, o que incluir ou evitar), Output format (o formato do resultado)](prompt-stack.webp "A maioria dos prompts fracos está faltando uma linha desta lista, geralmente Context")

## Ponto-chave 2: decomponha solicitações complexas em etapas ordenadas

Uma solicitação com vários estágios distintos comprimida em um único prompt produz trabalho raso em cada estágio. "Avalie esses três fornecedores e me diga qual escolher" força o Claude a inventar critérios, aplicá-los, ponderar trade-offs e recomendar, tudo em uma única passada — você nunca vê o raciocínio. Divida em uma sequência em vez disso, e cada etapa produz um resultado verificável antes que a próxima rode.

{{< mermaid >}}
flowchart LR
    A[Derivar critérios<br/>do documento de requisitos] --> B[Pontuar cada fornecedor<br/>contra esses critérios]
    B --> C[Levantar trade-offs<br/>onde os fornecedores mais divergem]
    C --> D[Recomendar<br/>vinculado aos critérios ponderados]

    style A fill:#2a78d6,stroke:#1c5cab,color:#fff
    style B fill:#2a78d6,stroke:#1c5cab,color:#fff
    style C fill:#2a78d6,stroke:#1c5cab,color:#fff
    style D fill:#1c5cab,stroke:#104281,color:#fff
{{< /mermaid >}}

Se os critérios na primeira etapa estiverem errados, você pega isso antes da pontuação, não depois que a recomendação já saiu. Mantenha etapas que se constroem umas sobre as outras em uma única conversa; separe em uma nova conversa só quando uma etapa for genuinamente independente ou quando a thread já tiver crescido o suficiente para o contexto inicial começar a degradar.

## Ponto-chave 3: itere no componente que falhou, não no prompt inteiro

Um primeiro rascunho raramente sai perfeito, e a correção nunca é reescrever o prompt inteiro — isso perde as partes que funcionaram e esconde qual mudança de fato resolveu o problema. Leia o resultado como um diagnóstico em vez disso: ele aponta direto para o componente que falhou.

| Sintoma | Causa provável | Correção |
| --- | --- | --- |
| Resultado genérico ou fora do alvo | Context estava raso | Adicione o contexto que o Claude não conseguiu inferir |
| Resultado respondeu a pergunta errada | Verbo da task era ambíguo | Deixe a instrução mais precisa |
| Resultado com tamanho, tom ou formato errado | Faltou uma constraint ou o format | Adicione |
| Resultado quase certo mas erra em uma seção | — | Itere só nessa seção |

Mude o único componente que o resultado indicou, reenvie e compare. Pare quando uma rodada produzir mudança marginal em vez de melhora real — nesse ponto, uma edição manual rápida vence outra rodada de prompting.

## Ponto-chave 4: combine a estratégia com o tipo de tarefa

Os cinco componentes se aplicam sempre, mas a ênfase muda conforme o que você está fazendo. Análise quer restrições apertadas e critérios explícitos — baixa liberdade criativa, alta especificação. Pesquisa quer escopo claro e disciplina de fontes, com citações que você consegue de fato checar. Redação quer público, tom e formato fixados, com espaço para o Claude encontrar a fraseologia. Brainstorming quer restrições soltas e alta liberdade — superespecificar mata a variedade que você está buscando.

| Tipo de tarefa | Apertar | Soltar |
| --- | --- | --- |
| **Análise** | Critérios, padrões, escopo | Fraseologia |
| **Pesquisa** | Pergunta, fontes, citações | Abordagem de síntese |
| **Redação** | Público, tom, formato | Escolha de palavras |
| **Brainstorming** | Só objetivo e limites | Quantidade e direção |

## Ponto-chave 5: um prompt fraco, reparado

**Fraco:** "Resuma o feedback dos clientes e me diga o que fazer." **Resultado:** uma lista genérica de cinco bullets com temas, nada vinculado aos dados reais, nada acionável — porque o prompt quase não especificou nada.

**Reparado:** "Você é um analista de produto *(role)*. Em anexo estão 200 respostas de pesquisa com clientes *(context)*. Identifique os três problemas mais frequentemente levantados, classificados por quantas respostas mencionam cada um *(task)*, e para cada um inclua uma citação verbatim representativa e a proporção aproximada de respostas em que aparece *(constraints)* — use execução de código para contar com precisão em vez de estimar. Formate como uma lista classificada, do mais frequente para o menos frequente *(output format)*."

Mesmo modelo, mesmos dados. A diferença entre os dois resultados está inteiramente na especificação, não na capacidade subjacente.

![Infográfico resumindo o framework de Prompting e Execução de Tarefas em cinco seções numeradas: a pilha de cinco componentes (role, context, task, constraints, output format), decomponha solicitações complexas em etapas ordenadas, itere no componente que falhou, combine a estratégia com o tipo de tarefa, e um prompt fraco reparado lado a lado com sua correção](domain-4-prompting-infographic.webp "O framework inteiro do Domínio 4 em uma página — feito para compartilhar como resumo autônomo")

## Conclusão

O Domínio 4 em uma passada: rode todo prompt não trivial contra os cinco componentes (role, context, task, constraints, format), e espere que context seja o que você esqueceu. Decomponha trabalho de múltiplos estágios em etapas ordenadas para que cada uma produza um resultado verificável antes que a próxima rode. Quando o resultado decepcionar, diagnostique qual componente falhou e corrija só aquele — não comece do zero. Combine seu estilo de especificação com a tarefa: apertado para análise e pesquisa, mais solto para redação, o mais solto possível para brainstorming. Estrutura é o que impulsiona a qualidade aqui, não sagacidade.

## Fontes

- [Prompting & Task Execution — Anthropic Partner Academy](https://anthropic-partners.skilljar.com/path/claude-certified-associate-foundations/prompting-task-execution)
- [Claude Certified Associate – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542847%2FClaude+Certified+Associate+%E2%80%93+Foundations+Exam+Guide.pdf) — PDF oficial

## Onde isso se encaixa

Parte 6 de **Getting Claude Certified**. A Parte 1 cobriu o [Framework 4D]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}), a Parte 2 cobriu [Chat, Projects, Artifacts e Research]({{< ref "/posts/claude-cert-02-using-claude-chat-projects-artifacts-and-research/" >}}), a Parte 3 cobriu o [Domínio 1 — Avaliação e Validação de Resultados]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}), a Parte 4 cobriu o [Domínio 2 — Integração de Workflow e Design de Soluções]({{< ref "/posts/claude-cert-04-workflow-integration-and-solution-design/" >}}), a Parte 5 cobriu o [Domínio 3 — Governança, Risco e Uso Responsável]({{< ref "/posts/claude-cert-05-governance-risk-and-responsible-use/" >}}). A Parte 7 assume o [Domínio 5 — Seleção de Produto e Modelo]({{< ref "/posts/claude-cert-07-product-and-model-selection/" >}}).
