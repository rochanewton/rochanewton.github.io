---
title: "SFTP, FTP, FTPS: O Protocolo Por Trás dos Adapters"
date: 2026-09-10
description: "FTP, FTPS e SFTP explicados protocolo por protocolo — como cada um realmente funciona, portas, segurança, quando usar e quando evitar — depois um foco profundo em SFTP/SSH: pares de chaves, formatos de chave, cifras e MACs, já que é isso que carrega a maior parte do tráfego de parceiros no B2Bi."
tags:
  - sftp
  - ftp
  - ftps
  - ssh
  - networking
  - security
  - ibm-sterling
  - mft
  - middleware
categories:
  - IBM Sterling
series:
  - sterling-b2bi-architecture
series_order: 4
showAuthor: true
image: cover.png
aliases:
  - /posts/sftp-protocol-fundamentals/
---

## Três protocolos, um trabalho, mecânicas internas muito diferentes

FTP, FTPS e SFTP todos afirmam fazer a mesma coisa — mover um arquivo de um lugar para outro — e os parceiros usam os nomes quase como sinônimos, o que é exatamente o problema. São três protocolos genuinamente diferentes, com modelos de porta diferentes, propriedades de segurança diferentes e modos de falha diferentes, e o [SFTP Server Adapter e o SFTP Client Adapter]({{< ref "/posts/sterling-b2bi-02-adapters-vs-services/" >}}) que você configura no Sterling só fazem sentido depois que você sabe qual deles está realmente rodando. Este post passa por cada um nos seus próprios termos, e depois dedica a segunda metade especificamente ao SFTP, já que é isso que carrega a esmagadora maioria do tráfego de parceiros no B2Bi.

## O que é FTP

**File Transfer Protocol**, definido lá atrás na [RFC 959](https://www.rfc-editor.org/rfc/rfc959) (1985), é o mais antigo dos três e aquele ao qual todos os outros estão reagindo. Sua característica definidora — e também sua fraqueza — é que ele usa **duas conexões TCP separadas**: uma conexão de controle que fica aberta durante a sessão e carrega comandos e respostas, e uma conexão de dados completamente separada que é aberta do zero para cada transferência de arquivo ou listagem de diretório.

{{< mermaid >}}
sequenceDiagram
    participant Client as Cliente
    participant Server as Servidor

    Client->>Server: Conexão TCP, porta 21 (controle)
    Server->>Client: Banner de boas-vindas
    Client->>Server: USER / PASS (texto plano)
    Server->>Client: Login OK
    Note over Client,Server: Conexão de controle permanece aberta

    rect rgb(40,40,40)
    Note over Client,Server: Modo ativo
    Client->>Server: PORT (IP:porta do cliente para conexão de retorno)
    Server->>Client: Conecta a partir da porta 20 até a porta do cliente
    end

    rect rgb(40,40,40)
    Note over Client,Server: Modo passivo
    Client->>Server: PASV
    Server->>Client: Aqui está uma porta alta aleatória para se conectar
    Client->>Server: Conecta a essa porta
    end

    Note over Client,Server: Os dados do arquivo trafegam por essa SEGUNDA<br/>conexão separada — sem criptografia
{{< /mermaid >}}

- **Portas:** 21 para controle, mais a porta 20 (modo ativo, o servidor conecta de volta ao cliente) ou uma porta alta aleatória negociada via `PASV` (modo passivo, o cliente conecta para fora, até o servidor). O modo ativo espera que o servidor abra uma conexão de entrada até o cliente — o que quase nunca sobrevive a um NAT ou firewall hoje em dia, então o modo passivo virou o padrão prático.
- **Segurança:** nenhuma, por padrão. Usuário, senha, comandos e o próprio conteúdo do arquivo atravessam a rede em texto plano. Qualquer um posicionado no caminho de rede consegue ler credenciais e dados com uma captura de pacotes e esforço zero.
- **Por que ainda existe:** sistemas legados, transferências internas em redes já consideradas confiáveis, e algumas integrações de parceiro genuinamente antigas, anteriores a qualquer um que trabalhe nelas hoje.
- **Por que não usar para troca com parceiros:** credenciais em texto plano e conteúdo de arquivo em texto plano pela internet aberta não é uma posição defensável em 2026, ponto final. Se um parceiro pedir FTP puro hoje, isso é uma conversa, não uma tarefa de configuração.

## O que é FTPS

**FTP sobre TLS/SSL** (também escrito FTPES na variante explícita) é a tentativa do FTP de corrigir o problema do texto plano sem redesenhar o protocolo — ele envolve o *mesmo* modelo de duas conexões do FTP em TLS. Isso traz criptografia, mas herda o problema arquitetural fundamental do FTP: duas conexões ainda significam duas coisas para proteger e duas coisas que podem falhar de forma independente.

{{< mermaid >}}
sequenceDiagram
    participant Client as Cliente
    participant Server as Servidor

    rect rgb(40,40,40)
    Note over Client,Server: FTPS Explícito (FTPES) — porta 21
    Client->>Server: Conexão TCP, porta 21
    Client->>Server: AUTH TLS
    Server->>Client: Handshake TLS começa
    Note over Client,Server: Conexão de controle agora criptografada
    Client->>Server: USER / PASS (agora criptografado)
    Client->>Server: PBSZ / PROT P (solicita canal de dados criptografado)
    Client->>Server: PASV → conexão de dados, também envolvida em TLS
    end

    rect rgb(40,40,40)
    Note over Client,Server: FTPS Implícito — porta 990
    Client->>Server: Conexão TCP, porta 990
    Note over Client,Server: O handshake TLS acontece imediatamente,<br/>antes de qualquer comando FTP ser enviado
    end
{{< /mermaid >}}

- **Portas:** o FTPS explícito negocia TLS na porta padrão 21 depois de conectar (`AUTH TLS`); o FTPS implícito espera TLS imediatamente em uma porta dedicada, convencionalmente 990. Os dois ainda precisam de uma segunda conexão de dados, o que — por estar agora também envolvida em TLS — torna as faixas de porta do modo passivo através de um firewall uma dor de cabeça ainda maior do que no FTP puro, já que o firewall precisa permitir uma sessão TLS que não consegue inspecionar.
- **Segurança:** genuinamente melhor que o FTP — credenciais e dados são criptografados em trânsito, assumindo que o TLS esteja configurado corretamente (validação de certificado, sem versões antigas de TLS deixadas habilitadas). Ainda autentica com usuário e senha por padrão, então você está confiando só na criptografia de transporte, a menos que autenticação de cliente baseada em certificado seja adicionada por cima.
- **Quando usar:** quando a infraestrutura de um parceiro é padronizada especificamente em FTPS (comum em algumas indústrias onde é um padrão de compliance) e ele não vai migrar para SFTP. É uma escolha legítima e segura o suficiente quando configurada corretamente.
- **Por que ainda prefiro o SFTP:** o modelo de duas conexões não desaparece só porque está criptografado — você ainda está lidando com faixas de porta do modo passivo e interação com NAT/firewall, só que agora com TLS no meio também. O SFTP evita essa categoria inteira de problema.

## O que é SFTP / SSH / SCP

Este é o que realmente mais importa para o B2Bi, então ele leva o resto deste post. Primeiro, o nome precisa ser desembaraçado, porque "SFTP é FTP sobre SSH" é a coisa mais comum que as pessoas erram sobre ele — e não é verdade. **SFTP — o SSH File Transfer Protocol — é um subsistema do próprio [SSH](https://www.openssh.org/)**, não FTP envolvido em nada. Ele não compartilha nada com o conjunto de comandos ou o modelo de conexão do FTP. Uma conexão TCP, um canal criptografado negociado, operações de arquivo definidas como parte da família de protocolos SSH desde a base.

{{< mermaid >}}
sequenceDiagram
    participant Client as Cliente
    participant Server as Servidor

    Client->>Server: Conexão TCP, porta 22
    Client->>Server: Troca de versão do protocolo SSH
    Note over Client,Server: Negociação de algoritmos:<br/>método de troca de chaves, cifras, MACs
    Client->>Server: Troca de chaves (ex: curve25519-sha256)
    Server->>Client: Host key apresentada
    Note over Client,Server: Cliente verifica a host key contra known_hosts —<br/>falha de forma fechada em caso de divergência
    Client->>Server: Autentica (chave pública ou senha)
    Server->>Client: Resultado da autenticação
    Note over Client,Server: Canal único criptografado agora estabelecido
    Client->>Server: Solicita o subsistema "sftp"
    Note over Client,Server: Todas as operações de arquivo (abrir, ler, escrever,<br/>stat, renomear, apagar) rodam como pacotes<br/>binários dentro deste único canal
{{< /mermaid >}}

- **Portas:** uma. Porta 22, igual a qualquer conexão SSH. Nenhuma segunda conexão de dados, nenhuma faixa de modo passivo, nada extra para abrir em um firewall.
- **Segurança:** forte por design — todo pacote, de controle e de dados igualmente, trafega pelo mesmo canal criptografado e com verificação de integridade estabelecido durante o handshake SSH. A autenticação suporta tanto senha quanto autenticação por chave pública (mais sobre isso adiante), e o servidor prova a própria identidade via sua host key, que o cliente deveria verificar contra uma entrada confiável em `known_hosts` antes de confiar em qualquer coisa que vem depois.
- **Quando usar:** essa é a escolha padrão para novas conexões de parceiro, a menos que os requisitos de segurança ou compliance do próprio parceiro determinem especificamente outra coisa. É o que eu uso primeiro, e é a esmagadora maioria do que o tráfego de parceiros do B2Bi roda na prática.
- **Por que não FTP ou FTPS no lugar:** nenhuma opção em texto plano para configurar errado por acidente (FTP), e nenhuma segunda conexão brigando com o seu firewall (FTPS) — o modelo de canal único do SFTP é simplesmente estruturalmente mais simples de proteger corretamente.

**SCP** merece uma menção aqui porque é o *outro* subsistema de transferência de arquivos do SSH e é confundido com o SFTP o tempo todo. [`scp(1)`](https://man.openbsd.org/scp.1) é mais antigo e muito mais simples que o SFTP — efetivamente um `cp` com transporte SSH, sem listagem de diretório, sem suporte a retomada, sem rename atômico. O OpenSSH moderno vem silenciosamente reimplementando o cliente do SCP por cima dos internos do SFTP há anos, especificamente porque o design de protocolo do SFTP é melhor em quase todos os aspectos. Se você tiver escolha entre os dois hoje, escolha SFTP — é o protocolo ativamente mantido e mais capaz, e é o que os adapters de client e server do Sterling implementam.

Material de referência que vale a pena ter salvo em vez de confiar em explicações de segunda mão: [`ssh(1)`](https://man.openbsd.org/ssh.1) e [`sftp(1)`](https://man.openbsd.org/sftp.1), as páginas de manual canônicas do OpenBSD/OpenSSH.

### Comparação rápida

| | FTP | FTPS | SFTP |
|---|---|---|---|
| Conexões | 2 (controle + dados) | 2, envolvidas em TLS | 1 |
| Porta(s) | 21 + dinâmica/20 | 21 ou 990 + dinâmica | 22 |
| Criptografia | Nenhuma | TLS | Criptografia de transporte do SSH |
| Autenticação | Usuário/senha, texto plano | Usuário/senha (+ certificados de cliente opcionais) | Senha ou chave pública |
| Amigável a Firewall/NAT | Ruim | Ruim (canal de dados envolvido em TLS) | Bom — conexão única |
| Adapter no Sterling | FTP Adapter | FTP Adapter (com SSL habilitado) | SFTP Client/Server Adapter |

## Pares de chaves SSH

A autenticação por chave pública é a que você realmente quer para qualquer coisa automatizada ou voltada a parceiros — nenhuma credencial parada em um script ou job agendado, nenhuma discussão de rotação de senha com o time de segurança de um parceiro, e é em torno disso que a maioria das configurações de trading partner do SFTP Server Adapter no B2Bi é construída.

**O que é:** um par de chaves ligadas matematicamente, geradas em conjunto. A **chave privada** fica exatamente onde foi gerada e nunca é transmitida para lugar nenhum, por design — se ela sair dessa máquina, o par de chaves é considerado comprometido. A **chave pública** é a metade feita para ser compartilhada livremente; ela é colocada em um arquivo `authorized_keys` em um servidor OpenSSH comum, ou registrada como a chave pública conhecida do parceiro dentro da configuração de trading partner do Sterling. A autenticação funciona porque o cliente consegue provar posse da chave privada (assinando um desafio) sem nunca enviá-la para lugar nenhum — o servidor só precisa da metade pública para verificar essa assinatura.

[`ssh-keygen(1)`](https://man.openbsd.org/ssh-keygen.1) é a ferramenta que gera as duas metades.

**Tipos e tamanhos de chave:**

- **RSA** — o velho confiável, e ainda o que a maioria das stacks legadas de MFT e ferramentas mais antigas próximas de mainframe esperam. 2048 bits é o piso prático hoje (o OpenSSH moderno recusa qualquer coisa menor por padrão); 3072 ou 4096 bits é a escolha mais segura para qualquer coisa de vida longa. `ssh-keygen -t rsa -b 4096`.
- **ed25519** — o padrão moderno. Tamanho de chave fixo (sem parâmetro de tamanho para errar), mais rápido para gerar e verificar, e considerado pelo menos tão forte quanto RSA-3072/4096 com muito menos material de chave. `ssh-keygen -t ed25519`. É o que eu uso primeiro para qualquer par de chaves novo, a menos que a ferramenta de um parceiro genuinamente não consiga interpretá-lo — o que, com sistemas mais antigos, acontece mais do que se gostaria.
- **ECDSA** — suportado, ocasionalmente visto, raramente minha primeira escolha dadas as preocupações com curvas NIST que alguns times de segurança levantam; o ed25519 cobre o mesmo terreno com menos bagagem.
- **DSA** — descontinuado e desabilitado por padrão no OpenSSH atual por completo. Um parceiro insistindo nele é, na verdade, uma conversa sobre quão antigo é o sistema dele.

**Formatos de arquivo de chave — a parte que causa atrito de verdade durante a troca de chaves com parceiros:**

- O **formato de chave privada próprio do OpenSSH** (`-----BEGIN OPENSSH PRIVATE KEY-----`) é o padrão desde o OpenSSH 7.8, e é o que o `ssh-keygen` produz a menos que seja instruído de outra forma.
- **PEM / PKCS#1** é o formato de chave privada mais antigo, ainda o que muitas ferramentas fora do OpenSSH e bibliotecas mais antigas esperam. `ssh-keygen -m PEM` força esse formato quando o outro lado não consegue interpretar o mais novo.
- O **formato de chave pública SECSH**, definido na [RFC 4716](https://www.rfc-editor.org/rfc/rfc4716), é um formato de intercâmbio de chave *pública* que alguns servidores SFTP fora do OpenSSH e plataformas de MFT legadas esperam, em vez do formato de linha única estilo `authorized_keys` do OpenSSH. `ssh-keygen -e` exporta uma chave pública em formato OpenSSH para o formato RFC 4716; `-i` importa de volta.

Na prática: um parceiro te entrega uma chave pública no formato que o sistema dele produziu, ela não bate com o que o seu lado espera, e a correção é um ciclo de `ssh-keygen -e`/`-i`, não um par de chaves regerado do zero. Saber que esses três formatos existem transforma um onboarding de parceiro travado em uma correção de dois minutos.

## Cifras e MACs

**O que são:** durante a etapa de troca de chaves SSH no diagrama de handshake acima, cliente e servidor anunciam cada um uma lista ordenada de algoritmos suportados e concordam com o mais forte que os dois lados suportam — uma **cifra** para criptografar o fluxo de dados, e um **MAC (código de autenticação de mensagem)** para verificar que os pacotes não foram adulterados em trânsito. Essa negociação é exatamente o que os campos de preferência de cifra e MAC do SFTP Server Adapter (visíveis nas capturas de tela da [Parte 2]({{< ref "/posts/sterling-b2bi-02-adapters-vs-services/" >}})) estão configurando — não é algo específico do Sterling, é a própria negociação de algoritmos do SSH exposta através de um console de administração.

**Por que isso importa:** o SSH existe há tempo suficiente para acumular algoritmos que eram escolhas razoáveis há uma década e hoje são considerados fracos ou quebrados. Um servidor que ainda os oferece não está necessariamente comprometido, mas está carregando um risco evitável, e é rotineiramente o que scans de segurança sinalizam em um servidor de MFT.

**Escolhas boas e atuais** (o que o OpenSSH moderno usa por padrão e o que eu gostaria que uma conexão de parceiro realmente estivesse usando):

- Cifras: `chacha20-poly1305@openssh.com`, `aes256-gcm@openssh.com`, `aes128-gcm@openssh.com`
- MACs: as variantes `-etm` (encrypt-then-MAC) — `hmac-sha2-256-etm@openssh.com`, `hmac-sha2-512-etm@openssh.com` — preferidas sobre suas equivalentes não-ETM porque encrypt-then-MAC evita algumas armadilhas criptográficas às quais MAC-then-encrypt está exposto.

**Fracos ou descontinuados — não deveriam aparecer em uma configuração ativa:**

- Cifras: `3des-cbc` (lenta e criptograficamente cansada), `arcfour`/`arcfour128`/`arcfour256` (baseadas em RC4, quebradas), qualquer cifra em modo `-cbc` puro onde uma alternativa GCM ou ChaCha20 esteja disponível.
- MACs: `hmac-md5` e `hmac-sha1` (MD5 e SHA-1 são ambos considerados fracos demais para esse uso), e MACs não-ETM em geral, se a variante ETM for suportada pelos dois lados.

A lista atual e autoritativa do que o OpenSSH suporta — e como definir uma ordem de preferência explícita — está em [`ssh_config(5)`](https://man.openbsd.org/ssh_config.5) e [`sshd_config(5)`](https://man.openbsd.org/sshd_config.5). A regra prática que sigo: usar por padrão as recomendações atuais do OpenSSH, e só adicionar uma cifra ou MAC mais antigo à lista permitida para aquela conexão de parceiro específica que genuinamente precisa dele — nunca globalmente, e nunca permanentemente sem um chamado para revisitar e removê-lo depois.

## Operações que costumam confundir

**Leituras parciais de arquivo.** O job automatizado de um parceiro começa a fazer polling em uma mailbox no instante em que um arquivo começa a ser enviado, e pega um arquivo pela metade. A correção é operacional, não a nível de protocolo: fazer upload para um nome de arquivo temporário, depois renomear atomicamente assim que a transferência terminar. O SFTP suporta rename atômico como operação nativa; use-a.

**"Funciona no FileZilla mas não a partir do nosso sistema."** Quase sempre uma divergência de método de autenticação (o cliente gráfico lembrou uma senha salva; o job automatizado está tentando autenticação por chave com a chave errada) ou uma host key que mudou e o cliente automatizado está falhando de forma fechada por uma divergência em `known_hosts`, enquanto o cliente gráfico simplesmente clicou para passar por uma caixa de diálogo de aviso. Verifique os dois antes de assumir que é um problema de rede.

**Limites de thread e conexão.** A configuração do SFTP Client Adapter da Parte 2 tem limites explícitos de thread por um motivo — um parceiro rodando uma rajada de transferências paralelas contra um adapter compartilhado pode esgotar os slots de conexão de todo outro parceiro que o compartilha. Vale a pena saber os limites do seu adapter antes de um parceiro perguntar "podemos enviar 200 arquivos de uma vez?"

**Mudanças de host key sem aviso.** Parceiros reconstroem servidores e rotacionam chaves sem te avisar com antecedência. Uma política estrita de `known_hosts` é o padrão certo, mas significa que toda rotação não anunciada vira uma conexão falha até que alguém verifique e aceite manualmente a nova chave — vale a pena ter um caminho de verificação rápido e documentado, em vez de recorrer a "só desabilita a checagem estrita", o que anula o propósito inteiro. Isso acontece com frequência suficiente, e tem nuance suficiente, para merecer seu próprio post: [SSH known_hosts: Como a Verificação de Host Key Realmente Funciona]({{< ref "/posts/sterling-b2bi-08-ssh-known-hosts-host-key-verification/" >}}).

## Onde isso se encaixa no Sterling

Tudo acima é a nível de protocolo e se aplica a qualquer servidor ou cliente FTP, FTPS ou SFTP — IBM ou não. O que o Sterling adiciona é uma UI de console de administração exatamente sobre esses conceitos: o campo de host identity key do SFTP Server Adapter *é* o par de chaves de host SSH do servidor; suas listas de preferência de cifra e MAC *são* as listas de negociação de `ssh_config`/`sshd_config` descritas acima; a chave pública registrada de um trading partner *é* uma entrada de `authorized_keys`, só que armazenada na configuração de trading partner do Sterling em vez de um arquivo plano; e o FTP Adapter comum com SSL habilitado é exatamente o handshake de FTPS diagramado acima. Nada disso é o Sterling reinventando esses protocolos — é o Sterling expondo a superfície de configuração nativa deles através de um console, e é por isso que entender os protocolos por baixo faz as telas de adapter da [Parte 2]({{< ref "/posts/sterling-b2bi-02-adapters-vs-services/" >}}) fazerem muito mais sentido numa segunda olhada.

## Fontes e leituras complementares

- [RFC 959 — File Transfer Protocol](https://www.rfc-editor.org/rfc/rfc959)
- [OpenSSH](https://www.openssh.org/)
- [`ssh(1)`](https://man.openbsd.org/ssh.1)
- [`sftp(1)`](https://man.openbsd.org/sftp.1)
- [`scp(1)`](https://man.openbsd.org/scp.1)
- [`ssh-keygen(1)`](https://man.openbsd.org/ssh-keygen.1)
- [`ssh_config(5)`](https://man.openbsd.org/ssh_config.5)
- [`sshd_config(5)`](https://man.openbsd.org/sshd_config.5)
- [RFC 4716 — The Secure Shell (SSH) Public Key File Format](https://www.rfc-editor.org/rfc/rfc4716)
- [Documentação IBM: Services & Adapters](https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=integrator-services-adapters)

Como no resto desta série: as definições de protocolo, as RFCs e o conteúdo das páginas de manual são as fontes autoritativas linkadas acima, o enquadramento, as comparações e os conselhos operacionais são meus.

## O que vem a seguir

A seguir: **Mailboxes e File Gateway** — desembaraçando a confusão sinalizada lá na [Parte 1]({{< ref "/posts/sterling-b2bi-01-overview/" >}}), com um olhar mais de perto sobre como o roteamento do File Gateway realmente se apoia na estrutura de mailbox e adapters por baixo dele. Leia aqui: [Parte 5]({{< ref "/posts/sterling-b2bi-05-mailboxes-file-gateway/" >}}).
