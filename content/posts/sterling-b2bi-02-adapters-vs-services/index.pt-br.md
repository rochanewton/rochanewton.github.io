---
title: "IBM Sterling B2B Integrator: Adapters vs. Services — A Distinção Que Realmente Importa"
date: 2026-09-08
description: Por que "adapter" e "service" não são jargões intercambiáveis no Sterling B2B Integrator — o que cada um é, os que você realmente vai usar, e cenários reais para escolher entre eles.
tags:
  - ibm-sterling
  - b2bi
  - mft
  - middleware
  - architecture
categories:
  - IBM Sterling
series:
  - sterling-b2bi-architecture
series_order: 2
showAuthor: true
image: cover.png
---
## O que é um Adapter

Um **Adapter** é um service cujo trabalho inteiro é alcançar o mundo fora do Sterling B2B Integrator — conectando o Business Process Engine a "sistemas e aplicações diferentes" que vivem fora do ambiente ([Documentação IBM](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=integrator-services-adapters)). Um adapter SFTP abre uma conexão com o servidor SFTP de um parceiro. Um adapter AS2 fala o protocolo AS2 com o gateway de um parceiro comercial. O mecanismo por baixo é o mesmo de qualquer outro service — o Business Process Engine o chama, ele executa, retorna um resultado — mas o trabalho em si acontece em outro lugar, através de uma rede, contra um sistema que você não controla.

## O que é um Service

Um **Service** é a categoria ampla: qualquer conjunto de instruções que o Business Process Engine usa para realizar uma atividade dentro de um Business Process. Isso é propositalmente amplo — services cobrem desde mapear um documento de um formato para outro, validar um campo contra um schema, criptografar um payload, checar uma condição e ramificar, até pausar um processo para esperar que uma pessoa clique em "aprovar" em um formulário web.

O fio que conecta tudo isso é que um service faz seu trabalho usando dados que o Business Process já tem, ou produz dados que o Business Process vai usar em seguida. Ele não precisa sair do sistema para fazer o seu trabalho.

Juntando os dois você tem a distinção inteira em uma linha: **todo adapter é um service, mas nem todo service é um adapter.** Vale a pena parar para pensar nisso, porque isso explica quase toda conversa confusa que você vai ter sobre essa plataforma.

Existe uma divisão em três partes que vale a pena conhecer, porque ela aparece o tempo todo assim que você começa a ler logs de Business Process: services internos processam parâmetros e produzem resultados sem nunca sair do sistema; adapters de entrada e saída são os que alcançam o mundo externo; e existe uma categoria separada, os services de interação humana, que existem puramente para pausar um processo até que uma pessoa aja, tipicamente através de um navegador web aprovando ou rejeitando uma etapa. Essa última categoria é a que mais confunde as pessoas, porque tecnicamente "é só um service", mas se comporta de um jeito completamente diferente dos services de mapeamento e validação que as pessoas imaginam por padrão.

Um único node em um ambiente real facilmente chega à casa das centenas de services registrados quando você conta cada adapter, tradutor e service utilitário instalado — este é um único node em uma implantação de porte produtivo:

![Lista de configuração de Services no console de administração do Sterling B2B Integrator para o node2, mostrando 444 services incluindo ACH Deenvelope, AFT Route, Alert Service, AS2 Global Mailbox Cleanup e services AS3](services-configuration-list.webp "444 services em um único node — a maioria deles você nunca vai tocar diretamente")

## Os adapters que você realmente vai usar

O Sterling vem com dezenas de adapters, mas na prática a maioria das implantações se apoia em um punhado deles, repetidamente, porque a maioria dos requisitos de parceiro comercial se resume a um punhado de protocolos:

**SFTP Adapter (Client e Server).** A escolha padrão para novas conexões de parceiro quando ninguém está ditando o contrário. É criptografado, quase toda equipe de TI de parceiro já sabe como configurar um, e o esforço de setup é baixo comparado ao AS2. Eu recorro ao SFTP primeiro, a menos que a equipe de segurança ou compliance do próprio parceiro exija especificamente outra coisa. Aqui está uma configuração real de SFTP Client Adapter — repare como há pouca coisa nela de fato: um nome de sistema, um ambiente, uma atribuição de [perimeter server](/posts/sterling-b2bi-06-perimeter-servers/) e limites de threads:

![Tela de configuração do SFTP Client Adapter 2.0 no console de administração do Sterling B2B Integrator, mostrando configurações de service incluindo nome do sistema, ambiente, perimeter server e limites de threads](sftp-client-adapter-config.webp "SFTP Client Adapter 2.0 — uma configuração mínima, majoritariamente com valores padrão")

O adapter do lado Server carrega uma superfície bem maior, porque agora é você quem está sendo conectado: porta de escuta, chave de identidade do host, preferências de cifra e MAC, requisitos de autenticação e roteamento de mailbox, tudo mora aqui:

![Tela de configuração do SFTP Server Adapter 2.0 no console de administração do Sterling B2B Integrator, mostrando porta de escuta, chave de identidade do host, protocolos habilitados, preferências de cifra e MAC, e configurações de autenticação](sftp-server-adapter-config.webp "SFTP Server Adapter 2.0 — este é o lado da conexão contra o qual os parceiros de fato se autenticam")

**AS2 Adapter.** O que você não escolhe — é o que um parceiro impõe. O AS2 é construído em torno de mensagens assinadas e criptografadas com Message Disposition Notifications (MDNs), que dão aos dois lados um recibo criptográfico provando que um arquivo chegou intacto. Esse recibo é exatamente o motivo pelo qual grandes varejistas, redes de logística e qualquer um que rode EDI em escala tende a exigi-lo: quando surge uma disputa sobre se um pedido de compra foi realmente entregue, o MDN resolve a questão. O custo é o setup — certificados, perfis de parceiro e configuração de MDN precisam bater exatamente dos dois lados, e um certificado incompatível é, de longe, a dor de cabeça mais comum que já enfrentei em onboarding de AS2.

**Connect:Direct Adapter.** Esse é o que as pessoas subestimam até precisarem dele. O Connect:Direct é construído para entrega garantida, com retomada por checkpoint, de arquivos grandes entre sistemas que não podem tolerar uma transferência falha precisando recomeçar do byte zero — pense em arquivos de batch de fim de dia entre bancos, ou arquivos de múltiplos gigabytes em logística e manufatura. Se uma transferência cai em 80%, o Connect:Direct retoma a partir de 80%, não do zero. Esse único recurso é o motivo pelo qual ele ainda é padrão em finanças e outros ambientes corporativos de alto volume, custo de licença e tudo.

**HTTP/HTTPS Client Adapter.** O adapter para integrações modernas, no estilo de API — chamando o endpoint REST de um parceiro, recebendo um callback estilo webhook, ou conversando com microsserviços internos em vez de um mainframe legado. É o que mais cresceu em relevância à medida que mais ecossistemas de parceiros comerciais migram da troca pura de arquivos em batch para APIs de request/response.

**FTP Adapter.** Ainda por aí, ainda funcionando, e geralmente o adapter do qual eu tento migrar os parceiros *para longe* quando tenho a chance — o FTP puro envia credenciais e dados sem criptografia, a menos que seja tunelado por algo. Ele sobrevive basicamente por inércia legada, não porque alguém o escolheria hoje.

**Command Line Adapter 2 (CLA2).** A válvula de escape. Quando um Business Process precisa repassar a tarefa para um script de verdade ou um executável legado anterior à plataforma, o CLA2 é a ponte — genuinamente útil, mas também geralmente um sinal de que alguma coisa upstream nunca foi devidamente re-plataformada.

## Os services que você realmente vai usar

Menos categorias aqui, mas elas aparecem em praticamente todo Business Process, independentemente de quais adapters estejam envolvidos:

**Services de Tradução / EDI** (X12, EDIFACT e similares). Convertem o envelope EDI bruto de um parceiro em algo com o qual o resto do processo — e seus sistemas downstream — consegue de fato trabalhar, e de volta ao formato original na saída. Se a sua organização faz qualquer EDI, um desses roda em quase todo documento de entrada e saída.

**Services de Mapeamento**, construídos no Map Editor. É onde a tradução campo a campo de fato acontece: do formato do parceiro para o seu formato interno, ou o inverso. É aqui que a maioria das investigações de "por que esse documento falhou" acaba, porque um map só lida com os formatos de dado para os quais foi construído e testado — um campo inesperado, um novo valor de código, ou um parceiro mudando silenciosamente o formato dele é um problema de map, não de conectividade.

**Services de Validação.** Verificam um documento contra um schema ou um conjunto de regras de negócio antes que qualquer coisa downstream confie nele. Um seguro barato: pegar um documento malformado aqui é bem menos doloroso do que pegá-lo três sistemas adiante.

**Services de Criptografia/Descriptografia**, mais comumente PGP. Muitos parceiros exigem arquivos criptografados em PGP independentemente de qual transporte os carrega, já que a criptografia de transporte (como o próprio TLS do SFTP ou do AS2) só protege o dado em trânsito — o PGP protege o arquivo em si, inclusive enquanto ele está parado em uma mailbox esperando para ser retirado.

**Services de Interação Humana.** O caso fora da curva, e vale a pena se acostumar em vez de ficar confuso com ele. Eles são genuinamente um service pela própria definição da plataforma, mas o trabalho inteiro deles é pausar um processo até que uma pessoa clique em aprovar ou rejeitar em um formulário web — útil para qualquer coisa que precise de uma etapa de revisão manual, como uma fatura anormalmente grande ou o primeiro documento de um parceiro novo.

### Services operacionais que vale a pena conhecer

Nem todo service toca o documento de um parceiro comercial. Uma parte dessa lista de 444 services é pura manutenção interna da plataforma — services que mantêm o próprio sistema saudável, em vez de mover o arquivo de alguém. Dois valem a pena conhecer pelo nome:

**Alert Service.** Propositalmente mínimo — o trabalho inteiro dele é checar seus workflows e disparar um alerta quando algo precisa de atenção. Geralmente é uma das primeiras coisas configuradas em um ambiente novo, porque "quebrou alguma coisa durante a noite" precisa de uma resposta que não dependa de alguém checar logs manualmente.

![Tela de configuração do Alert Service no console de administração do Sterling B2B Integrator, mostrando tipo de service, descrição "Check the Workflows" e nome do sistema](alert-service-config.webp "Alert Service — pequeno de propósito, e geralmente um dos primeiros services configurados em um ambiente novo")

**BackupService.** Roda em um horário programado (2h da manhã na maioria dos ambientes que já vi) para arquivar dados de Business Process concluídos ou encerrados em blocos, para que o database da [Parte 1](/posts/sterling-b2bi-01-overview/) não cresça para sempre. Se você já se perguntou como o histórico de rastreamento de documentos continua consultável por meses sem o database cair, esse service — e os números de archive/purge/index naquele dashboard de Database Usage — é a resposta.

![Tela de configuração do BackupService no console de administração do Sterling B2B Integrator, mostrando tamanho do thread pool, business processes por bloco de backup, compressão, tamanho máximo de arquivo de backup e um horário de 2h da manhã](backup-service-config.webp "BackupService — o motivo pelo qual seu histórico de Business Process não cresce para sempre")

## Cenários: adapters no mundo real

Definições só te levam até certo ponto. Aqui está como a escolha de adapter realmente se desenrola em algumas situações reais:

**Cenário 1 — Um novo parceiro quer te enviar arquivos planos, sem requisitos especiais.** Padrão: SFTP. Configure um SFTP Server Adapter (ou reaproveite um existente — a maioria dos ambientes roda um server adapter compartilhado entre muitos parceiros, distinguidos por mailbox e credenciais em vez de um adapter para cada um), emita uma chave ou senha para o parceiro, e roteie os arquivos de entrada dele para uma mailbox dedicada. Esse é o caminho de onboarding de parceiro mais rápido de toda a plataforma, geralmente resolvido no mesmo dia.

**Cenário 2 — Um parceiro varejista exige AS2 com recibos MDN no acordo de parceria comercial.** Sem escolha aqui — configure um adapter AS2, troque certificados com o parceiro (os dele e os seus, nas duas direções), e garanta que as configurações de MDN (síncrono vs. assíncrono, assinado vs. não assinado) batam exatamente com o que está no acordo. Reserve tempo de verdade para isso; certificados incompatíveis são o motivo mais comum de um onboarding de AS2 estourar a estimativa.

**Cenário 3 — Um banco precisa de entrega garantida de um arquivo de liquidação noturno de múltiplos gigabytes, e uma transferência falha não pode recomeçar do zero.** Esse é exatamente o motivo de existir do Connect:Direct. Configure o adapter Connect:Direct com checkpoint restart habilitado, e uma transferência que cai em 2GB de um arquivo de 5GB retoma a partir de 2GB em vez de recomeçar — o que importa muito quando o arquivo precisa chegar antes que a janela de batch feche.

**Cenário 4 — Parceiros ficam perguntando "meu arquivo chegou?", e você está cansado de checar manualmente.** Isso não é um adapter novo — é conectar o Alert Service aos Business Processes que importam, para que um estado de falha dispare uma notificação em vez de ficar parado silenciosamente até que alguém vá procurar. Combine isso com o rastreamento de documentos (da [Parte 1](/posts/sterling-b2bi-01-overview/)) e a maioria das perguntas de "chegou?" é respondida antes mesmo de alguém precisar perguntar.

## Por que a distinção realmente importa

Aqui está a parte fácil de deixar passar até que ela te custe tempo: adapters e services falham de formas diferentes, e são diagnosticados em lugares diferentes.

Uma falha de adapter é quase sempre sobre o mundo externo — o servidor de um parceiro está fora do ar, um certificado expirou, uma regra de firewall mudou, um caminho de rede foi bloqueado. Você resolve checando conectividade, credenciais e o lado do parceiro no handshake. O Business Process em si geralmente é inocente; ele só está esperando por uma porta que não abre.

Uma falha de service é quase sempre sobre o dado. Um map engasgou em um campo inesperado. Uma regra de validação rejeitou algo que antes passava. Uma condição ramificou para um lado que ninguém esperava. Você resolve olhando para o documento real que está passando pelo processo, não para configurações de conectividade.

Confunda os dois e você acaba fazendo exatamente o que eu fiz naquele primeiro projeto: checando configurações de rede para um problema de dado, ou destrinchando um map para um problema que na verdade era o timeout do servidor de um parceiro. A pergunta de diagnóstico mais rápida que conheço para incidentes no Sterling é simplesmente: "isso falhou tentando alcançar algo fora do sistema, ou trabalhando em um dado que já estava dentro dele?" Só essa pergunta te encaminha para a metade certa do Business Process quase sempre.

## Onde isso se encaixa no quadro geral

Adapters ficam nas duas bordas do fluxo da [Parte 1](/posts/sterling-b2bi-01-overview/) — recebendo um arquivo de um Perimeter Server na entrada, ou entregando um arquivo a um parceiro na saída. Services ficam no meio, fazendo tudo o que acontece com um arquivo depois que ele já está dentro dos muros: mapear, validar, rotear, ocasionalmente esperar por um humano. Um Business Process é, na prática, apenas uma sequência de chamadas para os dois, com lógica de ramificação costurando tudo junto.

{{< mermaid >}}
flowchart LR
    subgraph Outside["Fora do Sistema"]
        Partner["Parceiro Comercial"]
    end

    subgraph BP["Business Process"]
        direction TB
        A1["Adapter de Entrada<br/>(SFTP / AS2 / HTTP)"]
        S1["Service<br/>Validar"]
        S2["Service<br/>Mapear"]
        S3["Service de Interação Humana<br/>(etapa de aprovação opcional)"]
        A2["Adapter de Saída<br/>(SFTP / AS2 / Connect:Direct)"]
        A1 --> S1 --> S2 --> S3 --> A2
    end

    Partner -->|arquivo de entrada| A1
    A2 -->|arquivo de saída| Partner

    classDef adapter fill:#0f62fe,color:#fff,stroke:#0f62fe
    classDef service fill:#393939,color:#fff,stroke:#393939
    class A1,A2 adapter
    class S1,S2,S3 service
{{< /mermaid >}}

Azul é "sai do sistema." Cinza é "fica por dentro." Quando algo quebra, essa cor é a primeira coisa que eu checo.

## Fontes e leituras complementares

- [Sterling B2B Integrator — Services and Adapters](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=integrator-services-adapters)
- [Sterling B2B Integrator — Services and Adapters (A–L)](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=adapters-sterling-b2b-integrator-services-l)
- [Sterling B2B Integrator — Services and Adapters (M–Z)](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=adapters-sterling-b2b-integrator-services-m-z)
- [Business Processes](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=integrator-business-processes)
- [Visão geral do Command Line Adapter 2 (CLA2)](https://www.ibm.com/docs/integrating/integrator/cla2_overview.html)
- [File transfer capabilities and integration with IBM Sterling B2B Integrator](https://www.ibm.com/support/pages/file-transfer-capabilities-and-integration-ibm-sterling-b2b-integrator)

Como na Parte 1, o enquadramento, as recomendações e as histórias de guerra são minhas — as definições são da IBM, e as capturas de tela são do meu próprio ambiente.

## O que vem a seguir

A seguir: [**Business Processes e BPML**](/posts/sterling-b2bi-03-business-processes-bpml/) — o motor de workflow de fato que amarra cada chamada de adapter e service, e por que o Graphical Process Modeler visual e o BPML bruto por baixo dele valem a pena serem entendidos como duas visões da mesma coisa, não duas ferramentas separadas.
