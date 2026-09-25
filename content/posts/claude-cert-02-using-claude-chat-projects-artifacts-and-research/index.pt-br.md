---
title: Você Está Usando o Claude Como se Fosse o ChatGPT de 2020
date: 2026-09-12
description: Se o Claude é só uma janela de chat pra você, você está reexplicando seu contexto toda sessão e jogando fora seu melhor resultado. Projects, Artifacts e Research resolvem isso — veja como eu uso cada um na prática.
tags:
  - claude
  - anthropic
  - projects
  - artifacts
  - research
  - certification
categories:
  - Claude
series:
  - getting-claude-certified
series_order: 2
showAuthor: true
image: cover.png
aliases:
  - /posts/using-claude-beyond-chat/
---

## A janela de chat é onde a maioria para

Você abre o Claude, digita uma pergunta, recebe uma resposta, fecha a aba. Na semana seguinte, uma tarefa parecida aparece, e lá está você de novo: a mesma janela de chat em branco, explicando tudo do zero — quem você é, no que está trabalhando, o que significa um bom resultado nesse tipo de tarefa. Se essa é toda a sua relação com a ferramenta, você está usando uma das ferramentas mais capazes disponíveis hoje exatamente como usaria uma caixa de busca — ou, mais precisamente, exatamente como as pessoas usavam o ChatGPT em 2020, quando um contexto novo a cada sessão era simplesmente como essas coisas funcionavam.

Não é mais assim, e tratar o Claude dessa forma custa mais caro do que parece.

## O que reexplicar tudo a cada sessão realmente custa

Nada disso aparece como uma falha dramática única. Aparece como atrito que você já parou de perceber.

Você reenvia as mesmas diretrizes de marca, as mesmas notas de arquitetura, o mesmo "é assim que nosso time escreve documentação", toda vez, porque o chat anterior não carregou nada disso adiante. Você recebe de volta um diagrama ou rascunho genuinamente útil, e ele vive exatamente na profundidade de uma rolagem de tela dentro da transcrição do chat — encontrável se você lembrar qual conversa foi, perdido na prática se não lembrar. Você faz uma pergunta que realmente precisa que alguém vasculhe várias fontes, compare e sintetize uma resposta de verdade, e recebe de volta uma resposta confiante de uma única passada que parece ter feito esse trabalho, mas não fez. Parecia completa. Não era. E a próxima pessoa do seu time que fizer a mesma pergunta que você já resolveu começa do zero também, porque nada do que você descobriu está em nenhum lugar que o Claude — ou ela — consiga encontrar.

Nada disso é uma limitação do Claude. É uma limitação do Chat, e o Chat é uma entre [várias formas de trabalhar com o Claude](https://support.claude.com/en/collections/4078531-claude), não a única.

![Quatro formas de trabalhar com o Claude: Chat para perguntas rápidas e tarefas pontuais, Projects para manter contexto e instruções em um só lugar, Artifacts para conteúdo que sobrevive à conversa, e Research para respostas mais profundas com múltiplas fontes, ilustrado como um caminho do "chat pontual" até a "produtividade real com o Claude"](claude-4-surfaces-overview.webp "O mapa do resto deste post — quatro superfícies, quatro tarefas diferentes")

## Chat: ainda é a ferramenta certa para muita coisa

Para ficar claro, o Chat não é o problema — é o padrão, e padrões existem justamente para dar conta bem da maioria dos casos. Uma pergunta pontual, um rascunho rápido, uma conversa de "me ajuda a pensar nisso" que não vai precisar existir na semana que vem: o Chat é exatamente certo para isso. O erro não é usar o Chat. É usar *só* o Chat para um trabalho que na verdade é contínuo, reutilizável, ou complexo o suficiente para exigir investigação de verdade.

![A interface do Claude Chat com uma troca rápida de mensagens, ao lado de uma lista de "quando usar": perguntas rápidas, brainstorm de ideias, rascunhos ou resumos curtos, explorar um novo assunto, tarefas pontuais, e qualquer coisa que você não vai precisar de novo depois](claude-chat-reference.webp "A própria limitação do Chat, dita sem rodeios: o contexto não persiste entre chats separados")

Aqui está o que eu uso no lugar disso, e quando.

## Projects: pare de reenviar o mesmo contexto

Um [project](https://support.claude.com/en/articles/9517075-what-are-projects) é um espaço de trabalho autocontido, com sua própria base de conhecimento, suas próprias instruções e seu próprio histórico de conversas — separado do seu Chat comum. Você envia o material de referência uma vez (as convenções de escrita do meu site, rascunhos de posts anteriores, minhas notas de currículo e certificações), escreve as instruções uma vez ("voz de praticante em primeira pessoa, citar fontes no corpo do texto, nenhuma comparação entre as categorias IBM Sterling e Claude") e toda conversa dentro daquele project já tem tudo isso disponível. Sem reexplicar.

Eu mantenho um project específico para este blog. Quando começo a escrever um novo post, o Claude já sabe o formato do frontmatter, o tom que eu quero e a única regra rígida sobre não cruzar links entre meu conteúdo de middleware e meu conteúdo sobre Claude — porque eu disse isso uma vez, nas instruções do project, em vez de repetir toda vez que abro um chat novo. É esse o valor todo: o contexto se acumula em vez de reiniciar.

O gatilho prático para "isso deveria ser um project, não mais um chat" é simples — se você consegue imaginar fazendo uma variação da mesma pergunta de novo no mês que vem, isso pertence a um project.

![A interface do Claude Projects mostrando a base de conhecimento, as instruções e a lista de conversas de um project, ao lado de uma lista de "quando usar": trabalho contínuo, reutilizar os mesmos documentos, estilo e resultado consistentes, colaboração em equipe, tarefas relacionadas ao longo do tempo, e quando você quer que o contexto se acumule](claude-projects-reference.webp "O que realmente vive dentro de um project — conhecimento, instruções e conversas, tudo dentro de um único espaço de trabalho")

## Artifacts: o resultado deveria sobreviver à conversa

Um [artifact](https://support.claude.com/en/articles/9487310-what-are-artifacts-and-how-do-i-use-them) é um conteúdo substancial o suficiente para ganhar sua própria janela dedicada ao lado da conversa — um documento, um diagrama, uma página HTML funcional, um trecho de código — em vez de um bloco de texto enterrado no chat que você nunca vai rolar a tela para encontrar de novo. O Claude cria um automaticamente quando algo cruza a linha para "significativo e autocontido": geralmente mais de 15 linhas, e algo que você realmente vai editar, reutilizar ou consultar depois, em vez de só ler uma vez.

A distinção que importa aqui não é o tamanho, é a descartabilidade. Uma explicação rápida pertence ao chat. Um diagrama do seu processo de onboarding, o primeiro rascunho de um relatório, um protótipo funcional — essas coisas têm vida depois que a conversa termina, e enterrá-las na rolagem do chat é como você as perde. Usei exatamente isso para o [gráfico do iceberg do framework 4D](/posts/claude-cert-01-fluency-4d-framework/) no primeiro post desta série: ele precisava existir como algo que eu pudesse extrair, refinar e reutilizar no LinkedIn — não como uma descrição no meio de uma resposta de chat.

Se você pedir algo substancial e o Claude apenas responder no chat em vez de criar um artifact, você pode pedir diretamente: "crie isso como um artifact." Nem sempre é automático, e vale a pena pedir.

![Uma conversa no Claude pedindo um diagrama de arquitetura em nuvem, com o artifact resultante exibido em seu próprio painel, ao lado de uma lista de "quando usar": documentos e relatórios, diagramas e visualizações, código e protótipos, aplicativos interativos, conteúdo que você quer editar, e conteúdo que você quer reutilizar ou compartilhar](claude-artifacts-reference.webp "O painel do artifact ao lado do chat — o resultado ganha seu próprio espaço em vez de viver perdido na rolagem")

## Research: quando a resposta realmente exige investigação

O [Research](https://support.claude.com/en/articles/11088861-use-research-on-claude) é onde o problema da "resposta confiante de uma única passada que só parece completa" realmente se resolve. Ative e o Claude para de fazer uma única busca — ele planeja uma abordagem, executa várias buscas que se constroem uma sobre a outra, decide o que investigar em seguida com base no que já encontrou, e compila o resultado em um relatório com citações que você pode conferir de verdade. Leva minutos em vez de segundos, porque está fazendo minutos de trabalho em vez de segundos de trabalho.

Essa troca é o ponto principal, e significa que o Research não é a escolha certa para tudo. Um fato rápido — a data de hoje, um número específico, uma afirmação pontual — não precisa disso; uma única busca na web responde mais rápido e o Research só seria mais lento sem ganho nenhum. Onde ele realmente vale o tempo é em trabalho comparativo ou de múltiplos ângulos: avaliar um punhado de opções pelos mesmos critérios, reunir um panorama técnico espalhado por várias fontes de documentação, ou sintetizar o que já foi discutido nas suas próprias ferramentas conectadas antes de somar pesquisa externa. O teste que eu uso: se a resposta honesta para "quantas fontes eu precisaria checar para realmente confiar nisso?" é mais do que duas ou três, isso é uma pergunta para o Research, não para o Chat.

![O processo de quatro etapas do Research mostrado como um fluxo — planejar abordagem, pesquisar múltiplas fontes, analisar e sintetizar, entregar resposta detalhada — ao lado de uma lista de "quando usar": perguntas complexas ou que exigem pesquisa, múltiplas fontes que precisam ser analisadas, uma resposta sintetizada e baseada em fatos, temas onde precisão e profundidade importam, e quando uma única busca não é suficiente](claude-research-reference.webp "A etapa que a maioria pula mentalmente: o Research planeja antes de pesquisar, em vez de fazer uma única busca e considerar resolvido")

## Combine a ferramenta com a tarefa

| | Chat | Projects | Artifacts | Research |
| --- | --- | --- | --- | --- |
| **Persiste entre sessões?** | Não | Sim — base de conhecimento + instruções | Sim — vive na própria janela | Não — o resultado pode virar um artifact |
| **Melhor para** | Perguntas pontuais, rascunhos rápidos | Trabalho contínuo com contexto reutilizável | Resultados substanciais e reutilizáveis | Investigação de múltiplas fontes |
| **Pule quando** | A tarefa é realmente contínua | É um caso pontual de verdade | O conteúdo é curto ou descartável | Uma ou duas fontes resolveriam |

Nenhuma dessas quatro ferramentas substitui a outra. Elas se combinam — um project guardando seu contexto, produzindo um artifact que vale a pena manter, disparando ocasionalmente uma passada de Research quando uma pergunta dentro daquele project exige investigação de verdade. O Framework 4D da Parte 1 desta série é exatamente isso em miniatura: Delegation e Description são você decidindo qual dessas ferramentas a tarefa realmente pede e dizendo isso com clareza; Discernment e Diligence continuam sendo seus, independente de qual ferramenta você usou.

## Uma declaração de diligência, já que a série insiste que eu escreva uma

Colaborei com o Claude para pesquisar e redigir este post, partindo da própria documentação de suporte da Anthropic sobre Projects, Artifacts e Research, e da minha experiência usando cada um deles neste site. O enquadramento, os exemplos e o argumento de "combine a ferramenta com a tarefa" são meus; conferi as descrições das funcionalidades com a documentação linkada antes de publicar e assumo isto como um relato preciso de como essas ferramentas funcionam e de como eu realmente as uso.

## Fontes e leitura complementar

- [Central de Ajuda do Claude — primeiros passos](https://support.claude.com/en/collections/4078531-claude)
- [O que são projects?](https://support.claude.com/en/articles/9517075-what-are-projects)
- [O que são artifacts e como usá-los?](https://support.claude.com/en/articles/9487310-what-are-artifacts-and-how-do-i-use-them)
- [Usando o research no Claude](https://support.claude.com/en/articles/11088861-use-research-on-claude)

Como no resto deste site: as definições das funcionalidades são da Anthropic, o enquadramento e o argumento de que "você está deixando valor na mesa" são meus.

## Onde isso se encaixa

Esta é a Parte 2 de **Getting Claude Certified**. A Parte 1 cobriu o [Framework 4D](/posts/claude-cert-01-fluency-4d-framework/) — a camada de decisão por trás de tudo. Este post é a camada de superfície: qual recurso do Claude usar de fato depois que essa decisão já foi tomada.

## O que vem a seguir

A Parte 3, [Domínio 1 — Avaliação e Validação de Resultados]({{< ref "/posts/claude-cert-03-output-evaluation-and-validation/" >}}), aprofunda o Discernment: é o domínio de maior peso na prova de certificação de verdade, e merece o mesmo rigor que eu aplicaria para verificar qualquer outro sistema antes de confiar nele em produção.
