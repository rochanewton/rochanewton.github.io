---
title: "Perimeter Servers no IBM Sterling B2B Integrator: Por Que a Caixa na DMZ Liga para Casa, e Não o Contrário"
date: 2026-09-12
description: "O que um Perimeter Server realmente é, a mecânica do reverseConnect que permite que a caixa na DMZ disque para dentro em vez de abrir um buraco na sua rede principal, perimeter servers embutidos vs. remotos, como isso difere do Sterling Secure Proxy, e os cenários reais de troubleshooting que aparecem ao operar um."
tags:
  - ibm-sterling
  - b2bi
  - mft
  - middleware
  - architecture
  - perimeter-server
  - dmz
  - network-security
categories:
  - IBM Sterling
series:
  - sterling-b2bi-architecture
series_order: 6
showAuthor: true
image: cover.png
---

## A conexão roda ao contrário do que você imaginaria

A primeira suposição da maioria das pessoas sobre uma caixa na DMZ é que a sua rede interna e confiável é quem alcança ela — o lado seguro inicia, o lado exposto escuta. Um Perimeter Server faz o oposto. O motor central do B2Bi, seguro dentro da sua rede, nunca abre uma conexão para fora, em direção à DMZ. Em vez disso, o Perimeter Server — a caixa que de fato está de frente para os parceiros e a internet — disca *de volta* para o motor central e mantém essa conexão aberta. O tráfego do parceiro chega primeiro na caixa da DMZ, e só então é encaminhado para dentro por um canal que o próprio lado da DMZ estabeleceu.

Mencionei esse componente na [Parte 1](/posts/sterling-b2bi-01-overview/) e prometi voltar ao assunto, porque a maioria do material introdutório o ignora completamente — o que é uma pena, já que é o motivo real pelo qual um diagrama de implantação do Sterling tem caixas fora do firewall, para começo de conversa, e é o detalhe que faz toda a história da DMZ fazer sentido depois que você entende em que direção o fio realmente corre. Lado a lado, a suposição e a realidade se parecem assim:

{{< mermaid >}}
flowchart TB
    subgraph Assumed["O que você imaginaria"]
        direction LR
        C1["Core Engine\n(zona confiável)"]
        FW1{{"Firewall Interno"}}
        PS1["Perimeter Server\n(DMZ)"]
        C1 -- "Core abre uma nova\nconexão para dentro da DMZ" --> FW1
        FW1 -- "exige uma regra de\nliberação de entrada vinda da DMZ" --> PS1
    end

    subgraph Actual["O que de fato acontece"]
        direction LR
        PS2["Perimeter Server\n(DMZ)"]
        FW2{{"Firewall Interno"}}
        C2["Core Engine\n(zona confiável)"]
        PS2 -- "PS disca para fora\n(reverseConnect)" --> FW2
        FW2 -- "regra somente de saída —\nnenhum buraco de entrada necessário" --> C2
    end

    style FW1 fill:#4a1a1a,stroke:#c0392b
    style FW2 fill:#12331a,stroke:#27ae60
{{< /mermaid >}}

A metade de cima é a regra que o seu firewall interno precisaria se o motor central alcançasse a DMZ — uma regra de liberação de entrada que deixa um host da DMZ iniciar tráfego para dentro da zona confiável, que é precisamente o tipo de buraco que uma DMZ existe para evitar. A metade de baixo é o que um Perimeter Server realmente exige: uma regra somente de saída, e nada escutando por conexões vindas do lado da DMZ.

## O que é um Perimeter Server

Um Perimeter Server é um processo leve e independente que fica na DMZ e termina o handshake de protocolo com o mundo externo — SFTP, FTP/FTPS, HTTP/S, AS2, Connect:Direct, OdetteFTP, SOAP — em nome do B2Bi. Ele não roda Business Processes, não toca em mailboxes, e não guarda configuração de trading partner. O trabalho inteiro dele é gerenciamento de socket: aceitar a conexão, gerenciar a sessão e a thread, e repassar o tráfego para o motor de verdade através de um canal seguro, para que o motor em si — com o database, o histórico de rastreamento de documentos, o arquivo de cada parceiro — nunca precise ficar perto de uma interface voltada ao público ([Documentação IBM](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=servers-perimeter-in-sterling-b2b-integrator)).

Essa é a proposta de valor inteira em uma frase: ela permite expor endpoints voltados a parceiros sem nunca colocar o motor central ao alcance da internet pública. Além da fronteira de segurança, a IBM também documenta um ângulo de performance — o gerenciamento de sessão e thread na caixa da DMZ reduz a carga que o motor central precisa carregar diretamente, o que importa mais do que parece quando você está rodando dezenas de parceiros com perfis de tráfego muito diferentes através do mesmo node.

## Embutido vs. remoto: duas implantações bem diferentes escondidas atrás de um único nome

"Perimeter Server" se refere a duas configurações distintas, e misturá-las é uma fonte comum de confusão:

**Perimeter Server embutido (local).** Empacotado diretamente dentro do próprio B2Bi — sem instalação separada, sem posicionamento na DMZ. Ele existe para que adapters que esperam uma atribuição de perimeter server tenham algo para apontar em um laboratório, um ambiente de desenvolvimento, ou qualquer implantação onde você genuinamente não precisa de uma fronteira de DMZ. Ele não fornece nenhuma das separações de segurança reais que um remoto fornece.

**Perimeter Server remoto (instalado).** Uma instalação separada, implantada em seu próprio host, física ou logicamente dentro da DMZ, independente da própria instalação do B2Bi. Esse é o que faz o trabalho de verdade em qualquer topologia de produção — o que o tráfego de parceiro de fato atinge.

Múltiplos Perimeter Servers remotos podem rodar contra um único node de B2Bi ao mesmo tempo, o que é o que permite segmentar o tráfego deliberadamente: uma caixa de DMZ lidando com SFTP de alto volume dos seus maiores trading partners, uma separada para um parceiro cujo time de segurança insiste em infraestrutura fisicamente isolada, sem tocar na configuração do motor central para adicionar nenhum dos dois. Essa atribuição por adapter é exatamente o campo que você teria passado batido na captura de tela do SFTP Client Adapter da [Parte 2](/posts/sterling-b2bi-02-adapters-vs-services/) — "nome do sistema, ambiente, uma atribuição de perimeter server e limites de thread" estava fazendo bastante trabalho silencioso naquela única linha.

## A mecânica do reverseConnect

Aqui está a parte que surpreende quem já trabalhou com reverse proxies antes e espera a direção usual de confiança: o Perimeter Server remoto é quem inicia a conexão com o motor central, não o contrário. A própria documentação de suporte da IBM para o arquivo `remote_perimeter.properties` que configura isso lista exatamente os parâmetros que você esperaria para esse modelo — `reverseConnect`, `remoteAddress`, `remotePort`, e uma `port` local ([Suporte IBM](https://www.ibm.com/support/pages/need-more-information-about-remoteperimeterproperties-parameters-remote-perimeter-server-sterling-b2b-integrator)) — e documentação da comunidade sobre o mesmo mecanismo descreve o Perimeter Server remoto estabelecendo uma conexão persistente de volta com o sistema central, comumente na porta 9999 ([Pronteff](https://pronteff.com/ibm-sterling-perimeter-server/)).

Por que construir dessa forma, em vez de deixar o motor central alcançar a DMZ? Porque isso significa que o seu firewall interno nunca precisa de uma regra de entrada que deixe um host da DMZ iniciar tráfego para dentro das portas de escuta da sua rede confiável — a caixa da DMZ só *origina* a única conexão de que precisa, e tudo depois disso trafega dentro dela. Essa única decisão de design é o motivo pelo qual a topologia funciona sem abrir exatamente o tipo de buraco que uma DMZ existe para evitar.

{{< mermaid >}}
sequenceDiagram
    participant Partner as Parceiro
    participant PS as Perimeter Server (DMZ)
    participant Core as B2Bi Core Engine (zona confiável)

    Note over PS,Core: Conexão persistente estabelecida primeiro —<br/>PS disca para o Core, não o contrário
    PS->>Core: Conexão de saída (reverseConnect, tipicamente porta 9999)
    Core-->>PS: Conexão aceita, mantida aberta

    Partner->>PS: Conecta (SFTP / AS2 / HTTP)
    PS->>PS: Termina o handshake de protocolo
    PS->>Core: Encaminha a sessão pelo canal já existente
    Core->>Core: Repassa para Adapter → Business Process
    Note over Partner,Core: O firewall interno nunca precisa aceitar<br/>uma conexão de entrada iniciada pela DMZ
{{< /mermaid >}}

Essa sequência esconde um detalhe importante: na camada de rede, na verdade existem duas conexões separadas fazendo dois trabalhos separados, não uma. Desenhado como topologia em vez de linha do tempo, fica assim:

{{< mermaid >}}
flowchart LR
    subgraph Internet["Internet"]
        Partner["Parceiro Comercial"]
    end

    subgraph DMZ["DMZ"]
        PS["Perimeter Server"]
    end

    subgraph Trusted["Zona Confiável"]
        Core["B2Bi Core Engine"]
    end

    PS == "1 — saída, iniciada pelo PS\ncanal de controle persistente\n(reverseConnect, porta 9999)" ==> Core
    Partner -- "2 — entrada só até o PS\n(SFTP / AS2 / HTTP)" --> PS
    PS -. "3 — sessão do parceiro tunelada\npelo canal aberto no passo 1" .-> Core
{{< /mermaid >}}

O passo 1 precisa acontecer primeiro e fica de pé continuamente — é infraestrutura, não tráfego por sessão. O passo 2 é a única conexão que um parceiro faz, e ela termina no Perimeter Server; ela nunca vira uma segunda conexão independente alcançando a zona confiável. O passo 3 não é uma conexão nova — é a sessão do parceiro trafegando dentro do canal que já existe desde o passo 1. Do ponto de vista do firewall interno, exatamente uma conexão cruza a fronteira, e é a caixa da DMZ que a abriu.

*(Placeholder de captura de tela: a tela "Add Perimeter Server" no console de administração — Deployment > Perimeter Servers > Add — mostrando o nome, a descrição, e o seletor de tipo local/embutido vs. remoto. Vale uma segunda captura de tela da visão de detalhe de um Perimeter Server remoto configurado, se os valores de `remote_perimeter.properties` estiverem visíveis ali.)*

## Perimeter Server vs. Sterling Secure Proxy — não é o mesmo produto

Esta é a outra fonte recorrente de confusão, e vale a pena ser preciso sobre ela: o **Sterling Secure Proxy (SSP)** é um produto IBM separado, um gateway de segurança e reverse-proxy completo para DMZ, com suas próprias capacidades de quebra de sessão, filtragem de protocolo e mapeamento de credenciais, muito além do que um Perimeter Server faz. Os dois são confundidos constantemente porque implantações de SSP também envolvem um componente "Parameter Server" instalado na frente dele, e porque os dois produtos vivem na mesma parte voltada à DMZ de um diagrama de arquitetura Sterling ([Suporte IBM](https://www.ibm.com/support/pages/what-parameter-server-needs-be-installed-ibm-sterling-secure-proxy)). Se uma vaga de emprego ou um colega diz "perimeter server" e quer dizer comportamento de proxy com quebra de sessão, inspeção completa de protocolo, ou mapeamento de credenciais entre uma identidade externa e interna, eles quase certamente estão descrevendo o SSP, não o Perimeter Server simples que este post cobre. O Perimeter Server simples é um componente muito mais estreito e muito mais simples — ele move bytes com segurança através da fronteira da DMZ; não inspeciona, transforma ou autentica nada por conta própria.

## Cenários operacionais

**"Parceiros conseguem se conectar mas os arquivos nunca aparecem."** Cheque primeiro a qual Perimeter Server o adapter que está falhando está de fato atribuído — com múltiplos Perimeter Servers remotos em um node, um parceiro caindo no errado (ou em um que está fora do ar) parece idêntico a um problema de rede do lado do parceiro, mas é uma incompatibilidade de configuração do seu lado.

**`CloseCode.NO_AVAILABLE_PORT` em `perimeter.log`.** Isso aparece como uma falha de bind — `java.net.BindException: Cannot assign requested address` — quando o Perimeter Server não consegue alocar uma porta para uma sessão nova ([Suporte IBM](https://www.ibm.com/support/pages/perimeter-server-connection-sterling-b2b-integrator-remote-perimeter-server-dmz-fails-closecodenoavailableport)). Na prática, isso quase sempre é exaustão de portas sob carga ou uma regra de firewall/SO local limitando a faixa de portas efêmeras no host da DMZ — cheque a faixa de portas do próprio host da DMZ e qualquer regra de firewall a nível de host antes de assumir que é um problema do lado do B2Bi. Vale lembrar que isso é genuinamente separado do mundo de mailbox e Business Process — é uma falha de camada de rede, mais baixa.

**Dois arquivos de log, duas classes de falha diferentes.** Problemas de conexão e sessão do perimeter ficam em `perimeter.log`, no próprio host do Perimeter Server. Problemas do lado do motor central na passagem de bastão — o Perimeter Services Manager registrando ou perdendo um Perimeter Server conectado — aparecem nos próprios logs do motor central. Perseguir um problema de conectividade no log errado é uma forma rápida de perder vinte minutos à toa; se um adapter de protocolo voltado a parceiro está falhando em receber conexões completamente, o `perimeter.log` na caixa da DMZ é a primeira parada, não o log de aplicação do motor central.

**Um Perimeter Server "some" depois de um restart.** Como o lado da DMZ é dono da conexão, a ordem de restart importa: se o motor central volta antes que o Perimeter Server remoto reconecte, adapters atribuídos a esse Perimeter Server vão mostrá-lo como indisponível até que o processo do lado da DMZ restabeleça a conexão de saída. Isso é comportamento esperado, não corrupção — só significa que os runbooks de restart para um ambiente B2Bi com Perimeter Servers remotos precisam considerar os dois lados voltando, não só o motor central.

## Onde isso se encaixa na série

O Perimeter Server é a peça do diagrama de topologia da [Parte 1](/posts/sterling-b2bi-01-overview/) que recebeu uma menção de um parágrafo e nada mais até agora. É a primeira coisa que a conexão de um parceiro toca — antes do [Adapter](/posts/sterling-b2bi-02-adapters-vs-services/), antes do Business Process, antes de o arquivo sequer chegar a uma [Mailbox](/posts/sterling-b2bi-05-mailboxes-file-gateway/). Toda peça daquele diagrama original agora genuinamente tem seu próprio post por trás dela.

## Fontes e leituras complementares

- [Perimeter servers in Sterling B2B Integrator — Documentação IBM](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=servers-perimeter-in-sterling-b2b-integrator)
- [Perimeter Server overview — Documentação IBM (6.1.2)](https://www.ibm.com/docs/en/b2b-integrator/6.1.2?topic=servers-perimeter-server-overview)
- [Need more information about remote_perimeter.properties parameters — Suporte IBM](https://www.ibm.com/support/pages/need-more-information-about-remoteperimeterproperties-parameters-remote-perimeter-server-sterling-b2b-integrator)
- [Perimeter Server connection fails with CloseCode.NO_AVAILABLE_PORT — Suporte IBM](https://www.ibm.com/support/pages/perimeter-server-connection-sterling-b2b-integrator-remote-perimeter-server-dmz-fails-closecodenoavailableport)
- [What Parameter Server needs to be installed with IBM Sterling Secure Proxy? — Suporte IBM](https://www.ibm.com/support/pages/what-parameter-server-needs-be-installed-ibm-sterling-secure-proxy)
- [What is IBM Sterling Perimeter Server? — Pronteff](https://pronteff.com/ibm-sterling-perimeter-server/)

Como no resto desta série: as definições e os parâmetros documentados são da IBM (e do Suporte IBM), o enquadramento, o diagrama e os cenários operacionais são meus.

## O que vem a seguir

A seguir: **O Map Editor** — a camada de tradução sinalizada lá na [Parte 1](/posts/sterling-b2bi-01-overview/), e a origem de alguns dos bugs mais complicados que já persegui em produção.
