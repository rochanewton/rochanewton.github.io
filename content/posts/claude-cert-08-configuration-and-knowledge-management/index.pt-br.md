---
title: "Claude Certified Associate – Foundations: Domínio 6 — Configuração e Gestão de Conhecimento"
date: 2026-09-19
description: "Existe uma linha entre usar o Claude e operar o Claude. O Domínio 6 da prova de certificação Claude, 12% dela, é a disciplina de configurar um ambiente uma vez e se beneficiar disso em toda conversa depois."
tags:
  - claude
  - anthropic
  - certification
  - configuration
  - knowledge-management
  - ai-fluency
categories:
  - Claude
series:
  - getting-claude-certified
series_order: 8
showAuthor: true
image: cover.png
---

## Do que se trata

O Domínio 6 da prova [Claude Certified Associate – Foundations](https://anthropic-partners.skilljar.com/claude-certified-associate-foundations-certification) é **Configuração e Gestão de Conhecimento**. Vale 12%. A linha que ele traça: usar o Claude significa digitar um bom prompt hoje. Operar o Claude significa construir um ambiente em que o contexto certo, as instruções e os procedimentos já existem, para que toda conversa comece de uma base configurada em vez de uma folha em branco. Configuração é alavancagem — você configura uma vez e se beneficia em toda conversa que vem depois — e também é o que transforma habilidade individual em capacidade de time, já que duas pessoas fazendo a mesma pergunta contra o mesmo Project configurado recebem a mesma qualidade de resposta.

![Gráfico de barras horizontais intitulado "Onde a prova realmente coloca o peso dela," mostrando os 7 domínios da prova Claude Certified Associate – Foundations ordenados por porcentagem: Output Evaluation and Validation com 21%, Workflow Integration and Solution Design com 16%, Governance Risk and Responsible Use com 15%, Prompting and Task Execution com 14%, Product and Model Selection com 12%, Configuration and Knowledge Management com 12% destacado em azul, e Troubleshooting and Optimization com 10%](domain-weights-chart.webp "Configuração e Gestão de Conhecimento empata no quinto lugar mais pesado da prova")

## Ponto-chave 1: quatro mecanismos, quatro trabalhos diferentes

As **instruções** governam comportamento — tom, padrões de formato, hábitos de verificação — não fatos. A **base de conhecimento** guarda fatos e material de referência que o Claude deve usar sem precisar reenviar — não comportamento. As **Skills** carregam um procedimento repetível, construído uma vez no nível da conta em Customize e reutilizado em qualquer Project que precise dele — não uma instrução pontual. A **Memory com escopo** mantém continuidade dentro de um Project, isolada dos seus outros Projects para que o contexto nunca vaze entre workstreams.

![Quatro cartões intitulados "Quatro mecanismos de configuração, quatro trabalhos": Instructions para comportamento (tom, formato, hábitos de verificação), Knowledge base para fatos e referência, Skills para um procedimento repetível construído uma vez e reutilizado entre Projects, Scoped Memory para continuidade isolada a um Project](config-mechanisms.webp "Combine a necessidade com o slot certo — colocar um procedimento nas instruções ou uma regra de comportamento no conhecimento é o erro de configuração mais comum")

{{< mermaid >}}
flowchart TD
    A[Uma necessidade recorrente] --> B{Que tipo de<br/>necessidade é essa?}
    B -->|Como o Claude deve se comportar| C[Instructions]
    B -->|Um fato que o Claude deve saber| D[Knowledge base]
    B -->|Um procedimento repetível de múltiplas etapas| E[Skill]
    B -->|Continuidade dentro deste Project| F[Scoped Memory]

    style C fill:#2a78d6,stroke:#1c5cab,color:#fff
    style D fill:#eb6834,stroke:#c14e22,color:#fff
    style E fill:#1baf7a,stroke:#0d8a5c,color:#fff
    style F fill:#eda100,stroke:#c98500,color:#fff
{{< /mermaid >}}

## Ponto-chave 2: a maioria das necessidades mapeia para dois slots conectados

As configurações mais limpas raramente cabem em um único mecanismo. "Sempre cite o documento-fonte para afirmações factuais" é uma instrução permanente, mas os documentos que ela cita vivem na base de conhecimento — nenhum dos dois funciona sozinho. Um consultor rodando um Project por cliente se combina da mesma forma: instruções permanentes definem o registro formal e o hábito de citação, a base de conhecimento guarda o guia de marca do cliente e o escopo de trabalho atual, uma Skill no nível da conta formata todo relatório de status da mesma forma, e a Memory com escopo guarda os nomes dos stakeholders daquele cliente — mantidos fora do Project de qualquer outro cliente.

## Ponto-chave 3: conectores têm limites de capacidade, não bugs

Um conector — Google Drive, Gmail — estende o alcance do Claude aos dados que você autoriza, e cada um tem um limite definido. Um conector de e-mail que consegue buscar e ler mas não enviar não está quebrado; ele está no seu limite. Duas armadilhas aparecem com frequência no uso real: o caminho óbvio de "adicionar um conector" pode levar a um diretório público em vez dos conectores aprovados pela sua organização, então confirme o caminho certo com seu admin no Team ou Enterprise; e quando um conector atinge seu limite, a falha parece um bug em vez de comportamento documentado, o que manda relatos para o time errado e trava a correção. Conhecer o limite de cada conector antes de construir um workflow sobre ele evita as duas coisas.

## Ponto-chave 4: uma instrução vaga falha silenciosamente

"Faça os relatórios bons e precisos" dá ao Claude quase nada para agir — a qualidade do resultado varia de conversa para conversa e nada nunca anuncia a falha. "Para cada número em um relatório, indique sua fonte. Se um número não estiver nos dados fornecidos, marque-o como 'não verificado' em vez de incluí-lo. Comece cada relatório com uma manchete de uma frase" é precisa o suficiente para de fato mudar o resultado, de forma consistente. O teste para qualquer instrução permanente: duas pessoas diferentes lendo ela produziriam o mesmo comportamento?

## Ponto-chave 5: configurações envelhecem — agende a manutenção

Instruções, conhecimento, Skills e Memory todos tendem a ficar desatualizados, e nenhum deles lança um erro quando isso acontece — o resultado só degrada silenciosamente. Uma revisão mensal nos Projects ativos pega a maior parte disso: as instruções permanentes ainda combinam com o processo atual, a base de conhecimento está livre de documentos superados, as Skills certas estão habilitadas. Skills construídas pela Anthropic ou provisionadas pela organização se atualizam automaticamente; suas próprias Skills personalizadas só mudam quando você as reenvia. Um Project de relatório recorrente com números desatualizados é um caso clássico — a base de conhecimento já tinha as metas atuais, mas a instrução permanente e uma entrada de Memory ainda apontavam para o modelo do ano passado. A correção foi atualizar essas duas coisas, não escrever um prompt melhor.

![Infográfico resumindo o framework de Configuração e Gestão de Conhecimento em cinco seções numeradas: quatro mecanismos com quatro trabalhos diferentes (instructions, knowledge base, Skills, scoped Memory), a maioria das necessidades mapeia para dois slots conectados, conectores têm limites de capacidade e não bugs, uma instrução vaga falha silenciosamente, e configurações envelhecem — agende a manutenção](domain-6-configuration-infographic.webp "O framework inteiro do Domínio 6 em uma página — feito para compartilhar como resumo autônomo")

## Conclusão

O Domínio 6 em uma passada: combine cada necessidade recorrente com o mecanismo certo — instruções para comportamento, conhecimento para fatos, Skills para procedimento, Memory com escopo para continuidade — e espere que a maioria das necessidades reais conecte dois deles. Conheça o limite de capacidade de cada conector antes de construir sobre ele. Escreva instruções precisas o suficiente para que duas pessoas as leiam da mesma forma. E agende manutenção, porque a configuração decai silenciosamente e a correção quase sempre é atualizar a configuração, não o prompt.

## Fontes

- [Configuration & Knowledge Management — Anthropic Partner Academy](https://anthropic-partners.skilljar.com/path/claude-certified-associate-foundations/configuration-knowledge-management)
- [Claude Certified Associate – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542847%2FClaude+Certified+Associate+%E2%80%93+Foundations+Exam+Guide.pdf) — PDF oficial

## Onde isso se encaixa

Parte 8 de **Getting Claude Certified**. A Parte 1 cobriu o [Framework 4D]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}), a Parte 2 cobriu [Chat, Projects, Artifacts e Research]({{< ref "/posts/claude-cert-02-using-claude-chat-projects-artifacts-and-research/" >}}), a Parte 3 cobriu o [Domínio 1 — Avaliação e Validação de Resultados]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}), a Parte 4 cobriu o [Domínio 2 — Integração de Workflow e Design de Soluções]({{< ref "/posts/claude-cert-04-workflow-integration-and-solution-design/" >}}), a Parte 5 cobriu o [Domínio 3 — Governança, Risco e Uso Responsável]({{< ref "/posts/claude-cert-05-governance-risk-and-responsible-use/" >}}), a Parte 6 cobriu o [Domínio 4 — Prompting e Execução de Tarefas]({{< ref "/posts/claude-cert-06-prompting-and-task-execution/" >}}), a Parte 7 cobriu o [Domínio 5 — Seleção de Produto e Modelo]({{< ref "/posts/claude-cert-07-product-and-model-selection/" >}}). A Parte 9 cobriu o [Domínio 7 — Troubleshooting and Optimization]({{< ref "/posts/claude-cert-09-troubleshooting-and-optimization/" >}}) — encerrando os 7 domínios da prova.
