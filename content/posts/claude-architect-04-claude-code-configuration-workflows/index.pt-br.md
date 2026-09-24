---
title: "Tornando-se um Claude Architect: Claude Code Configuration & Workflows — Domínio 3"
date: 2026-09-24
description: "20% da prova Claude Certified Architect – Foundations: a hierarquia do CLAUDE.md e a sintaxe @import, rules com escopo por caminho, slash commands e skills customizados, plan mode vs. execução direta, refinamento iterativo, e integração com CI/CD via -p e --output-format json."
tags:
  - claude
  - anthropic
  - certification
  - claude-architect
  - claude-code
  - claude-md
  - ci-cd
categories:
  - Claude
series:
  - becoming-a-claude-architect
series_order: 4
showAuthor: true
image: cover.png
---

## Do que se trata

O Domínio 3 — **Claude Code Configuration & Workflows** — empata com Prompt Engineering & Structured Output como o segundo domínio mais pesado da prova Claude Certified Architect – Foundations, com 20%. Suas seis áreas de tarefa giram em torno de como você configura e conduz o próprio Claude Code: hierarquia de arquivos de configuração, comandos e skills customizados, rules condicionais, escolher entre plan mode e ir direto ao ponto, iterar bem, e integrar o Claude Code ao CI/CD.

## Ponto-chave 1: o CLAUDE.md tem uma hierarquia — saiba onde cada regra pertence

O Claude Code carrega instruções de vários escopos, do mais amplo ao mais específico: um arquivo de política gerenciada em nível de organização (controlado pelo TI), um `~/.claude/CLAUDE.md` de nível de usuário (suas preferências pessoais em todos os projetos), nível de projeto (`./CLAUDE.md` ou `./.claude/CLAUDE.md`, compartilhado com o time via controle de versão), e um `CLAUDE.local.md` no .gitignore para suas preferências pessoais específicas do projeto que não devem ser commitadas. Eles carregam nessa ordem, então uma instrução de projeto aparece no contexto *depois* de uma instrução de usuário — coloque uma regra no escopo a que ela realmente pertence, não onde for mais conveniente. Para um projeto grande, a sintaxe de import `@caminho/para/arquivo` permite que um CLAUDE.md puxe um README, um package.json, ou um guia de workflow dedicado sem duplicar esse conteúdo, com imports resolvidos em relação ao arquivo que os referencia e aninhamento de até quatro níveis.

## Ponto-chave 2: comandos e skills customizados — com escopo, e com acesso a ferramentas que você controla

Comandos com escopo de projeto ficam em `.claude/commands/` (versionados, compartilhados com o time) versus comandos com escopo de usuário em `~/.claude/commands/` (pessoais, não compartilhados). Skills vão além: o frontmatter de um `SKILL.md` pode definir `context: fork` para rodar a skill em um subagente isolado sem visibilidade do histórico da conversa principal — útil para uma tarefa autocontida como uma revisão de código — e `allowed-tools` para pré-aprovar um conjunto específico e restrito de ferramentas só para aquela invocação (a concessão expira depois da próxima mensagem), em vez de a skill herdar acesso irrestrito a ferramentas.

## Ponto-chave 3: rules com escopo por caminho carregam só quando são relevantes

Em vez de empilhar toda convenção num único CLAUDE.md que carrega em toda sessão independente do que você está mexendo, arquivos em `.claude/rules/` podem ter um campo `paths` no frontmatter YAML — um padrão glob como `src/api/**/*.ts` — para que aquela regra só entre no contexto quando o Claude estiver de fato trabalhando com arquivos correspondentes. Isso mantém as convenções de um projeto grande modulares por tópico (`testing.md`, `security.md`, `api-design.md`) e reduz o uso de contexto, já que uma regra sobre validação de API não precisa carregar enquanto você edita um arquivo CSS.

## Ponto-chave 4: plan mode é para incerteza e mudanças em múltiplos arquivos, não para tudo

O plan mode — o Claude lê e raciocina sem fazer mudanças, e então propõe um plano que você aprova antes de ele tocar em qualquer coisa — é feito para trabalho complexo e de grande escala: quando você não tem certeza da abordagem certa, a mudança abrange múltiplos arquivos, ou você não conhece bem o código sendo modificado. Para uma mudança simples e bem delimitada — corrigir um erro de digitação, uma linha de log, renomear uma variável — o plan mode é uma sobrecarga desnecessária. O teste prático: se você conseguisse descrever o diff em uma frase, pule o plano e deixe o Claude executar direto.

{{< mermaid >}}
flowchart TD
    A[Nova tarefa] --> B{Você conseguiria descrever<br/>o diff em uma frase?}
    B -->|Sim| C[Execução direta]
    B -->|Não| D{Múltiplos arquivos, código<br/>desconhecido, ou abordagem incerta?}
    D -->|Sim| E[Plan mode]
    D -->|Não| C

    style C fill:#c9ddf6,stroke:#86b6ef,color:#0b0b0b
    style E fill:#2a78d6,stroke:#1c5cab,color:#fff
{{< /mermaid >}}

## Ponto-chave 5: itere com exemplos, testes e uma entrevista prévia — não com feedback vago

Três técnicas concretas para melhoria progressiva, todas sobre dar ao Claude algo contra o que checar o próprio trabalho, em vez de "melhore isso": fornecer **exemplos de entrada/saída** ("essa entrada deveria produzir aquela saída") em vez de descrever o comportamento de forma abstrata; **iteração orientada a testes**, em que o Claude roda uma checagem real — uma suíte de testes, um build, uma comparação de screenshot — e continua iterando até passar, em vez de parar no momento em que o trabalho apenas parece pronto; e o **padrão de entrevista** para funcionalidades maiores, em que você faz o Claude te perguntar sobre implementação técnica, UI/UX e casos extremos *antes* de escrever uma especificação e começar a implementação, trazendo à tona considerações que você talvez não tivesse pensado em mencionar de início.

## Uma nota rápida sobre escala: integração com CI/CD

Completando o domínio: o Claude Code roda de forma não interativa com a flag `-p` (ou `--print`), o que é o que o torna utilizável dentro de um pipeline de CI, um pre-commit hook, ou qualquer script, em vez de apenas uma sessão interativa de terminal. Combine com `--output-format json` para obter uma resposta estruturada que seu pipeline consegue interpretar programaticamente em vez de raspar texto simples — útil para qualquer coisa, de um linter de erros de digitação rodado em todo diff de PR a um resumidor de log de build que escreve suas descobertas num arquivo.

## O quanto isso pesa

![Gráfico de barras horizontais intitulado "Claude Code Configuration and Workflows ties for second-heaviest domain," mostrando os 5 domínios da prova Claude Certified Architect – Foundations com Claude Code Configuration and Workflows destacado em azul com 20%, empatado com Prompt Engineering and Structured Output, atrás de Agentic Architecture and Orchestration com 27%, e à frente de Tool Design and MCP Integration com 18% e Context Management and Reliability com 15%](domain-3-weight-chart.webp "Empatado em segundo lugar com 20% — hábitos de configuração que você monta uma vez e colhem em toda sessão seguinte")

## Conclusão

O Domínio 3 em uma passada: o CLAUDE.md tem uma hierarquia real — gerenciado, usuário, projeto, local — e imports permitem puxar material de referência sem duplicar conteúdo. Comandos e skills têm escopo por projeto vs. pessoal, e skills adicionam `context: fork` e `allowed-tools` para isolamento e acesso controlado a ferramentas. Rules com escopo por caminho mantêm as convenções de projetos grandes modulares sem inchar o contexto de toda sessão. O plan mode compensa sua sobrecarga em trabalho incerto e de múltiplos arquivos, e não custa nada num diff de uma frase só. A iteração funciona melhor com exemplos, checagens reais, e uma entrevista prévia para funcionalidades maiores. E `-p` mais `--output-format json` é o que transforma o Claude Code de uma ferramenta só-de-terminal num cidadão de CI/CD.

## Fontes

- [Claude Certified Architect – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542750%2FClaude+Certified+Architect+%E2%80%93+Foundations+Exam+Guide.pdf) — declarações de tarefa do Domínio 3
- [How Claude remembers your project — Claude Code Docs](https://code.claude.com/docs/en/memory) — hierarquia do CLAUDE.md, imports, `.claude/rules/`
- [Extend Claude with skills — Claude Code Docs](https://code.claude.com/docs/en/skills) — `context: fork`, `allowed-tools`, escopo de comandos
- [Best practices for Claude Code — Claude Code Docs](https://code.claude.com/docs/en/best-practices) — plan mode, verificação, o padrão de entrevista
- [Run Claude Code programmatically — Claude Code Docs](https://code.claude.com/docs/en/headless) — `-p`, `--output-format json`

A pesquisa e a checagem de precisão técnica contra a documentação oficial são feitas com apoio de IA; o enquadramento, os julgamentos sobre "o que isso significa para a prova" e eventuais histórias de campo são meus.

## Onde isso se encaixa

Parte 4 de **Tornando-se um Claude Architect**, seguindo o [Domínio 2 — Tool Design & MCP Integration]({{< ref "/posts/claude-architect-03-tool-design-mcp-integration/" >}}). A Parte 5 assume o [Domínio 4 — Prompt Engineering & Structured Output]({{< ref "/posts/claude-architect-05-prompt-engineering-structured-output/" >}}).
