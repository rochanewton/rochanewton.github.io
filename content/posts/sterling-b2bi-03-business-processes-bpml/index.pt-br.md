---
title: "Business Processes e BPML no IBM Sterling B2B Integrator: Duas Visões do Mesmo Motor"
date: 2026-09-09
description: O que um Business Process realmente é, o que é BPML, por que o Graphical Process Modeler e o BPML bruto são a mesma coisa vista de duas formas, e os elementos e cenários que mais importam quando um deles quebra.
tags:
  - ibm-sterling
  - b2bi
  - mft
  - middleware
  - architecture
  - bpml
categories:
  - IBM Sterling
series:
  - sterling-b2bi-architecture
series_order: 3
showAuthor: true
image: cover.png
---
## O que é um Business Process

Um **Business Process** é o fluxo de trabalho que encadeia adapters e services em algo que de fato realiza uma tarefa: receber um arquivo, validá-lo, mapeá-lo, criptografá-lo, entregá-lo a um adapter para envio, registrando cada etapa pelo caminho. É a coisa que a [Parte 1](/posts/sterling-b2bi-01-overview/) chamou de "a coisa mais parecida com um coração que a plataforma tem" — porque quase nada relevante acontece no Sterling B2B Integrator fora da execução de um deles.

Estruturalmente, um Business Process é apenas uma sequência de etapas com lógica de ramificação: chame este service, verifique esta condição, chame aquele adapter, trate de forma diferente se algo der errado. Nada nessa descrição exige um diagrama. E esse é exatamente o ponto.

## O que é BPML

**BPML** — Business Process Markup Language — é a linguagem baseada em XML na qual um Business Process é realmente escrito por baixo. Cada caixa que você arrasta no designer visual vira um elemento nesse markup; cada seta vira o aninhamento e o sequenciamento desses elementos. Não é um resumo simplificado do processo — é a definição literal e completa que o Business Process Engine executa. Nada roda que não esteja no BPML, incluindo qualquer coisa que o designer visual tenha gerado para você sem perguntar.

## GPM e BPML são a mesma coisa, vistas de formas diferentes

O **Graphical Process Modeler (GPM)** é a ferramenta que a maioria das pessoas aprende primeiro: arraste um ícone de service para o canvas, conecte-o à próxima etapa, e a ferramenta constrói o processo visualmente. O que é fácil de não perceber no início é que o GPM não é uma forma separada e simplificada de construir um Business Process — é um tradutor em tempo real. A própria documentação da IBM o descreve como uma ferramenta de interface gráfica implantada via web, usada para criar e modificar Business Processes ([Documentação IBM](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=processes-graphical-process-modeler)), e por baixo dos panos ela converte cada modelo gráfico que você constrói diretamente em BPML — e da mesma forma converte BPML existente de volta para o diagrama, deixando você alternar entre as duas visões do mesmo processo a qualquer momento.

Essa reversibilidade é a parte que vale a pena internalizar: nada se perde ao ir do diagrama para o código ou vice-versa. Um Business Process construído inteiramente arrastando ícones e um Business Process digitado à mão em um editor de texto são funcionalmente idênticos depois de salvos — o motor não sabe nem se importa qual dos dois você usou.

## Os elementos de BPML que você realmente vai usar

O BPML tem um vocabulário razoavelmente grande, mas um punhado de elementos cobre a esmagadora maioria do que você vai ler e escrever:

**OPERATION.** O elemento cavalo de batalha — este é o componente BPML usado para chamar um service ou adapter de dentro de um Business Process ([Documentação IBM](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=bpml-business-process-components)). Todo ícone que você arrasta no GPM representando um service ou adapter é compilado para uma OPERATION por baixo. Se você está procurando onde um service específico é invocado, você está procurando um bloco OPERATION.

**SEQUENCE.** O elemento estrutural que diz "essas etapas acontecem nesta ordem." A maior parte de um Business Process é uma grande SEQUENCE com outros elementos aninhados dentro dela — é o esqueleto no qual tudo o mais se pendura.

**CHOICE.** Ramificação condicional — faça isso se uma condição for verdadeira, faça outra coisa se não for. É aqui que normalmente mora a lógica de roteamento específica por parceiro: "se o trading partner for X, use o map A; senão, use o map B."

**ASSIGN.** Move dados entre a memória de trabalho do Business Process e os parâmetros de entrada ou saída de um service. Nada glamouroso, mas é aqui que uma grande fatia dos bugs de "o map pegou o campo errado" realmente se origina — não no map em si, mas em um ASSIGN que apontou para o pedaço de dado errado.

**ONFAULT.** Tratamento de erros. Quando uma etapa dentro de uma SEQUENCE falha, um bloco ONFAULT permite capturar essa falha e fazer algo deliberado a respeito — tentar de novo, notificar, rotear para uma mailbox de dead-letter — em vez de deixar o processo morrer silenciosamente. Um Business Process sem tratamento ONFAULT não está exatamente errado, mas é o motivo mais comum de "o arquivo simplesmente sumiu" virar uma investigação longa.

## Cenários: lendo e escrevendo BPML na prática

**Cenário 1 — Construindo um novo Business Process de entrada do zero.** Este é o terreno natural do GPM: arraste um ícone de adapter, arraste um service de validação, arraste um service de mapeamento, conecte tudo, salve. Para um primeiro rascunho, a ferramenta visual é mais rápida do que digitar BPML à mão, e é muito mais difícil produzir XML inválido por acidente.

**Cenário 2 — O GPM está lento ou indisponível, e um processo precisa de um pequeno ajuste agora.** É exatamente esse o momento que aquele engenheiro sênior estava demonstrando. Abrir o arquivo .bpml diretamente em um editor de texto, encontrar o bloco OPERATION ou ASSIGN em questão, e editá-lo à mão é totalmente válido — o motor não se importa com como o arquivo foi produzido. Estar confortável lendo BPML bruto transforma "eu preciso que o GPM carregue" em "eu preciso de um editor de texto", o que importa mais do que parece durante um incidente de verdade.

**Cenário 3 — A mesma pequena mudança precisa entrar em cinquenta Business Processes.** Clicar em cinquenta processos no GPM, um de cada vez, é uma tarde ruim. Rodar um script de busca-e-substituição em cinquenta arquivos .bpml não é. Este é o cenário onde saber BPML não é só uma habilidade de debugging — é a diferença entre uma hora de trabalho e uma semana dele.

**Cenário 4 — Um processo está falhando e ninguém sabe onde.** Comece pelos blocos ONFAULT — ou pela falta deles. Se uma SEQUENCE não tem tratamento de erro em volta da etapa que está falhando, esse geralmente é o conserto mais rápido disponível: envolva a etapa, registre o que de fato falhou, e a próxima falha se explica sozinha em vez de exigir outra investigação do zero.

## Por que a distinção realmente importa

O GPM é a ferramenta melhor para construir e entender a forma de um processo — a visão de caixas e setas deixa o fluxo geral óbvio de um jeito que tags XML aninhadas não conseguem. O BPML bruto é a ferramenta melhor para precisão, mudanças em massa, e qualquer coisa que precise acontecer quando a ferramenta visual está lenta, indisponível, ou simplesmente é exagero para um ajuste de duas linhas.

Nenhum dos dois é o Business Process "de verdade" e o outro um atalho. São a mesma definição, e qual usar depende inteiramente do que você está tentando fazer naquele momento — construir algo novo, ou consertar algo específico, rápido.

## Onde isso se encaixa no quadro geral

Toda chamada de adapter e service da [Parte 1](/posts/sterling-b2bi-01-overview/) e da [Parte 2](/posts/sterling-b2bi-02-adapters-vs-services/) acontece porque o BPML de um Business Process disse ao motor para fazer isso acontecer, nessa ordem, com aquele tratamento de erro. O GPM e o BPML bruto são só duas portas para editar o mesmo arquivo:

{{< mermaid >}}
flowchart TB
    subgraph Authoring["Duas Formas de Entrada"]
        GPM["Graphical Process Modeler<br/>(arrastar, conectar, alternar visão)"]
        TXT["Editor de Texto<br/>(editar .bpml diretamente)"]
    end

    BPML[("BPML<br/>(a definição de fato)")]
    ENGINE["Business Process Engine"]

    GPM <-->|gera / renderiza| BPML
    TXT <-->|lê / escreve| BPML
    BPML --> ENGINE

    ENGINE --> OP1["OPERATION<br/>(chama um Adapter)"]
    ENGINE --> OP2["OPERATION<br/>(chama um Service)"]
    ENGINE --> CH["CHOICE<br/>(ramificação)"]
    ENGINE --> OF["ONFAULT<br/>(trata falha)"]
{{< /mermaid >}}

Os dois caminhos de autoria convergem exatamente para o mesmo BPML, e o motor que de fato o executa não tem ideia — nem motivo para se importar — de qual porta você usou.

## Fontes e leituras complementares

- [Graphical Process Modeler](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=processes-graphical-process-modeler)
- [BPML Business Process Components](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=bpml-business-process-components)
- [Business Processes](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=integrator-business-processes)
- [Add error handling to a Business Process](https://www.ibm.com/docs/en/b2b-integrator/5.2?topic=processes-add-error-handling-business-process)
- [IBM Support: Business Process does not invoke any OnFault when a service fails with error](https://www.ibm.com/support/pages/business-process-does-not-invoke-any-onfault-when-service-fails-error)

Como no resto desta série, o enquadramento, os cenários e as histórias de guerra são meus — as definições e o comportamento dos elementos de BPML são da IBM.

## O que vem a seguir

A seguir: **SFTP: O Protocolo Por Trás do Adapter** — um olhar mais de perto sobre o transporte, a autenticação e a mecânica de chaves por trás do SFTP Server Adapter configurado na [Parte 2](/posts/sterling-b2bi-02-adapters-vs-services/).
