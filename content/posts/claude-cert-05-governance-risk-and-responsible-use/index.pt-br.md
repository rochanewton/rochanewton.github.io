---
title: "Claude Certified Associate – Foundations: Domínio 3 — Governança, Risco e Uso Responsável"
date: 2026-09-18
description: "Um único caso de uso inapropriado pode congelar todo o programa de IA de uma organização. O Domínio 3 da prova de certificação Claude, 15% dela, é o framework de julgamento para manter a adoção avançando com segurança."
tags:
  - claude
  - anthropic
  - certification
  - governance
  - responsible-ai
  - ai-fluency
categories:
  - Claude
series:
  - getting-claude-certified
series_order: 5
showAuthor: true
image: cover.png
---

## Do que se trata

O Domínio 3 da prova [Claude Certified Associate – Foundations](https://anthropic-partners.skilljar.com/claude-certified-associate-foundations-certification) é **Governança, Risco e Uso Responsável**. Vale 15%. O enquadramento é direto: dados sensíveis enviados para o lugar errado, uma Skill não confiável com acesso amplo, uma violação silenciosa de política no momento errado — qualquer um desses pode congelar todo o programa de IA de uma organização e custar a produtividade que cada time havia ganhado. Governança não é um manual de política na prateleira. Ela é exercida por praticantes, uma decisão de cada vez — o que a torna uma habilidade que você constrói, não um documento que você lê uma vez.

![Gráfico de barras horizontais intitulado "Onde a prova realmente coloca o peso dela," mostrando os 7 domínios da prova Claude Certified Associate – Foundations ordenados por porcentagem: Output Evaluation and Validation com 21%, Workflow Integration and Solution Design com 16%, Governance Risk and Responsible Use com 15% destacado em azul, seguido por Prompting and Task Execution com 14%, Product and Model Selection com 12%, Configuration and Knowledge Management com 12%, e Troubleshooting and Optimization com 10%](domain-weights-chart.webp "Governança, Risco e Uso Responsável é o terceiro domínio mais pesado da prova")

## Ponto-chave 1: filtre casos de uso com quatro perguntas, não com instinto

Todo caso de uso proposto é testado contra quatro critérios: **reversibilidade** (dá para pegar um resultado errado antes que ele cause dano?), **consequência do erro** (quanto custa se estiver errado?), **necessidade de criatividade ou empatia humana** (isso exige julgamento que um modelo não consegue fornecer?), e **responsabilização** (quem responde pelo resultado?). Rode os quatro, depois identifique qual deles é o que sustenta a classificação — aquele que, se mudasse, moveria o caso de uso para outra categoria. Isso é o que torna uma classificação defensável para um revisor, em vez de só uma sensação.

{{< mermaid >}}
flowchart TD
    A[Caso de uso proposto] --> B{Rode os 4 critérios:<br/>reversibilidade, consequência,<br/>elemento humano, responsabilização}
    B -->|Tudo certo| C[Totalmente apropriado<br/>revisão normal]
    B -->|Útil, mas risco ou<br/>responsabilização exigem um portão| D[Apropriado com revisão humana<br/>defina quem/o quê/quando]
    B -->|Irreversível, alta consequência,<br/>ou responsabilização não transferível| E[Inapropriado<br/>nomeie o papel humano que deve assumir]

    style C fill:#0ca30c,stroke:#087a08,color:#fff
    style D fill:#fab219,stroke:#c98500,color:#0b0b0b
    style E fill:#d03b3b,stroke:#a82f2f,color:#fff
{{< /mermaid >}}

A caixa do meio é onde a maioria das pessoas relaxa demais: "apropriado com revisão humana" só é real quando o portão é específico — quem revisa, o que verifica, e quando no workflow isso acontece. "Um gerente revisa a lista final buscando padrões de impacto desigual antes de qualquer candidato ser contatado" é um portão. "Vamos manter um humano no circuito" não é.

## Ponto-chave 2: uma Skill é software — avalie-a como software

Uma Skill pode acessar tudo que sua sessão já tem acesso e pode tomar ações através de execução de código. Ela não solicita permissões; ela herda as que já existem. Antes de habilitar uma, cheque três coisas: **origem** (quem publicou — Anthropic, aprovada internamente, ou um terceiro desconhecido), **alcance** (o que ela realmente consegue tocar nas sessões em que roda, e isso é proporcional à tarefa), e **adequação** (é a ferramenta certa para o trabalho, ou é mais capacidade do que o necessário). "Interna" não é o mesmo que "avaliada" — uma Skill construída por outro time da sua própria empresa ainda precisa da mesma checagem.

Três resultados saem dessa checagem: **habilitar** quando origem, permissões e adequação estão todos claros; **escalar** para seu admin ou função de segurança quando é útil mas a origem ou as permissões não estão claras; **recusar** quando as permissões são claramente desproporcionais ou a origem não pode ser estabelecida. O mesmo hábito de proporcionalidade se aplica a qualquer capacidade que possa ler ou agir sobre seus dados, não só Skills — privilégio mínimo, revisitado quando o trabalho muda.

## Ponto-chave 3: classifique os dados antes que toquem em um recurso

Divida os dados em três níveis antes que cheguem perto de qualquer recurso. **Verde** — material público, anonimizado, ou material interno já liberado — não precisa de tratamento especial. **Amarelo** — documentos só internos, qualquer coisa com nomes ou contatos, material de negócio ou produto ainda não anunciado — precisa de checagem de política primeiro, e do modo Incógnito para não entrar na Memória nem no histórico do chat (ainda que a política de retenção de dados da sua organização continue valendo). **Vermelho** — dados regulados, credenciais, qualquer coisa sob obrigação de confidencialidade com terceiros — precisa de um ponto de entrada aprovado confirmado *antes* de qualquer upload, sem exceção.

![Três cartões mostrando uma classificação de sensibilidade de dados verde/amarelo/vermelho: verde "seguro para usar" para material público ou já liberado sem necessidade de controle especial, amarelo "revisar primeiro" para dados internos que precisam de revisão de política e modo Incógnito, vermelho "manter fora" para dados regulados ou confidenciais que precisam de um ponto de entrada aprovado antes do upload](data-tiers.webp "O Incógnito controla o que é lembrado, não se o dado era permitido ali para começar — para dados vermelhos, essa pergunta vem primeiro")

O erro comum é tratar o Incógnito como uma rede de segurança para dados vermelhos. Não é. O Incógnito controla se algo é lembrado — ele não diz nada sobre se o dado era permitido naquele recurso para começar. Para dados regulados, "isso é permitido aqui" é respondido antes de "como eu lido com isso aqui".

## Ponto-chave 4: diligência é um hábito, não uma checagem única

Uma política seguida só quando alguém está olhando não é governança — a lacuna entre o que a política diz e o que as pessoas realmente fazem é exatamente onde o risco se acumula, silenciosamente, nas decisões rotineiras de baixa visibilidade, não nas óbvias de alto risco. A correção é uma auditoria periódica: compare o que seu time realmente está fazendo com o que a política exige, e trate cada divergência — um upload não aprovado, um portão de revisão pulado, uma Skill não avaliada — como uma lacuna a fechar, não uma violação a punir. A maior parte do desvio não é maliciosa. É fricção: as pessoas pegam o caminho mais fácil quando o aprovado é mais lento, então a correção duradoura geralmente é remover a fricção, não adicionar uma regra.

## Ponto-chave 5: risco ético se esconde em resultados comuns

Risco de viés e imparcialidade não aparece etiquetado como um problema ético — ele aparece como um resumo, uma recomendação, ou uma lista final rotineira que silenciosamente favorece um grupo, construída sobre um enquadramento que ninguém questionou. Isso pertence à revisão de rotina, especialmente em trabalho voltado a pessoas como contratação ou avaliação, não a um exercício de ética separado. Transparência também importa: saiba quando seu contexto ou política exige divulgar assistência de IA, e opte por divulgar por padrão quando estiver em dúvida. Para casos genuinamente ambíguos, raciocine sobre quem é afetado, o que pode dar errado, como é o resultado justo, e qual divulgação se aplica — e quando a população afetada é grande ou o dano é significativo, escale o raciocínio em vez de decidir sozinho. Um "eu não sei, e eis o porquê" documentado é mais útil para um revisor do que um palpite confiante.

![Infográfico resumindo o framework de Governança, Risco e Uso Responsável em cinco seções numeradas: filtre casos de uso com quatro perguntas (reversibilidade, consequência do erro, criatividade ou empatia humana, responsabilização), uma Skill é software — avalie-a como software (origem, alcance, adequação), classifique os dados antes que toquem em um recurso (níveis verde, amarelo, vermelho), diligência é um hábito, não uma checagem única (audite, encontre lacunas, remova fricção, construa uma cultura), e risco ético se esconde em resultados comuns (cheque viés, considere o impacto, seja transparente, escale quando necessário)](domain-3-governance-infographic.webp "O framework inteiro do Domínio 3 em uma página — feito para compartilhar como resumo autônomo")

## Conclusão

O Domínio 3 em uma passada: filtre todo caso de uso contra reversibilidade, consequência, elemento humano e responsabilização, e torne o portão de revisão humana específico quando essa for a resposta. Avalie a origem e o alcance de uma Skill como avaliaria qualquer software antes de instalar. Classifique dados como verde, amarelo ou vermelho antes que toquem em um recurso, e lembre que o Incógnito não substitui essa classificação. Audite o uso real contra a política em uma cadência, porque o desvio acontece silenciosamente. E cheque resultados de rotina quanto a viés e divulgação do mesmo jeito que checaria quanto à precisão — porque o risco ético nunca ia se anunciar sozinho.

## Fontes

- [Governance, Risk & Responsible Use — Anthropic Partner Academy](https://anthropic-partners.skilljar.com/path/claude-certified-associate-foundations/governance-risk-responsible-use)
- [Claude Certified Associate – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542847%2FClaude+Certified+Associate+%E2%80%93+Foundations+Exam+Guide.pdf) — PDF oficial

## Onde isso se encaixa

Parte 5 de **Getting Claude Certified**. A Parte 1 cobriu o [Framework 4D]({{< ref "/posts/claude-cert-01-fluency-4d-framework/" >}}), a Parte 2 cobriu [Chat, Projects, Artifacts e Research]({{< ref "/posts/claude-cert-02-using-claude-chat-projects-artifacts-and-research/" >}}), a Parte 3 cobriu o [Domínio 1 — Avaliação e Validação de Resultados]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}), a Parte 4 cobriu o [Domínio 2 — Integração de Workflow e Design de Soluções]({{< ref "/posts/claude-cert-04-workflow-integration-and-solution-design/" >}}). A Parte 6 assume o [Domínio 4 — Prompting e Execução de Tarefas]({{< ref "/posts/claude-cert-06-prompting-and-task-execution/" >}}).
