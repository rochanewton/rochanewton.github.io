---
title: "Mailboxes e File Gateway no IBM Sterling B2B Integrator: Uma Camada, Não Dois Produtos"
date: 2026-09-11
description: "O que uma Mailbox realmente é por baixo dos panos, como o File Gateway se apoia em mailboxes e adapters como uma camada de roteamento em vez de um produto concorrente, e os cenários reais de onboarding e resolução de problemas que aparecem em torno dos dois."
tags:
  - ibm-sterling
  - b2bi
  - mft
  - middleware
  - architecture
  - file-gateway
  - sfg
categories:
  - IBM Sterling
series:
  - sterling-b2bi-architecture
series_order: 5
showAuthor: true
image: cover.png
---

## A confusão que sinalizei lá na Parte 1

Mencionei isso na [Parte 1]({{< ref "/posts/sterling-b2bi-01-overview/" >}}) e prometi voltar ao assunto: **o File Gateway não é um produto separado concorrendo com o B2Bi.** É uma camada de UI e roteamento construída especificamente por cima da estrutura de mailbox e adapters do B2Bi, feita justamente para que a troca de arquivos com parceiros possa ser gerenciada sem que ninguém precise mexer diretamente em BPML. Ainda vejo gente que roda Sterling há anos falando dos dois como se fossem alternativas entre as quais você escolhe. Não são — um é a fundação, o outro é uma forma de trabalhar com essa fundação sem escrever um Business Process à mão.

Uma observação sobre nomenclatura antes de mais nada, porque causa confusão de verdade em vagas de emprego, chamados e conversas casuais: o **File Gateway é quase sempre chamado de "SFG" — Sterling File Gateway** — seu nome de produto de fato, distinto de "B2Bi" (Sterling B2B Integrator), mesmo que o SFG rode como um componente instalado por cima de um ambiente B2Bi em vez de um sistema independente. Quando alguém diz "a gente roda SFG," está se referindo especificamente a essa camada: o console de administração de Routes/Participants/Tools mostrado ao longo deste post, não o console de administração central do B2Bi das partes anteriores desta série. Vou usar "File Gateway" e "SFG" de forma intercambiável daqui para frente, já que você vai encontrar os dois por aí — a própria documentação da IBM, e-mails de parceiros e vagas de emprego misturam os dois.

Este post cobre primeiro a fundação de mailbox, e depois o que o SFG realmente adiciona por cima dela.

## O que é uma Mailbox

Uma **Mailbox** é uma caixa de entrega segura e com permissões dentro do B2Bi — uma estrutura de pastas virtual que existe como metadados e registros de banco de dados, não arquivos literais em um diretório, mesmo que se comporte como um para qualquer coisa que interaja com ela via SFTP, HTTP ou as APIs de Mailbox. Arquivos caem em uma mailbox, são retirados de uma, e toda operação contra ela tem permissão checada e é registrada da mesma forma que qualquer outra movimentação de documento na plataforma.

Duas coisas sobre esse enquadramento "virtual" importam na prática:

- **A hierarquia de mailbox é organizacional, não física.** Você constrói uma árvore — uma mailbox raiz, pontos de coleta compartilhados, mailboxes por parceiro por baixo — e é essa estrutura que parceiros e processos internos veem quando listam ou navegam mailboxes. Os bytes de fato ficam onde quer que o armazenamento de documentos do B2Bi esteja configurado para colocá-los; a hierarquia que você constrói não tem nada a ver com isso.
- **Permissões são atribuídas por mailbox, e são genuinamente por usuário/por grupo**, não só por adapter. As credenciais SFTP de um trading partner podem ser restritas para enxergar exatamente uma mailbox e nada mais na árvore acima ou ao lado dela — que é o mecanismo inteiro que permite que um único SFTP Server Adapter compartilhado sirva com segurança dezenas de parceiros sem relação entre si, distinguidos por mailbox e credenciais em vez de um adapter dedicado por parceiro.

Uma hierarquia típica se parece com isto:

{{< mermaid >}}
flowchart TD
    ROOT["Root Mailbox"]
    ROOT --> DL["Dead Letter Mailbox"]
    ROOT --> EDIIN["EDI Inbound Collection"]
    ROOT --> EDIOUT["EDI Outbound Collection"]
    ROOT --> PARTNERS["Trading Partners"]
    PARTNERS --> PA["Mailbox do Parceiro A"]
    PARTNERS --> PB["Mailbox do Parceiro B"]
    PARTNERS --> PC["Mailbox do Parceiro C"]
    PA --> PAIN["inbound/"]
    PA --> PAOUT["outbound/"]

    style DL fill:#4a1a1a,stroke:#c0392b
{{< /mermaid >}}

A **Dead Letter Mailbox** merece um destaque à parte: é para onde os arquivos vão quando não conseguem ser roteados para lugar nenhum — um nome de arquivo malformado, uma regra de roteamento sem correspondência, uma falha de permissão no meio do processo. Eu checo ela antes de checar quase qualquer outra coisa quando um parceiro diz "eu enviei o arquivo mas nada aconteceu," porque na maioria das vezes, ele está bem ali.

### Como um arquivo realmente entra e sai de uma mailbox

Nada na entrega de mailbox é específico de protocolo — a mesma mailbox pode receber gravação de um SFTP Server Adapter recebendo o upload de um parceiro, ser lida por um Business Process retirando um arquivo para traduzir, ou ser exposta através do próprio roteamento do File Gateway, tudo isso sem que a mailbox em si saiba ou se importe com qual caminho está sendo usado:

{{< mermaid >}}
sequenceDiagram
    participant Partner as Parceiro
    participant AD as SFTP Server Adapter
    participant MB as Mailbox
    participant BP as Business Process
    participant DB as Database

    Partner->>AD: Envia arquivo (SFTP PUT)
    AD->>MB: Entrega na mailbox do parceiro
    MB->>DB: Registra chegada, checa permissões
    Note over MB,BP: Evento de mailbox ou polling agendado dispara a retirada
    MB->>BP: Arquivo disponível para processamento
    BP->>BP: Roteia, mapeia, valida
    BP->>MB: Entrega resultado na mailbox de destino
    MB->>DB: Registra status de entrega
{{< /mermaid >}}

## O que o File Gateway (SFG) realmente é

Tirando o nome de marketing, o SFG é: um motor de roteamento, uma UI de gerenciamento de parceiros, e um conjunto de Business Processes prontos que a IBM entrega para que você não precise construir manualmente o mesmo padrão "receber, validar, rotear, confirmar entrega" do zero para cada relacionamento com parceiro. Ele roda *sobre* o B2Bi — mesmo motor, mesmos adapters, mesmas mailboxes — só te dá uma forma diferente, de nível mais alto, de configurar a troca de arquivos com parceiros, através do próprio console dedicado, organizado em três abas: **Routes**, **Participants** e **Tools**.

Concretamente, o SFG adiciona:

- **Partners e Communities** (a aba Participants) — uma forma estruturada de definir trading partners e agrupá-los em comunidades, em vez de permissões de mailbox e registros de trading partner gerenciados de forma independente um do outro. Aqui está a tela de gerenciamento de Groups — repare em "All Partners" como o grupo padrão, com a possibilidade de criar grupos adicionais e atribuir parceiros a eles:

![Tela Manage Groups do Sterling File Gateway, mostrando as abas Groups e Partners, com "All Partners" listado como um Sterling File Gateway Group e um painel para adicionar ou remover parceiros do grupo selecionado](sfg-manage-groups-partners.webp "A aba Participants do SFG — agrupando parceiros em comunidades em vez de gerenciar registros brutos de trading partner um por um")

- **Routing Channel Templates** (a aba Routes) — definições reutilizáveis de "quando um arquivo que bate com este padrão chega deste parceiro, valide desta forma, depois entregue aqui" — configuradas através de uma UI em vez de desenhadas no Graphical Process Modeler ou escritas como BPML bruto.
- **Arrived Files / rastreamento de consumo** (a aba Tools) — uma visão voltada ao parceiro (e ao administrador) do que chegou, do que foi retirado, e do que ainda está pendente, sem que ninguém precise consultar o banco de rastreamento de documentos diretamente. A tela de busca dentro de Tools permite consultar por tipo de mailbox, produtor, consumidor, nome de arquivo, status, protocolo e faixa de data/hora:

![Aba Tools do Sterling File Gateway, sub-aba Search Criteria, mostrando um formulário de Basic Search com campos para Mailbox Type, Producer, Consumer, Original File Name, Status, Protocol e faixas de Date/Time From e To](sfg-tools-search-criteria.webp "A busca de Arrived File dentro de Tools — é assim que 'rastreamento de consumo sem consultar o banco diretamente' se parece na prática")

Rodar essa busca contra atividade real retorna uma lista de resultados assim — cada arquivo chegado com seu status, produtor, nome de arquivo original e horário de descoberta:

![Resultados de busca de Arrived File do Sterling File Gateway mostrando 2 resultados, ambos com status Failed, produtor user001, nomes de arquivo test2.txt e test3.txt, e timestamps de descoberta](sfg-arrived-file-search-results.webp "Dois arquivos chegados, ambos Failed — exatamente o tipo de coisa que resolve a pergunta de um parceiro de \"eu enviei, você recebeu?\"")

Essa mesma aba Tools também tem uma sub-aba **Reports** para gerar um PDF formatado ou saída similar ao longo de uma faixa de datas, filtrado por grupo de produtor/consumidor e status (Started, Succeeded, Failed, Ignored) — útil para um relatório recorrente voltado a parceiro ou interno de SLA, em vez de consultas pontuais:

![Tela Reports do Sterling File Gateway dentro de Tools, com campos para Mailbox Type, Producer, Producer Group, Consumer, Consumer Group, Status (Started/Succeeded/Failed/Ignored), faixas de Date/Time, coluna Group by, Format (PDF), Report Type (Detailed/Summary) e coluna Sort by](sfg-reports.webp "Relatório agendado ou sob demanda sobre a atividade de arquivos chegados — essa é a ferramenta para \"quantos arquivos falharam para este parceiro mês passado,\" não uma busca pontual")

O roteamento em si ainda passa, no fim das contas, por mailboxes, e ainda dispara Business Processes — o File Gateway é a camada que gera e gerencia isso tudo para você com base nos canais de roteamento que você configura:

{{< mermaid >}}
flowchart LR
    subgraph FG["Camada do File Gateway"]
        RC["Routing Channel\nTemplates"]
        PM["Gerenciamento de Partner\n& Community"]
        AF["Rastreamento de\nArrived Files"]
    end

    subgraph Core["Núcleo do B2Bi (inalterado)"]
        AD["Adapters"]
        MB["Mailboxes"]
        BP["Business Processes"]
    end

    Partner["Parceiro Comercial"] --> AD
    AD --> MB
    RC -.configura.-> BP
    MB <--> BP
    BP --> AF
    PM -.governa.-> RC
{{< /mermaid >}}

Essa relação de linha pontilhada é o ponto central deste post: **o SFG configura e gerencia as mesmas peças subjacentes das Partes 1 a 4**, ele não as substitui nem as ignora. Quando algo quebra em uma troca gerenciada pelo SFG, você ainda está depurando um adapter, uma mailbox e um Business Process por baixo — a UI do SFG é só uma porta de entrada mais amigável para chegar lá, e ela até te mostra essa maquinaria subjacente diretamente quando você entra a fundo no log de eventos de um único arquivo chegado:

![Log de Arrived File Events do Sterling File Gateway, mostrando uma sequência de códigos de evento FG_0408 até FG_0410 rastreando um arquivo chegado chamado test2.txt, incluindo identificação do parceiro, determinação de rota contra um Routing Channel Template chamado "Producer subdir to 1 Consumer," e um evento de falha FG_0455 dizendo "Validation of message with partner failed"](sfg-arrived-file-events.webp "Cada caixa do fluxograma acima, rastreada como um único log de evento real — identificação do parceiro, entrega na mailbox, correspondência do canal de roteamento, e o ponto exato onde este falhou")

Lido de cima para baixo, esse log *é* o fluxograma: o arquivo chega (`FG_0408`), é entregue em uma mailbox (`FG_0425`), o parceiro produtor é identificado (`FG_0404`), a determinação de rota roda contra o Routing Channel Template correspondente (`FG_0501`–`FG_0504`), e — nesse caso — a validação contra o parceiro falha (`FG_0455`, em vermelho) antes que o roteamento consiga concluir. Quando a documentação do SFG ou um colega diz "confere os arrived file events," é exatamente isso que eles querem dizer, e geralmente é a forma mais rápida de descobrir *qual* etapa do pipeline de fato quebrou, em vez de tentar adivinhar.

## Quando usar o File Gateway vs. uma mailbox pura

**Use o File Gateway quando:** o onboarding de parceiro precisa ser repetível e majoritariamente self-service para quem estiver fazendo isso, quando você quer confirmação de entrega já embutida e uma visão de arquivos chegados visível ao parceiro sem construir uma do zero, ou quando o padrão de troca é genuinamente "receber de A, validar, entregar a B" sem ramificação condicional complexa que o routing channel template não consiga expressar de forma limpa.

**Vá direto para uma mailbox pura e um Business Process feito à mão (ou já existente) quando:** a lógica de roteamento é complexa o suficiente para que um routing channel template fique mais estranho do que simplesmente escrever o BPML diretamente, quando você está integrando com Business Processes existentes que já fazem validação/mapeamento sob medida que não se encaixa no padrão do File Gateway, ou para uso de mailbox puramente interno que nunca foi voltado a parceiro (um ponto de EDI Outbound Collection sendo lido por um processo interno agendado, por exemplo).

Na prática, a maioria dos onboardings de novos parceiros externos no padrão "entra por SFTP, entrega em algum lugar" passa pelo File Gateway hoje, especificamente porque só o rastreamento de Arrived Files já economiza uma quantidade relevante de idas e vindas de suporte do tipo "eles receberam?". Qualquer coisa com lógica condicional de verdade ou histórico legado ainda vive como um Business Process direto contra mailboxes.

## Cenários operacionais

**"O parceiro diz que fez upload, mas nada aconteceu."** Primeiro, checa a Dead Letter Mailbox — um nome de arquivo que não bate com o padrão esperado, ou um routing channel sem regra correspondente, manda um arquivo para lá silenciosamente em vez de falhar de forma visível. Segunda parada: a busca de Arrived File na aba Tools — filtrada por esse produtor e status `Failed`, geralmente traz à tona exatamente esse tipo de arquivo travado em segundos, do mesmo jeito que os dois resultados `Failed` mostrados antes fizeram. A partir daí, entrar a fundo no log de eventos do arquivo chegado (como acima) te diz *por quê* — uma falha de validação, um routing channel sem correspondência, ou algo mais acima no fluxo.

**Erros de escopo de permissão.** Como as permissões de mailbox são genuinamente granulares, é fácil conceder às credenciais SFTP de um parceiro uma visibilidade de mailbox mais ampla do que o pretendido — especialmente em um SFTP Server Adapter compartilhado servindo muitos parceiros. Vale a pena auditar periodicamente as permissões de mailbox contra a lista de trading partners, em vez de assumir que continuaram corretamente restritas conforme a lista de parceiros cresceu.

**Mudanças em routing channel template afetando tráfego ao vivo.** Editar um routing channel template que está ativamente em uso não é a mesma coisa que editar um Business Process offline — canais de roteamento podem afetar arquivos em trânsito e recém-chegados imediatamente. Trate mudanças de template com a mesma disciplina de controle de mudança que você aplicaria a uma edição de BPML em produção, não como um ajuste casual de console.

**Relatórios recorrentes de SLA de parceiro.** Em vez de buscar manualmente em Arrived Files toda vez que um parceiro pergunta "quantos dos nossos arquivos falharam mês passado," a sub-aba Reports dentro de Tools gera exatamente isso como um PDF formatado, filtrado por grupo de produtor/consumidor e status — vale a pena configurar como um hábito agendado para parceiros de alto volume, em vez de consultas reativas pontuais.

## Onde isso se encaixa na série

Isso fecha o ciclo da visão geral de componentes da [Parte 1]({{< ref "/posts/sterling-b2bi-01-overview/" >}}): o [Perimeter Server]({{< ref "/posts/sterling-b2bi-06-perimeter-servers/" >}}) e os [Adapters]({{< ref "/posts/sterling-b2bi-02-adapters-vs-services/" >}}) trazem o arquivo para dentro, Business Processes e BPML movem e transformam ele ([Parte 3]({{< ref "/posts/sterling-b2bi-03-business-processes-bpml/" >}})), SFTP é o protocolo que a maioria desses adapters de fato fala ([Parte 4]({{< ref "/posts/sftp-protocol-fundamentals/" >}})), e Mailboxes — com o File Gateway como uma forma opcional, de nível mais alto, de geri-las — são onde o arquivo pousa e é retirado. Uma peça do diagrama de topologia da Parte 1 ainda deve seu próprio aprofundamento: o próprio Perimeter Server, a seguir.

## Fontes e leituras complementares

- [Sterling File Gateway — Visão Geral](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=glance-sterling-file-gateway)
- [Criando uma Mailbox do Sterling B2B Integrator](https://www.ibm.com/docs/en/b2b-integrator/6.0.2?topic=interoperability-creating-sterling-b2b-integrator-mailbox)
- [Sterling B2B Integrator — Visão Geral](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=glance-sterling-b2b-integrator)

Como no resto desta série: as definições são da IBM, o enquadramento, o diagrama de roteamento e os cenários operacionais são meus.

## O que vem a seguir

A seguir: **Perimeter Servers** — o componente de DMZ que toda conexão de parceiro toca primeiro, mencionado lá na [Parte 1]({{< ref "/posts/sterling-b2bi-01-overview/" >}}) e nunca totalmente explicado até agora. Leia aqui: [Parte 6]({{< ref "/posts/sterling-b2bi-06-perimeter-servers/" >}}). O Map Editor vem depois disso.
