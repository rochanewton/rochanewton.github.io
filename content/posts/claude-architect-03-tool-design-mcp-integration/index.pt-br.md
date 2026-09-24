---
title: "Tornando-se um Claude Architect: Tool Design & MCP Integration — Domínio 2"
date: 2026-09-24
description: "18% da prova Claude Certified Architect – Foundations: escrever descrições de ferramentas que o modelo realmente consegue escolher entre si, respostas de erro estruturadas do MCP, tool_choice e acesso escopado, escopo de servidores MCP, e quando usar Grep vs. Glob vs. Edit."
tags:
  - claude
  - anthropic
  - certification
  - claude-architect
  - mcp
  - tool-use
  - claude-code
categories:
  - Claude
series:
  - becoming-a-claude-architect
series_order: 3
showAuthor: true
image: cover.png
---

## Do que se trata

O Domínio 2 — **Tool Design & MCP Integration** — representa 18% da prova Claude Certified Architect – Foundations, dividido em cinco áreas de tarefa: projetar interfaces de ferramentas, estruturar respostas de erro, distribuir ferramentas entre agentes, integrar servidores MCP e escolher bem as ferramentas nativas. É um domínio mais leve que Agentic Architecture, mas talvez o mais imediatamente prático — cada ponto aqui aparece na primeira vez que você dá a um agente uma ferramenta que não funciona do jeito que você esperava.

## Ponto-chave 1: a descrição da ferramenta *é* o mecanismo de seleção

Um LLM não lê o código da sua ferramenta antes de decidir chamá-la — ele lê a **descrição**. Essa é toda a base da seleção de ferramentas, o que significa que uma descrição mínima ("busca arquivos") é um risco no momento em que você tem duas ferramentas que poderiam plausivelmente atender a um mesmo pedido. A correção que a prova cobra é específica: descrições devem incluir formatos de entrada, exemplos de consultas, casos extremos e limites explícitos — o que a ferramenta faz *e* o que ela não cobre. Na prática, isso costuma significar renomear ferramentas para eliminar sobreposição funcional, ou dividir uma ferramenta genérica em várias específicas com contratos bem definidos, em vez de tentar escrever uma descrição cada vez mais longa para uma ferramenta que faz coisa demais.

## Ponto-chave 2: erros estruturados permitem que o agente se recupere, erros genéricos não

Quando uma chamada de ferramenta falha, "Operação falhou" não diz nada que o modelo consiga usar. O mecanismo real do MCP distingue duas camadas: **erros de protocolo** (requisição malformada, ferramenta desconhecida — retornados como erros JSON-RPC, e menos recuperáveis) versus **erros de execução de ferramenta** (falhas de validação, erros de lógica de negócio, falhas de API — retornados dentro do resultado da ferramenta com `isError: true`, especificamente para que o modelo consiga se autocorrigir e tentar de novo com parâmetros ajustados). A habilidade no nível de arquiteto vai além da flag isolada: retornar metadados de erro estruturados que categorizam a falha (transitório, validação, negócio, permissão) com uma flag de "pode tentar de novo", e distinguir uma falha de acesso genuína de um resultado válido, porém vazio — porque essas duas coisas nunca deveriam parecer iguais para o agente.

## Ponto-chave 3: menos ferramentas por agente, escolhidas de propósito

O guia oficial da prova afirma isso quase como uma regra prática: dar a um agente acesso a ferramentas demais — o exemplo usado é 18 em vez de 4-5 — degrada a confiabilidade da seleção de ferramentas. A correção não é reduzir as capacidades no geral, é o **acesso escopado**: dar a cada subagente só as ferramentas relevantes para o seu papel, e substituir uma ferramenta genérica demais por uma alternativa mais restrita e específica quando um subagente insiste em usá-la mal. A API do Claude te dá uma segunda alavanca para o mesmo problema: `tool_choice`. `auto` deixa o Claude decidir se chama alguma ferramenta; `any` (ou uma escolha forçada de `tool` nomeando uma específica) garante que uma ferramenta seja usada, o que é a decisão certa quando você precisa que uma ferramenta em particular seja chamada primeiro, antes de o Claude raciocinar sobre qualquer outra coisa.

## Ponto-chave 4: servidores MCP têm escopo por um motivo — não use o errado por padrão

O Claude Code separa a configuração de servidores MCP por escopo: **nível de projeto** (`.mcp.json`, versionado no controle de versão) é para ferramentas compartilhadas do time que todo mundo no repositório recebe automaticamente, enquanto **nível de usuário** (`~/.claude.json`) é para servidores pessoais ou experimentais que você não quer commitar. Credenciais passam por expansão de variável de ambiente (`${API_KEY}`, com sintaxe de fallback `${VAR:-default}`) em vez de ficarem fixas no arquivo de configuração, o que é o que torna um `.mcp.json` seguro para commitar em primeiro lugar — o arquivo tem o formato da configuração, não o segredo. O outro hábito no nível de arquiteto que vale destacar: preferir um servidor MCP comunitário já existente e bem mantido antes de construir um customizado, e expor conteúdo de leitura pesada (como um catálogo ou base de conhecimento) como **resources** do MCP, em vez de embrulhá-lo numa ferramenta que só retorna um bloco de texto.

| | Escopo de projeto (`.mcp.json`) | Escopo de usuário (`~/.claude.json`) |
|---|---|---|
| Carrega em | Projeto atual | Todos os seus projetos |
| Compartilhado com o time | Sim, via controle de versão | Não |
| Uso típico | Ferramentas compartilhadas do time | Servidores pessoais ou experimentais |

## Ponto-chave 5: escolha a ferramenta nativa certa para o trabalho

A prova também cobra julgamento simples de seleção de ferramenta entre as nativas do próprio Claude Code. **Grep** é para busca de conteúdo — encontrar onde uma função é chamada em uma base de código. **Glob** é para correspondência de padrão de *caminho* de arquivo — encontrar arquivos por nome ou extensão, não pelo que está dentro deles. **Read** e **Write** lidam com operações de arquivo inteiro; **Edit** é para uma modificação pontual e no lugar, em vez de reescrever um arquivo inteiro. Encadeadas bem, essas ferramentas constroem entendimento de código incrementalmente — Glob para achar candidatos, Grep para restringir por conteúdo, Read para confirmar, Edit para alterar — em vez de usar Read em todo arquivo de um diretório por precaução.

{{< mermaid >}}
flowchart TD
    A[O que você precisa fazer?] --> B{Está buscando algo?}
    B -->|Por nome/padrão de arquivo| C[Glob]
    B -->|Por conteúdo do arquivo| D[Grep]
    A --> E{Está alterando um arquivo?}
    E -->|Mudança pequena e pontual| F[Edit]
    E -->|Leitura ou reescrita completa| G[Read / Write]

    style C fill:#c9ddf6,stroke:#86b6ef,color:#0b0b0b
    style D fill:#c9ddf6,stroke:#86b6ef,color:#0b0b0b
    style F fill:#2a78d6,stroke:#1c5cab,color:#fff
    style G fill:#86b6ef,stroke:#5598e7,color:#0b0b0b
{{< /mermaid >}}

## O quanto isso pesa

![Gráfico de barras horizontais intitulado "Tool Design and MCP Integration is a mid-weight domain, but a foundational one," mostrando os 5 domínios da prova Claude Certified Architect – Foundations com Tool Design and MCP Integration destacado em azul com 18%, atrás de Agentic Architecture and Orchestration com 27% e de Claude Code Configuration and Workflows e Prompt Engineering and Structured Output empatados com 20% cada, e à frente de Context Management and Reliability com 15%](domain-2-weight-chart.webp "18% da prova, mas o domínio com mais chance de quebrar seu primeiro agente em produção")

## Conclusão

O Domínio 2 em uma passada: a descrição é a interface — escreva-a como se o modelo estivesse escolhendo às cegas, porque é exatamente isso. Erros estruturados com `isError` e uma flag de categoria/pode-tentar-de-novo permitem que um agente se recupere em vez de simplesmente falhar. Menos ferramentas, bem escopadas por agente, vencem uma lista de ferramentas de pia de cozinha, e `tool_choice` te dá uma segunda alavanca para garantir que a certa seja chamada. Servidores MCP se dividem claramente entre compartilhado-de-projeto e pessoal-de-usuário por um motivo — respeite esse escopo. E as ferramentas nativas recompensam quem escolhe de propósito: Grep para conteúdo, Glob para caminhos, Edit para mudanças pequenas, Read/Write para arquivos inteiros.

## Fontes

- [Claude Certified Architect – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542750%2FClaude+Certified+Architect+%E2%80%93+Foundations+Exam+Guide.pdf) — declarações de tarefa do Domínio 2
- [Tools — Model Context Protocol specification](https://modelcontextprotocol.io/specification/draft/server/tools) — `isError`, erros de protocolo vs. erros de execução de ferramenta
- [Implement tool use — Claude API Docs](https://platform.claude.com/docs/en/agents-and-tools/tool-use/implement-tool-use) — opções de `tool_choice`
- [Connect Claude Code to tools via MCP — Claude Code Docs](https://code.claude.com/docs/en/mcp) — escopo de servidor de projeto vs. usuário, expansão de variável de ambiente

A pesquisa e a checagem de precisão técnica contra a documentação oficial são feitas com apoio de IA; o enquadramento, os julgamentos sobre "o que isso significa para a prova" e eventuais histórias de campo são meus.

## Onde isso se encaixa

Parte 3 de **Tornando-se um Claude Architect**, seguindo o [Domínio 1 — Agentic Architecture & Orchestration]({{< ref "/posts/claude-architect-02-agentic-architecture-orchestration/" >}}). A Parte 4 assume o [Domínio 3 — Claude Code Configuration & Workflows]({{< ref "/posts/claude-architect-04-claude-code-configuration-workflows/" >}}).
