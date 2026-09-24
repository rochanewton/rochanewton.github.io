---
title: "Tornando-se um Claude Architect: Quiz de Prática com 100 Perguntas — Parte 7"
date: 2026-09-24
description: "Um quiz de prática não oficial, com apoio de IA, para a prova Claude Certified Architect – Foundations: 20 perguntas por domínio, 100 no total, com feedback instantâneo e explicações."
tags:
  - claude
  - anthropic
  - certification
  - claude-architect
  - practice-quiz
categories:
  - Claude
series:
  - becoming-a-claude-architect
series_order: 7
showAuthor: true
image: cover.png
---

## Do que se trata

Isso fecha a série **Tornando-se um Claude Architect** com uma autoavaliação: 100 perguntas de prática, 20 por domínio, cobrindo tudo desde o [Domínio 1 — Agentic Architecture & Orchestration]({{< ref "/posts/claude-architect-02-agentic-architecture-orchestration/" >}}) até o [Domínio 5 — Context Management & Reliability]({{< ref "/posts/claude-architect-06-context-management-reliability/" >}}). Clique numa resposta e você verá imediatamente se está certa, com uma explicação curta de qualquer forma.

**Isto é um material de estudo não oficial, com apoio de IA — não validado contra o estilo ou dificuldade da prova real.** Eu mesmo redigi essas perguntas, fundamentadas nas declarações de tarefa do guia oficial da prova e no conteúdo das Partes 2 a 6 desta série, mas a Anthropic não revisou nem endossou esse material. Trate isso como uma forma de testar seu próprio entendimento, não como substituto do guia oficial da prova ou do material de preparação da própria Anthropic.

![Gráfico estatístico mostrando 100 perguntas de prática não oficiais nos cinco domínios da prova Claude Certified Architect – Foundations, 20 perguntas por domínio, com o peso de cada domínio na prova listado](hero-stat.webp "20 perguntas por domínio, ajustadas à participação de cada domínio na prova real")

## Como usar

{{< mermaid >}}
flowchart LR
    A[Leia a pergunta] --> B[Escolha uma resposta]
    B --> C{Correta?}
    C -->|Sim| D[Marca verde + explicação]
    C -->|Não| E[X vermelho na sua escolha,<br/>marca verde na certa,<br/>+ explicação]
    D --> F[Vá para a próxima pergunta]
    E --> G[Releia a seção relevante<br/>do post do domínio]
    G --> F

    style D fill:#28c840,stroke:#1c9c30,color:#fff
    style E fill:#e0524a,stroke:#b3261e,color:#fff
{{< /mermaid >}}

Sem pontuação, sem embaralhamento, sem cronômetro — apenas clique nas 20 perguntas de um domínio, em ordem, e veja como você se sai. Se uma pergunta te derrubar, ela nomeia o conceito claramente o suficiente na explicação para você voltar à seção completa daquele domínio no post correspondente.

## Domínio 1 — Agentic Architecture & Orchestration (27%)

{{< quiz >}}
Q: No loop agentivo do Claude, o que um stop_reason de tool_use sinaliza?
A) A conversa terminou permanentemente
B) O Claude quer chamar uma ferramenta e espera o resultado de volta antes de continuar
C) Ocorreu um erro durante a geração
D) A janela de contexto foi excedida
CORRECT: B
EXPLAIN: tool_use significa que o Claude solicitou uma chamada de ferramenta; o loop continua assim que o resultado da ferramenta é retornado, ao contrário de end_turn, que sinaliza que o Claude terminou de responder.
@@@
Q: Numa arquitetura multiagente hub-and-spoke, qual é o trabalho principal do coordenador?
A) Realizar todo o trabalho detalhado sozinho por consistência
B) Decompor a tarefa, despachar subagentes e sintetizar seus resultados
C) Armazenar todo o histórico da conversa para cada subagente
D) Substituir totalmente a necessidade de uso de ferramentas
CORRECT: B
EXPLAIN: O coordenador orquestra — dividindo o trabalho em partes, delegando a subagentes e combinando o que volta — em vez de fazer o trabalho pesado ele mesmo.
@@@
Q: Por que é arriscado assumir que um subagente tem acesso ao histórico da conversa principal?
A) Subagentes são sempre mais lentos que o agente principal
B) Subagentes não herdam o contexto do pai automaticamente — qualquer coisa que precisem deve ser passada explicitamente
C) Subagentes só podem ser chamados uma vez por sessão
D) Subagentes compartilham a mesma janela de contexto do coordenador
CORRECT: B
EXPLAIN: Um subagente começa com um contexto limpo; o que quer que precise da conversa até então tem que ser incluído explicitamente no seu prompt.
@@@
Q: Qual é o propósito de allowedTools ao configurar um subagente ou invocação do Task?
A) Acelerar a geração de tokens
B) Restringir quais ferramentas aquela invocação pode usar
C) Traduzir automaticamente as saídas das ferramentas
D) Armazenar em cache os resultados de ferramentas entre sessões
CORRECT: B
EXPLAIN: allowedTools restringe o acesso a um conjunto específico e limitado de ferramentas para aquela invocação, em vez de conceder acesso irrestrito.
@@@
Q: Para que um hook PreToolUse é mais adequado?
A) Registrar a saída de uma ferramenta depois que ela termina
B) Bloquear ou modificar deterministicamente uma chamada de ferramenta antes que ela seja executada
C) Resumir a conversa
D) Selecionar qual modelo usar
CORRECT: B
EXPLAIN: Um hook PreToolUse roda antes da execução, então pode impor uma regra de forma determinística (por exemplo, bloquear um comando perigoso) em vez de depender de o modelo seguir uma instrução baseada em prompt.
@@@
Q: Por que a aplicação via hooks é considerada mais confiável do que apenas orientação via prompt?
A) Hooks rodam mais rápido que qualquer prompt
B) Hooks são código determinístico que sempre roda, enquanto uma instrução de prompt é seguida apenas de forma probabilística
C) Hooks eliminam a necessidade de descrições de ferramentas
D) Hooks são a única forma de chamar um subagente
CORRECT: B
EXPLAIN: Um hook é código que executa toda vez, incondicionalmente; uma instrução baseada em prompt depende do modelo escolher, de forma confiável, segui-la.
@@@
Q: Quando uma decomposição de pipeline fixo é mais apropriada do que uma adaptativa?
A) Quando as etapas e sua ordem são bem compreendidas e repetíveis
B) Quando a tarefa é altamente exploratória e o caminho a seguir é incerto
C) Quando nenhuma ferramenta está disponível
D) Quando apenas um subagente será usado
CORRECT: A
EXPLAIN: Um pipeline fixo serve bem para fluxos de trabalho bem compreendidos e repetíveis; a decomposição adaptativa serve para tarefas abertas e exploratórias, em que o próximo passo depende do que é descoberto.
@@@
Q: O que resume faz numa sessão do Claude Code, diferentemente de fork_session?
A) Inicia uma sessão inteiramente nova e não relacionada
B) Continua o histórico de uma sessão existente no mesmo lugar
C) Apaga o contexto da sessão anterior
D) Mescla duas sessões não relacionadas
CORRECT: B
EXPLAIN: resume retoma o histórico de uma sessão existente e o continua, enquanto fork_session ramifica uma nova sessão que preserva a original intacta.
@@@
Q: Quando ramificar uma sessão (fork_session) é a escolha melhor do que retomá-la?
A) Quando você quer explorar uma abordagem alternativa sem perder a linha original
B) Quando você quer apagar permanentemente a conversa original
C) Quando você precisa reduzir os custos de token a zero
D) Quando a tarefa não envolve nenhuma ferramenta
CORRECT: A
EXPLAIN: Ramificar cria um novo caminho mantendo a sessão original intacta, útil para experimentar uma alternativa sem se comprometer com ela.
@@@
Q: Qual é a vantagem de iniciar uma sessão nova com um resumo injetado em vez de retomar o histórico completo?
A) Garante saída idêntica a retomar a sessão
B) Reduz o tamanho do contexto preservando o estado anterior essencial
C) Desativa todos os hooks
D) Corrige automaticamente qualquer erro anterior
CORRECT: B
EXPLAIN: Um resumo injetado carrega adiante o que importa sem o custo em tokens do histórico original completo — útil quando esse histórico cresceu demais.
@@@
Q: Por que um subagente deveria retornar um resultado conciso e estruturado em vez de sua transcrição de trabalho bruta e completa?
A) Transcrições brutas não são suportadas pela API
B) Isso mantém o contexto do coordenador focado e evita poluí-lo com trabalho intermediário verboso
C) Resultados estruturados são sempre factualmente corretos
D) É exigido pela especificação do MCP
CORRECT: B
EXPLAIN: Retornar um resumo ou resultado estruturado em vez da transcrição completa mantém a própria janela de contexto do coordenador livre de ruído irrelevante para seu trabalho de síntese.
@@@
Q: Qual é um critério-chave para decidir onde dividir uma tarefa em chamadas separadas de subagentes?
A) Dividir em contagens arbitrárias de tokens
B) Dividir ao longo de unidades de trabalho naturais e verificáveis de forma independente
C) Sempre usar exatamente dois subagentes
D) Dividir apenas quando um humano solicitar
CORRECT: B
EXPLAIN: Uma boa decomposição segue os limites naturais da tarefa — partes que podem ser verificadas ou concluídas independentemente — em vez de uma regra arbitrária.
@@@
Q: Qual é um modo de falha comum de orquestração em sistemas multiagente?
A) Usar poucas ferramentas por subagente
B) O coordenador confiar cegamente na saída de um subagente sem nenhuma verificação
C) Rodar subagentes em paralelo
D) Dar a um subagente um conjunto de ferramentas estreito e bem definido
CORRECT: B
EXPLAIN: Se um coordenador aceita o que quer que um subagente reporte sem qualquer checagem, um erro ou alucinação de um subagente pode se propagar silenciosamente por todo o sistema.
@@@
Q: Por que a execução paralela de subagentes pode ser preferível à execução sequencial para subtarefas independentes?
A) Garante menor uso de tokens
B) Reduz o tempo total quando as subtarefas não dependem dos resultados umas das outras
C) É exigida por todo servidor MCP
D) Elimina a necessidade de um coordenador
CORRECT: B
EXPLAIN: Subtarefas independentes que não precisam da saída umas das outras podem rodar concorrentemente, reduzindo o tempo total comparado a executá-las uma após a outra.
@@@
Q: O que deveria motivar a mudança de uma arquitetura de agente único para multiagente?
A) A tarefa requer áreas de trabalho distintas e isoláveis, ou exploração verbosa que poluiria um único contexto
B) O usuário pede exatamente duas respostas
C) Qualquer tarefa envolvendo mais de uma chamada de ferramenta
D) Uma preferência por custos de token mais altos
CORRECT: A
EXPLAIN: A arquitetura multiagente compensa quando uma tarefa se divide naturalmente em partes isoláveis, ou quando a exploração de uma parte inundaria o contexto principal com ruído.
@@@
Q: No loop agentivo, o que tipicamente acontece imediatamente após o Claude receber um resultado de ferramenta?
A) A sessão sempre termina
B) O Claude continua raciocinando com o resultado da ferramenta adicionado ao seu contexto, potencialmente chamando mais ferramentas ou finalizando
C) O resultado da ferramenta é descartado
D) Uma nova sessão é criada automaticamente
CORRECT: B
EXPLAIN: O resultado da ferramenta passa a fazer parte do contexto em andamento, e o Claude continua o loop — raciocinando mais, chamando outra ferramenta, ou produzindo uma resposta final.
@@@
Q: Qual é uma razão em nível de arquiteto para preferir vários subagentes com escopo estreito em vez de um único agente amplo e de propósito geral?
A) É exigido pelos termos de serviço da Anthropic
B) O escopo estreito melhora a confiabilidade da seleção de ferramentas e mantém o contexto de cada subagente focado
C) Reduz o número total de chamadas de API a zero
D) Remove a necessidade de qualquer lógica de orquestração
CORRECT: B
EXPLAIN: Um agente com escopo estreito tem menos ferramentas relevantes para escolher e um contexto mais enxuto, o que melhora a confiabilidade.
@@@
Q: A que "decomposição de tarefa" se refere na arquitetura agentiva?
A) Apagar partes de uma tarefa que parecem difíceis demais
B) Dividir uma tarefa maior em unidades menores adequadas para execução por um agente ou subagente individual
C) Reduzir o número de ferramentas disponíveis para uma só
D) Converter uma tarefa em uma única chamada de API
CORRECT: B
EXPLAIN: Decomposição é o processo de dividir uma tarefa em partes dimensionadas e definidas apropriadamente para execução individual, seja pelo agente principal ou por subagentes delegados.
@@@
Q: Qual situação claramente pede gerenciamento de sessão via resume em vez de começar do zero?
A) O usuário quer continuar exatamente de onde uma sessão longa anterior parou, com o histórico completo intacto
B) O usuário quer descartar tudo e recomeçar
C) A tarefa não tem nenhum contexto anterior
D) O usuário quer explicitamente uma pegada de contexto menor
CORRECT: A
EXPLAIN: resume serve para continuar uma linha existente com seu histórico completo, ao contrário de começar do zero ou usar um resumo injetado para reduzir o contexto.
@@@
Q: Por que o guia da prova trata a escolha do padrão de orquestração (agente único vs. coordenador/subagente) como uma decisão arquitetural, e não um detalhe menor de implementação?
A) Porque não tem efeito mensurável nos resultados
B) Porque afeta diretamente o gerenciamento de contexto, a confiabilidade, o custo, e como as falhas se propagam pelo sistema
C) Porque apenas um padrão é sempre válido
D) Porque é decidido automaticamente pelo modelo
CORRECT: B
EXPLAIN: O padrão de orquestração molda como o contexto é isolado, como os erros aparecem, e quanto custa rodar o sistema — todas preocupações arquiteturais de primeira ordem.
{{< /quiz >}}

## Domínio 2 — Tool Design & MCP Integration (18%)

{{< quiz >}}
Q: Qual é o mecanismo principal pelo qual um LLM decide se deve chamar uma determinada ferramenta?
A) O código-fonte interno da ferramenta
B) A descrição da ferramenta
C) A ordem em que as ferramentas foram registradas
D) O tamanho do arquivo da ferramenta
CORRECT: B
EXPLAIN: O modelo nunca lê a implementação de uma ferramenta — ele seleciona com base na descrição, por isso descrições vagas ou sobrepostas causam erros de seleção.
@@@
Q: Qual é o risco de uma descrição mínima de ferramenta como "busca arquivos" quando existe uma segunda ferramenta parecida?
A) Nenhum risco — descrições mínimas são sempre suficientes
B) O modelo não consegue distinguir de forma confiável qual ferramenta chamar quando seus propósitos se sobrepõem
C) Isso desativa automaticamente a segunda ferramenta
D) Causa um erro de compilação
CORRECT: B
EXPLAIN: Com descrições sobrepostas e mal especificadas, o modelo não tem base confiável para escolher a ferramenta certa para um determinado pedido.
@@@
Q: Segundo o guia da prova, o que uma boa descrição de ferramenta deveria incluir além de um resumo de uma linha?
A) Formatos de entrada, exemplos de consultas, casos extremos e limites explícitos do que a ferramenta faz e não faz
B) Apenas o tipo de retorno da ferramenta
C) O nome do engenheiro que a escreveu
D) Uma lista de ferramentas não relacionadas
CORRECT: A
EXPLAIN: Uma descrição que especifica entradas, exemplos, casos extremos e escopo explícito dá ao modelo o suficiente para selecionar e usar a ferramenta corretamente.
@@@
Q: No MCP, o que isError: true dentro de um resultado de ferramenta sinaliza?
A) Uma falha em nível de protocolo que o cliente deve tratar como fatal
B) Um erro de execução de ferramenta que o modelo consegue ver e potencialmente se recuperar
C) Que a ferramenta não existe
D) Que o servidor travou
CORRECT: B
EXPLAIN: isError: true sinaliza uma falha em nível de execução (como um erro de validação) dentro de um resultado de ferramenta normal, especificamente para que o modelo consiga se autocorrigir e tentar de novo.
@@@
Q: Como os erros de protocolo do MCP diferem dos erros de execução de ferramenta?
A) São idênticos em tudo
B) Erros de protocolo (ex: requisição malformada) são retornados como erros JSON-RPC e são menos recuperáveis; erros de execução são recuperáveis via isError
C) Erros de protocolo são sempre culpa do modelo
D) Erros de execução nunca podem ser tentados de novo
CORRECT: B
EXPLAIN: Erros de protocolo sinalizam algo errado com a própria requisição no nível de transporte; erros de execução são falhas de lógica de negócio que o modelo muitas vezes consegue contornar.
@@@
Q: O que o guia da prova recomenda além da flag isError para tratamento de erros em nível de arquiteto?
A) Ignorar erros para manter a conversa fluindo
B) Retornar metadados estruturados categorizando o tipo de falha (transitório, validação, negócio, permissão) com uma flag de "pode tentar de novo"
C) Sempre encerrar a sessão em qualquer erro
D) Esconder completamente os detalhes do erro do modelo
CORRECT: B
EXPLAIN: Metadados de erro estruturados e categorizados dão ao modelo (ou coordenador) informação suficiente para decidir como responder, em vez de um sinal simples de sucesso/falha.
@@@
Q: Por que uma falha de acesso genuína nunca deveria parecer igual a um resultado válido, porém vazio?
A) Porque sempre exigem a mesma ação de recuperação
B) Porque colapsar as duas em "sem dados" leva à decisão de recuperação errada
C) Porque a especificação do MCP proíbe resultados vazios
D) Porque falhas de acesso são sempre transitórias
CORRECT: B
EXPLAIN: Uma falha de acesso precisa de uma resposta diferente (tentar de novo, escalar, checar permissões) do que um resultado legitimamente vazio, então precisam ser distinguíveis.
@@@
Q: Qual orientação sobre número de ferramentas o guia da prova dá, usando 18 vs. 4-5 como exemplo?
A) Mais ferramentas sempre melhoram a confiabilidade
B) Dar a um agente acesso a ferramentas demais (ex: 18 em vez de 4-5) degrada a confiabilidade da seleção de ferramentas
C) O número de ferramentas não tem efeito no desempenho
D) Exatamente 18 ferramentas é o máximo recomendado
CORRECT: B
EXPLAIN: O guia da prova usa esse contraste para ilustrar que a confiabilidade da seleção de ferramentas cai à medida que o número de ferramentas disponíveis cresce desnecessariamente.
@@@
Q: O que é "acesso escopado" no contexto de design de ferramentas multiagente?
A) Dar a cada subagente todas as ferramentas disponíveis
B) Dar a cada subagente apenas as ferramentas relevantes para seu papel específico
C) Desativar completamente o uso de ferramentas para subagentes
D) Atribuir ferramentas aleatoriamente aos subagentes
CORRECT: B
EXPLAIN: O acesso escopado limita o conjunto de ferramentas de cada subagente ao que seu papel realmente precisa, melhorando a confiabilidade da seleção e reduzindo o uso indevido.
@@@
Q: O que tool_choice: auto faz?
A) Força a chamada de uma ferramenta nomeada específica
B) Deixa o Claude decidir se chama uma ferramenta ou não
C) Desativa todas as ferramentas para aquela requisição
D) Chama todas as ferramentas disponíveis simultaneamente
CORRECT: B
EXPLAIN: auto é o comportamento padrão — o Claude decide por conta própria se e qual ferramenta usar, se alguma.
@@@
Q: O que tool_choice: any garante?
A) Que nenhuma ferramenta será chamada
B) Que alguma ferramenta será chamada, embora qual ainda seja escolha do Claude
C) Que a mesma ferramenta é chamada duas vezes
D) Que as descrições de ferramentas são ignoradas
CORRECT: B
EXPLAIN: any força uma chamada de ferramenta a acontecer, sem definir qual ferramenta específica — útil quando você precisa de alguma ação de ferramenta mas não precisa nomeá-la de antemão.
@@@
Q: Quando você usaria um tool_choice forçado nomeando uma ferramenta específica?
A) Quando você precisa que uma ferramenta em particular seja invocada primeiro, antes de o Claude raciocinar sobre qualquer outra coisa
B) Quando você nunca quer que aquela ferramenta seja chamada
C) Quando você quer desativar permanentemente a seleção de ferramentas
D) Quando a ferramenta não tem descrição
CORRECT: A
EXPLAIN: Forçar uma ferramenta específica garante que ela seja a chamada, o que importa quando um fluxo de trabalho precisa que uma ação particular aconteça logo de início.
@@@
Q: Para que .mcp.json é usado no Claude Code?
A) Configuração de servidor pessoal e não compartilhada
B) Configuração de servidor MCP em nível de projeto, versionada no controle de versão e compartilhada com o time
C) Um cache de resultados de chamadas de ferramentas
D) As chaves de API pessoais de um usuário em texto puro
CORRECT: B
EXPLAIN: .mcp.json é commitado no repositório, então todo membro do time trabalhando naquele projeto recebe automaticamente as mesmas ferramentas MCP compartilhadas.
@@@
Q: Para que ~/.claude.json é tipicamente usado?
A) Configuração de ferramentas compartilhada por todo o time
B) Servidores MCP pessoais, de nível de usuário, ou experimentais que não devem ser commitados
C) Armazenar o README do projeto
D) Documentação pública para o servidor MCP
CORRECT: B
EXPLAIN: Este é o escopo de configuração pessoal do usuário — servidores que você está testando ou específicos para você, não compartilhados com o time via controle de versão.
@@@
Q: Por que a expansão de variável de ambiente (ex: ${API_KEY}) importa para a configuração de servidores MCP?
A) Faz o arquivo de configuração carregar mais rápido
B) Permite que credenciais fiquem fora do arquivo de configuração commitado, tornando-o seguro para ir ao controle de versão
C) É exigido para que descrições de ferramentas sejam renderizadas
D) Elimina completamente a necessidade de autenticação
CORRECT: B
EXPLAIN: Com expansão de variável, o arquivo de configuração carrega o formato da configuração, não o segredo em si, então commitar .mcp.json não vaza credenciais.
@@@
Q: O que o guia da prova sugere antes de construir um servidor MCP customizado?
A) Sempre construir customizado independentemente das alternativas
B) Checar primeiro se existe um servidor MCP comunitário já existente e bem mantido
C) Nunca usar servidores comunitários sob nenhuma circunstância
D) Servidores customizados são exigidos para toda integração
CORRECT: B
EXPLAIN: Recorrer a um servidor existente e bem mantido antes de construir o seu próprio evita duplicar esforço e herdar um fardo de manutenção.
@@@
Q: Quando conteúdo de leitura pesada como um catálogo ou base de conhecimento deveria ser exposto como um resource do MCP em vez de uma ferramenta?
A) Nunca — ferramentas são sempre preferíveis
B) Quando é principalmente algo para ler em vez de uma ação para invocar, já que resources se encaixam melhor nesse formato do que uma ferramenta que retorna um bloco de texto
C) Apenas quando o conteúdo tem menos de 100 palavras
D) Apenas para conteúdo de imagem
CORRECT: B
EXPLAIN: Resources do MCP são feitos para expor conteúdo a ser lido, o que se encaixa melhor do que embrulhar dados estáticos ou tipo catálogo numa chamada de ferramenta.
@@@
Q: Qual ferramenta nativa é correta para encontrar onde uma função específica é chamada numa base de código?
A) Glob
B) Grep
C) Write
D) Edit
CORRECT: B
EXPLAIN: Grep busca no conteúdo de arquivos, que é o que é necessário para encontrar onde uma função é referenciada, ao contrário da correspondência de padrão de caminho do Glob.
@@@
Q: Qual ferramenta nativa é correta para encontrar todos os arquivos que correspondem a *.test.ts num projeto?
A) Grep
B) Glob
C) Read
D) Edit
CORRECT: B
EXPLAIN: Glob corresponde caminhos de arquivo por padrão; é a ferramenta certa para encontrar arquivos por nome ou extensão em vez de por seu conteúdo.
@@@
Q: Por que Edit é preferível a Read+Write para uma mudança de código pequena e pontual?
A) Edit é sempre mais rápido independentemente do tamanho do arquivo
B) Edit faz uma modificação pontual e no lugar, em vez de exigir uma reescrita completa do arquivo
C) Read+Write não é suportado pelo Claude Code
D) Edit não exige especificar o caminho do arquivo
CORRECT: B
EXPLAIN: Edit altera apenas a parte visada de um arquivo, o que é mais preciso e menos sujeito a erros do que ler o arquivo inteiro e reescrevê-lo para uma pequena mudança.
{{< /quiz >}}

## Domínio 3 — Claude Code Configuration & Workflows (20%)

{{< quiz >}}
Q: Na hierarquia do CLAUDE.md, qual escopo carrega primeiro (o mais amplo)?
A) ./CLAUDE.md em nível de projeto
B) Um arquivo de política gerenciada em nível de organização
C) CLAUDE.local.md
D) ~/.claude/CLAUDE.md em nível de usuário
CORRECT: B
EXPLAIN: O arquivo de política gerenciada é controlado pelo TI e vale para toda a organização, carregando antes das instruções de nível de usuário, depois de projeto, depois local.
@@@
Q: Para que o CLAUDE.local.md é tipicamente usado?
A) Política de toda a organização compartilhada com cada time
B) Um arquivo no .gitignore para preferências pessoais e específicas de um projeto que não deveriam ser commitadas
C) O único lugar onde descrições de ferramentas podem ser definidas
D) Um arquivo obrigatório para todo site Hugo
CORRECT: B
EXPLAIN: CLAUDE.local.md guarda preferências específicas ao trabalho de uma pessoa num projeto, mantidas fora do controle de versão via .gitignore.
@@@
Q: Qual é a profundidade máxima de aninhamento para a sintaxe de import @caminho/para/arquivo no CLAUDE.md?
A) Ilimitada
B) 4 níveis
C) Apenas 1 nível
D) 10 níveis
CORRECT: B
EXPLAIN: Imports podem aninhar até quatro níveis de profundidade, permitindo que um CLAUDE.md puxe outros arquivos sem duplicar seu conteúdo, mas não indefinidamente.
@@@
Q: Onde vivem os comandos customizados com escopo de usuário, em contraste com os de escopo de projeto?
A) .claude/commands/ (projeto) vs ~/.claude/commands/ (usuário)
B) Ambos vivem sempre na mesma pasta
C) Comandos de usuário só podem ser definidos no CLAUDE.md
D) Não há distinção entre os dois escopos
CORRECT: A
EXPLAIN: Comandos de projeto são commitados no controle de versão e compartilhados com o time; comandos de usuário são pessoais e vivem sob o diretório home do usuário.
@@@
Q: O que definir context: fork no frontmatter de uma skill faz?
A) Desativa a skill completamente
B) Roda a skill num subagente isolado sem visibilidade do histórico da conversa principal
C) Força a skill a rodar duas vezes
D) Concede à skill acesso permanente a todas as ferramentas
CORRECT: B
EXPLAIN: context: fork isola uma tarefa autocontida, como uma revisão de código, do contexto da conversa principal, rodando-a em seu próprio subagente.
@@@
Q: O que allowed-tools no frontmatter de uma skill controla, e por quanto tempo dura a concessão?
A) Concede permanentemente cada ferramenta; a concessão nunca expira
B) Pré-aprova um conjunto específico e restrito de ferramentas para aquela invocação, e a concessão expira depois da próxima mensagem
C) Desativa todas as ferramentas para aquela skill
D) Só se aplica a servidores MCP, nunca a ferramentas nativas
CORRECT: B
EXPLAIN: allowed-tools restringe o acesso a ferramentas a um conjunto específico para uma invocação, e esse acesso não persiste indefinidamente — expira depois da mensagem seguinte.
@@@
Q: Qual campo no frontmatter YAML de um arquivo .claude/rules/ controla quando essa regra carrega?
A) title
B) paths (um padrão glob)
C) author
D) version
CORRECT: B
EXPLAIN: O padrão glob paths determina quais arquivos precisam estar em jogo para aquela regra entrar no contexto, evitando que regras não relacionadas carreguem desnecessariamente.
@@@
Q: Qual é o principal benefício de rules com escopo por caminho em vez de um único CLAUDE.md grande?
A) Elimina a necessidade de qualquer documentação de projeto
B) Mantém o uso de contexto baixo, carregando apenas quando arquivos relevantes estão sendo tocados
C) Corrige automaticamente bugs nos arquivos correspondentes
D) Substitui a necessidade de descrições de ferramentas
CORRECT: B
EXPLAIN: Uma regra com escopo em src/api/**/*.ts só entra no contexto quando você está de fato trabalhando com arquivos correspondentes, em vez de carregar em toda sessão independentemente da relevância.
@@@
Q: Quando o plan mode é mais apropriado?
A) Para uma correção de erro de digitação de uma linha
B) Para mudanças complexas e em múltiplos arquivos onde a abordagem certa é incerta
C) Apenas quando nenhuma ferramenta é necessária
D) Nunca — deveria ser sempre ignorado
CORRECT: B
EXPLAIN: A sobrecarga do plan mode (ler, raciocinar, propor antes de agir) compensa em trabalho incerto ou de grande escala, não em mudanças simples e bem compreendidas.
@@@
Q: Qual é o teste prático para decidir se deve pular o plan mode e executar diretamente?
A) Se a mudança toca mais de 10 arquivos
B) Se você conseguiria descrever o diff em uma frase
C) Se o usuário está observando
D) Se qualquer ferramenta é necessária
CORRECT: B
EXPLAIN: Se a mudança é simples o suficiente para descrever numa única frase, o passo de proposta do plan mode é uma sobrecarga desnecessária.
@@@
Q: Para que o "padrão de entrevista" é usado no refinamento iterativo?
A) Fazer o Claude perguntar sobre implementação técnica, UI/UX e casos extremos antes de escrever uma especificação para uma funcionalidade maior
B) Testar o conhecimento do usuário sobre o Claude Code
C) Substituir a necessidade de qualquer planejamento
D) Gerar testes unitários automaticamente
CORRECT: A
EXPLAIN: O padrão de entrevista traz à tona considerações que o usuário talvez não pensasse em mencionar de início, antes de a implementação começar numa funcionalidade maior.
@@@
Q: Por que a iteração orientada a testes é considerada mais forte do que parar assim que o trabalho "parece pronto"?
A) Porque testes são exigidos pelo Hugo
B) Porque o Claude roda uma checagem real (testes, um build, uma comparação) e continua iterando até que ela de fato passe
C) Porque elimina a necessidade de revisão de código
D) Porque garante zero bugs
CORRECT: B
EXPLAIN: Uma checagem real e objetiva captura problemas que a inspeção visual sozinha deixaria passar, e a iteração continua até que essa checagem de fato passe.
@@@
Q: O que a flag -p (ou --print) habilita no Claude Code?
A) Imprimir a conversa numa impressora física
B) Execução não interativa, utilizável dentro de pipelines de CI, hooks de pre-commit ou scripts
C) Desativar todo uso de ferramentas
D) Trocar permanentemente para outro modelo
CORRECT: B
EXPLAIN: -p roda o Claude Code de forma não interativa, o que é o que o torna utilizável em contextos automatizados como CI, em vez de apenas uma sessão interativa de terminal.
@@@
Q: O que --output-format json fornece quando combinado com -p?
A) Uma amostragem aleatória da resposta
B) Uma resposta estruturada que um pipeline consegue interpretar programaticamente em vez de raspar texto simples
C) A desativação de toda a saída
D) Tradução automática para outro idioma
CORRECT: B
EXPLAIN: A saída JSON estruturada permite que um pipeline de CI ou script consuma a resposta do Claude Code de forma confiável, em vez de interpretar texto livre.
@@@
Q: Fornecer exemplos de entrada/saída ("essa entrada deveria produzir aquela saída") é um exemplo de qual técnica de iteração?
A) Iteração orientada a testes
B) O padrão de entrevista
C) Dar ao Claude algo concreto contra o que checar seu próprio trabalho, em vez de descrever o comportamento de forma abstrata
D) Plan mode
CORRECT: C
EXPLAIN: Exemplos concretos dão ao Claude um alvo direto a que corresponder, o que é mais confiável do que uma descrição abstrata do comportamento desejado.
@@@
Q: Em relação a que os imports @caminho/para/arquivo no CLAUDE.md são resolvidos?
A) O diretório raiz do projeto sempre
B) O arquivo que os referencia
C) O diretório home do usuário sempre
D) Um caminho absoluto fixo definido pela Anthropic
CORRECT: B
EXPLAIN: Os caminhos de import são resolvidos em relação ao arquivo que está fazendo o import, não uma única raiz fixa, o que importa ao aninhar imports entre diretórios.
@@@
Q: Qual é o risco de colocar instruções altamente detalhadas e específicas de fluxo de trabalho diretamente num único CLAUDE.md grande em vez de numa skill?
A) Não há risco — o CLAUDE.md tem capacidade ilimitada
B) Esses tokens carregam no contexto em toda sessão, mesmo quando irrelevantes para a tarefa atual
C) Instruções do CLAUDE.md são ignoradas pelo Claude Code
D) Isso quebra automaticamente a sintaxe @import
CORRECT: B
EXPLAIN: Conteúdo carregado no CLAUDE.md está presente em toda sessão independentemente da relevância; uma skill carrega sob demanda apenas quando de fato invocada.
@@@
Q: Por que o plan mode exige aprovação explícita antes de qualquer arquivo ser tocado?
A) Porque o Claude Code não consegue editar arquivos sem aprovação em nenhum fluxo de trabalho
B) Porque dá ao usuário a chance de identificar uma abordagem errada antes de qualquer mudança ser feita
C) Porque é uma exigência legal
D) Porque o plan mode desativa toda edição permanentemente
CORRECT: B
EXPLAIN: O passo de aprovação é o que torna o plan mode valioso — identificar um plano mal direcionado antes que custe qualquer edição real.
@@@
Q: Qual é uma diferença chave entre um comando de barra em nível de projeto e um em nível de usuário?
A) Comandos de projeto são compartilhados com o time via controle de versão; comandos de usuário são pessoais
B) Comandos de usuário nunca podem chamar ferramentas
C) Comandos de projeto só funcionam em CI
D) Não há diferença funcional
CORRECT: A
EXPLAIN: O escopo de projeto é commitado no repositório e compartilhado; o escopo de usuário é pessoal àquele indivíduo em todos os seus projetos.
@@@
Q: Por que a integração com CI/CD importa como uma habilidade de nível de arquiteto no Claude Code?
A) Não tem aplicação prática fora de sessões interativas
B) Permite que o Claude Code rode checagens automatizadas (como um linter de diff ou resumidor de log) como parte de um pipeline, em vez de apenas interativamente
C) Substitui a necessidade de qualquer revisão humana
D) Só é utilizável com o modelo Opus
CORRECT: B
EXPLAIN: A execução não interativa via -p transforma o Claude Code num componente utilizável dentro de pipelines automatizados, estendendo seu valor muito além de uma única sessão interativa.
{{< /quiz >}}

## Domínio 4 — Prompt Engineering & Structured Output (20%)

{{< quiz >}}
Q: O que o enquadramento "funcionário brilhante, mas novo" nos documentos de prompting do Claude recomenda?
A) Assumir que o Claude já conhece as normas não declaradas do seu time
B) Dar ao Claude contexto e critérios explícitos, já que ele não tem conhecimento implícito das suas expectativas
C) Evitar dar qualquer exemplo
D) Manter as instruções o mais vagas possível
CORRECT: B
EXPLAIN: Tratar o Claude como um recém-chegado inteligente sem contexto significa explicitar critérios em vez de assumir normas compartilhadas e não declaradas.
@@@
Q: Por que "Reporte vulnerabilidades de segurança e erros de lógica; ignore preferências de estilo" supera "Revise esse código"?
A) É mais curto
B) Dá critérios explícitos e verificáveis do que vale a pena sinalizar
C) Usa vocabulário mais técnico
D) Evita usar qualquer pontuação
CORRECT: B
EXPLAIN: A versão explícita diz ao Claude exatamente o que procurar e o que ignorar, removendo o palpite que a versão vaga deixa em aberto.
@@@
Q: Para que o few-shot (multishot) prompting é usado principalmente?
A) Reduzir o número total de tokens num prompt
B) Guiar formato, tom e estrutura da saída de forma mais confiável do que apenas descrição abstrata
C) Desativar o uso de ferramentas
D) Dispensar a necessidade de um prompt de sistema
CORRECT: B
EXPLAIN: O Claude generaliza a partir de exemplos concretos de forma mais confiável do que a partir de regras puramente abstratas, por isso exemplos são tão eficazes para guiar a saída.
@@@
Q: Para uma tarefa de extração ambígua, quantos exemplos bem escolhidos o guia da prova sugere?
A) 0
B) 2 a 4
C) 50
D) Exatamente 1, nunca mais
CORRECT: B
EXPLAIN: Um pequeno número de exemplos bem escolhidos e direcionados — 2 a 4 — cobrindo casos ambíguos ou extremos faz mais para reduzir alucinação do que uma especificação escrita longa.
@@@
Q: Qual é o propósito de envolver exemplos few-shot em tags <example>?
A) Fazê-los carregar mais rápido
B) Marcá-los claramente à parte do resto do prompt para que sejam lidos como demonstrações, não instruções
C) Desativá-los por padrão
D) Convertê-los automaticamente para JSON
CORRECT: B
EXPLAIN: A marcação explícita evita que o modelo confunda um exemplo ilustrativo com uma instrução literal a ser seguida ao pé da letra.
@@@
Q: Por que os exemplos few-shot deveriam ser diversos em vez de todos parecidos entre si?
A) Diversidade não tem efeito na qualidade da saída
B) Exemplos diversos cobrindo casos extremos impedem que o Claude trave num único padrão não intencional
C) Exemplos diversos são exigidos pela API
D) Isso reduz o número de tokens necessários
CORRECT: B
EXPLAIN: Se todo exemplo se parece, o Claude pode se ajustar demais àquele padrão estreito em vez de generalizar corretamente pela variedade de entradas reais.
@@@
Q: O que o uso de ferramentas com um JSON schema (especialmente strict: true) garante que pedir JSON em texto simples não garante?
A) Tempos de resposta mais rápidos em todos os casos
B) Saída em conformidade com o schema através de decodificação restrita, evitando erros de parsing por um formato malformado
C) Custo zero por requisição
D) Comprimento de saída ilimitado
CORRECT: B
EXPLAIN: A decodificação restrita sob o modo strict impõe o schema no momento da geração, o que pedidos de JSON em texto simples não conseguem garantir.
@@@
Q: Quando documentos de origem podem não conter todos os campos que um schema define, qual é a escolha de design recomendada?
A) Forçar o Claude a inventar um valor plausível para o campo faltante
B) Tornar esses campos opcionais (deixá-los fora de required) em vez de forçar a invenção
C) Rejeitar o documento inteiramente
D) Sempre definir campos faltantes como zero por padrão
CORRECT: B
EXPLAIN: Marcar campos incertos como opcionais permite que o Claude omita o que genuinamente não está presente, em vez de inventar um valor só para satisfazer o schema.
@@@
Q: Qual é um risco chave de depender apenas de instruções em prosa ("por favor responda em JSON") para saída estruturada, sem uso de ferramentas?
A) Nenhum — instruções em prosa são tão confiáveis quanto o uso de ferramentas com schema
B) A saída ainda pode ficar malformada ou falhar ao ser interpretada, já que nada impõe o formato no momento da geração
C) Isso dispara automaticamente um erro de validação
D) Isso desativa o raciocínio estendido
CORRECT: B
EXPLAIN: Sem imposição de schema via uso de ferramentas, um pedido só em texto por JSON ainda pode voltar malformado, exigindo um parser para capturar o que deveria ter sido evitado antes.
@@@
Q: Qual é o padrão mais forte quando uma checagem de validação falha na saída gerada?
A) Descartar a saída silenciosamente e seguir em frente
B) Anexar o erro de validação específico ao prompt na retentativa, para que o Claude veja exatamente o que estava errado
C) Reenviar o prompt idêntico sem alterações
D) Escalar imediatamente para um humano sem tentar de novo
CORRECT: B
EXPLAIN: Devolver a falha específica permite que o Claude corrija o problema real, em vez de adivinhar de novo a partir de um prompt inalterado.
@@@
Q: Como os erros semânticos diferem dos erros de sintaxe na validação?
A) São a mesma coisa
B) Erros semânticos significam que o dado em si está errado (um valor implausível); erros de sintaxe significam que o formato está errado (JSON malformado, chave faltando)
C) Erros de sintaxe nunca podem ser capturados automaticamente
D) Erros semânticos só ocorrem com uso de ferramentas
CORRECT: B
EXPLAIN: Os dois tipos de erro pedem feedbacks diferentes — um erro semântico precisa de correção de um valor, um erro de sintaxe precisa de correção de estrutura.
@@@
Q: O que rastrear tipos de erro recorrentes ao longo de muitas retentativas ajuda a identificar?
A) Nada útil — retentativas deveriam sempre parecer idênticas
B) Se o schema ou o próprio prompt precisa mudar, não apenas a lógica de retentativa
C) A latência exata da API
D) Qual versão do modelo está rodando
CORRECT: B
EXPLAIN: Um padrão do mesmo erro se repetindo aponta para um problema mais profundo no design do prompt ou do schema, não algo que uma retentativa mais inteligente sozinha conseguiria corrigir.
@@@
Q: Qual é uma limitação estrutural de um modelo revisando sua própria saída gerada?
A) A autorrevisão é sempre mais precisa do que a revisão independente
B) O modelo retém o contexto de ter gerado o trabalho, tornando-o menos propenso a questionar suas próprias escolhas
C) A autorrevisão não é tecnicamente possível
D) A autorrevisão sempre leva mais tempo do que a revisão independente
CORRECT: B
EXPLAIN: Tendo acabado de produzir o trabalho, o modelo está preparado para confirmar em vez de interrogar suas próprias escolhas.
@@@
Q: Por que uma instância de revisão independente costuma capturar mais do que a autorrevisão?
A) Ela não tem memória de ter escrito o trabalho, então não tem nada investido na abordagem original
B) Ela sempre usa um modelo maior
C) Ela automaticamente tem acesso a mais ferramentas
D) Ela pula a validação completamente
CORRECT: A
EXPLAIN: Uma instância nova, sem interesse na geração original, consegue escrutinar o trabalho de forma mais objetiva do que a instância que o produziu.
@@@
Q: Na revisão multi-passo para revisões grandes, qual é a diferença entre um passo local e um passo de integração?
A) Não há diferença
B) Um passo local checa cada peça isoladamente; um passo de integração checa como as peças se encaixam
C) Um passo local só checa ortografia
D) Um passo de integração é sempre pulado
CORRECT: B
EXPLAIN: Dividir a revisão em passos local e de integração captura tanto problemas por peça quanto problemas entre arquivos/componentes que um único passo provavelmente deixaria passar.
@@@
Q: Aproximadamente quanto de economia de custo a Message Batches API oferece em comparação com o preço padrão?
A) Nenhuma economia
B) Aproximadamente 50% de desconto sobre o preço padrão de tokens
C) 99% de desconto
D) Custa mais do que requisições padrão
CORRECT: B
EXPLAIN: Lotes trocam imediatismo por custo, oferecendo aproximadamente metade do preço de requisições síncronas padrão.
@@@
Q: Qual é a janela máxima de processamento da Message Batches API?
A) 1 minuto
B) 24 horas
C) 7 dias
D) Não há máximo
CORRECT: B
EXPLAIN: Lotes têm uma janela máxima de processamento de 24 horas, embora a maioria termine bem dentro de uma hora.
@@@
Q: Qual é o propósito de custom_id numa requisição em lote?
A) Definir a temperatura do modelo
B) Identificar e corresponder resultados individuais, já que os resultados do lote retornam em ordem arbitrária
C) Criptografar a requisição
D) Definir um limite de gastos
CORRECT: B
EXPLAIN: Como os resultados do lote não voltam na ordem de envio, custom_id é o que permite corresponder cada resultado à sua requisição original e reenviar seletivamente as falhas.
@@@
Q: Para que tipo de carga de trabalho a Message Batches API é mais adequada?
A) Uma interface de chat ao vivo em que o usuário está esperando em tempo real
B) Trabalho tolerante à latência e de alto volume, como extração em massa ou avaliação em larga escala
C) Uma única requisição pontual
D) Qualquer coisa que exija tempo de resposta abaixo de um segundo
CORRECT: B
EXPLAIN: Lotes são feitos para trabalho não bloqueante e de alto volume em que ninguém está esperando por uma resposta imediata — o oposto de um caso de uso interativo ao vivo.
@@@
Q: Qual é a abordagem recomendada se uma requisição em lote falha com um erro do tipo validação em vez de um erro de servidor?
A) Reenviar o lote inteiro sem alterações
B) Usar custom_id para identificar e reenviar seletivamente apenas as requisições que falharam, provavelmente com uma correção
C) Descartar o lote inteiro permanentemente
D) Trocar de modelo e reenviar tudo
CORRECT: B
EXPLAIN: custom_id permite isolar e corrigir apenas as requisições que falharam em vez de rodar o lote inteiro de novo, o que é mais rápido e mais barato.
{{< /quiz >}}

## Domínio 5 — Context Management & Reliability (15%)

{{< quiz >}}
Q: Qual informação corre mais risco de se perder durante a sumarização progressiva de uma conversa longa?
A) O tópico geral da conversa
B) Valores numéricos, datas, e as expectativas exatas declaradas por um cliente
C) O nome do modelo sendo usado
D) A contagem total de tokens
CORRECT: B
EXPLAIN: Detalhes precisos e concretos são exatamente o que se dissolve em prosa vaga quando uma conversa é repetidamente sumarizada.
@@@
Q: O que o efeito "lost in the middle" descreve?
A) Os modelos têm desempenho igual independentemente de onde a informação está numa entrada longa
B) Informação enterrada no meio de uma entrada longa é usada de forma menos confiável do que conteúdo perto do início ou do fim
C) Um bug que só afeta a última mensagem
D) Uma falha de cache específica do uso de ferramentas
CORRECT: B
EXPLAIN: Conteúdo perto do início ou do fim de uma entrada longa tende a receber atenção mais confiável do que conteúdo enterrado no meio.
@@@
Q: Qual é o propósito de extrair fatos transacionais para um bloco persistente de "fatos do caso"?
A) Tornar a transcrição da conversa mais curta apenas para fins de exibição
B) Preservar fatos concretos independentemente do resumo narrativo, que pode se desviar ou perder detalhe com o tempo
C) Substituir a necessidade de qualquer sumarização
D) Satisfazer uma exigência de formatação sem benefício funcional
CORRECT: B
EXPLAIN: Um registro estruturado e persistente dos fatos reais sobrevive independentemente do que aconteça com o resumo narrativo em andamento.
@@@
Q: Por que a saída verbosa de ferramentas deveria ser aparada antes de se acumular, em vez de depois?
A) Aparar depois de acumular é sempre mais eficiente
B) Uma vez que a saída verbosa se acumulou ao longo de muitos turnos, ela consome uma parcela desproporcional do contexto em relação ao seu valor
C) A saída de ferramentas não pode ser aparada posteriormente sob nenhuma circunstância
D) Não tem efeito no uso de tokens de qualquer forma
CORRECT: B
EXPLAIN: Aparar proativamente evita que resultados verbosos consumam silenciosamente o orçamento de contexto turno após turno, em vez de lidar com o custo acumulado depois.
@@@
Q: Por que colocar resumos no início de um prompt é recomendado?
A) Não tem efeito mensurável
B) Trabalha a favor do efeito lost-in-the-middle em vez de contra ele, já que conteúdo perto do início é usado de forma mais confiável
C) É exigido pela API
D) Reduz o número de chamadas de ferramentas
CORRECT: B
EXPLAIN: Colocar o resumo onde recebe atenção mais confiável contraria a tendência de conteúdo enterrado no meio do prompt ser subutilizado.
@@@
Q: Por que a análise de sentimento e as pontuações de confiança são consideradas sinais não confiáveis para disparar escalonamento para um humano?
A) Elas são sempre 100% precisas
B) Um caso pode parecer calmo enquanto na verdade está travado, ou parecer ansioso enquanto é simples de resolver
C) Elas não são tecnicamente possíveis de calcular
D) Elas só funcionam para texto em inglês
CORRECT: B
EXPLAIN: Tom e confiança não rastreiam de forma confiável se um caso é de fato resolúvel, por isso critérios explícitos são preferidos a essas heurísticas.
@@@
Q: O que o guia da prova recomenda para definir gatilhos de escalonamento?
A) Confiar puramente na intuição do modelo sem critérios explícitos
B) Critérios explícitos de escalonamento apoiados por exemplos few-shot
C) Escalar toda e qualquer requisição independentemente do contexto
D) Nunca escalar sob nenhuma circunstância
CORRECT: B
EXPLAIN: Critérios concretos combinados com exemplos dão um gatilho de escalonamento muito mais confiável do que um julgamento implícito e sem critérios.
@@@
Q: Como um pedido explícito do cliente por um agente humano deveria ser tratado?
A) Ignorado se a questão parecer resolúvel
B) Honrado imediatamente, independentemente de a questão parecer resolúvel
C) Escalado apenas após mais três trocas
D) Tratado da mesma forma que qualquer outro pedido de baixa prioridade
CORRECT: B
EXPLAIN: Um pedido direto por um humano é honrado imediatamente — não é algo para contornar mesmo que o agente acredite que poderia resolver a questão sozinho.
@@@
Q: O que deveria acontecer quando múltiplos registros de cliente correspondem plausivelmente à informação identificadora disponível?
A) Selecionar automaticamente o registro ativo mais recentemente
B) Pedir um identificador adicional para desambiguar em vez de adivinhar
C) Mesclar todos os registros correspondentes
D) Escalar imediatamente sem perguntar nada
CORRECT: B
EXPLAIN: A seleção heurística entre correspondências ambíguas não é confiável; pedir mais um identificador resolve a ambiguidade adequadamente.
@@@
Q: O que um subagente deveria retornar quando falha, além de um status simples de "falhou"?
A) Nada — um status simples é suficiente
B) Contexto de erro estruturado incluindo o tipo de falha e quais alternativas existem
C) O stack trace interno completo sem nenhum resumo
D) Uma contagem de retentativas aleatória
CORRECT: B
EXPLAIN: Contexto estruturado — que tipo de falha, e quais alternativas estão disponíveis — é o que de fato permite que um coordenador tome uma decisão de recuperação inteligente.
@@@
Q: Por que uma falha de acesso genuína precisa ser distinguível de um resultado válido, porém vazio?
A) Porque sempre exigem tratamento idêntico
B) Porque colapsar ambos em "sem dados" leva um coordenador a tomar a decisão de recuperação errada
C) Porque a especificação do MCP não permite resultados vazios
D) Porque falhas de acesso são sempre permanentes
CORRECT: B
EXPLAIN: Uma falha de acesso pode pedir uma retentativa ou escalonamento; um resultado legitimamente vazio não — confundir os dois quebra a capacidade do coordenador de responder corretamente.
@@@
Q: Antes de propagar uma falha para o coordenador, o que um subagente deveria tentar?
A) Nada — sempre propagar imediatamente
B) Recuperação local, se possível, antes de escalar a falha para cima
C) Encerrar todo o fluxo de trabalho multiagente
D) Suprimir o erro silenciosamente
CORRECT: B
EXPLAIN: Tentar a recuperação localmente primeiro evita escalar problemas que o subagente poderia ter resolvido sozinho.
@@@
Q: O que a saída de síntese deveria incluir quando alguns resultados de subagentes estão incompletos ou faltando?
A) Nada — apresentar os resultados disponíveis como se estivessem completos
B) Anotações de cobertura observando as lacunas, em vez de apresentar silenciosamente resultados parciais como completos
C) Um pedido de desculpas genérico sem especificidades
D) Um loop de retentativa automático sem visibilidade para o usuário
CORRECT: B
EXPLAIN: Anotar lacunas de cobertura evita que quem consome a saída sintetizada confunda um resultado parcial com um completo.
@@@
Q: O que o guia da prova diz que acontece com a consistência das respostas em sessões estendidas do Claude Code?
A) Sempre melhora quanto mais a sessão roda
B) A degradação de contexto em sessões estendidas pode produzir respostas inconsistentes
C) É completamente não afetada pela duração da sessão
D) Só afeta sessões usando servidores MCP
CORRECT: B
EXPLAIN: O guia da prova nomeia isso diretamente — sessões longas podem acumular ruído de contexto suficiente para tornar as respostas menos consistentes com o tempo.
@@@
Q: Qual é o propósito de um arquivo scratchpad durante a exploração de uma base de código grande?
A) Armazenar as notas pessoais do usuário não relacionadas à tarefa
B) Persistir descobertas-chave através de fronteiras de contexto para que sobrevivam mesmo que a sessão não sobreviva
C) Desativar exploração adicional
D) Substituir a necessidade de qualquer subagente
CORRECT: B
EXPLAIN: Um scratchpad captura descobertas de forma durável e externa, para que não sejam perdidas se o contexto da sessão for compactado ou reiniciado.
@@@
Q: Por que delegar exploração verbosa de base de código a subagentes em vez de fazê-la na conversa principal?
A) Não tem efeito no uso de contexto
B) Isola o ruído da busca para que apenas um resumo volte para a conversa principal
C) É exigido por todo servidor MCP
D) Desativa o acesso a ferramentas do agente principal
CORRECT: B
EXPLAIN: O vai-e-vem verboso de explorar uma base de código grande fica no próprio contexto do subagente, mantendo a conversa principal focada.
@@@
Q: O que o comando /compact faz numa sessão estendida do Claude Code?
A) Apaga a sessão inteira sem recuperação
B) Recupera espaço de contexto sumarizando o histórico mais antigo, opcionalmente guiado por instruções sobre o que preservar
C) Desativa todo uso adicional de ferramentas
D) Troca automaticamente para outro modelo
CORRECT: B
EXPLAIN: /compact libera espaço sumarizando o histórico, e pode ser direcionado ao que mais importa preservar, em vez de adivinhar às cegas.
@@@
Q: Por que a amostragem aleatória estratificada é preferível a uma única métrica de acurácia agregada?
A) Um número agregado pode esconder desempenho ruim num segmento específico que uma amostra estratificada revelaria
B) A amostragem estratificada sempre produz um número de acurácia mais alto
C) Métricas agregadas são tecnicamente impossíveis de calcular
D) A amostragem estratificada elimina a necessidade de qualquer revisão humana
CORRECT: A
EXPLAIN: Um número de acurácia geral alto pode mascarar um modelo com desempenho ruim num tipo de documento ou segmento — a amostragem estratificada revela essa lacuna.
@@@
Q: Contra o que as pontuações de confiança em nível de campo são calibradas, segundo o guia da prova?
A) Nada — são geradas arbitrariamente
B) Um conjunto de dados rotulado, para que as pontuações possam ser confiáveis o suficiente para rotear extrações de baixa confiança para revisão humana
C) O número total de chamadas de API feitas
D) O tamanho da janela de contexto do modelo
CORRECT: B
EXPLAIN: A calibração contra dados rotulados é o que torna uma pontuação de confiança significativa o suficiente para ser usada como sinal de roteamento para revisão humana.
@@@
Q: Por que mapeamentos estruturados de afirmação-para-fonte importam na síntese multi-fonte?
A) Não têm benefício prático
B) Preservam a proveniência (URL, trecho, data) que de outra forma se perderia no momento em que um fato é resumido sem sua origem
C) São exigidos apenas para documentos legais
D) Eliminam a necessidade de qualquer citação
CORRECT: B
EXPLAIN: Sem um mapeamento estruturado de volta à sua fonte, um fato sintetizado perde sua proveniência — de onde veio, e quando — o que importa para confiança e verificação.
{{< /quiz >}}

## Conclusão

Essa é a série: cinco domínios, trinta e um pontos-chave, cinco diagramas, cinco gráficos, e agora cem perguntas para checar o que ficou. A prova Claude Certified Architect – Foundations testa julgamento arquitetural real — quando recorrer a um subagente em vez de fazer o trabalho diretamente, como projetar uma descrição de ferramenta que um modelo consegue de fato interpretar corretamente, quando o plan mode compensa sua sobrecarga, como garantir saída estruturada em vez de simplesmente esperar por ela, e como manter um agente de execução longa honesto sobre o que sabe e o que não sabe. Se este quiz revelou uma lacuna, os posts de domínio linkados acima são a forma mais rápida de fechá-la.

## Fontes

- [Claude Certified Architect – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542750%2FClaude+Certified+Architect+%E2%80%93+Foundations+Exam+Guide.pdf) — declarações de tarefa dos cinco domínios
- [Série Tornando-se um Claude Architect]({{< ref "/posts/claude-architect-01-overview/" >}}) — Partes 1 a 6, a fonte primária de cada pergunta acima

Essas 100 perguntas foram redigidas com IA e checadas contra o conteúdo dos próprios posts de domínio e o guia da prova; eu as revisei quanto à precisão e adequação, mas elas não foram validadas contra o estilo ou dificuldade reais das perguntas da prova.

## Onde isso se encaixa

Parte 7 — o final — de **Tornando-se um Claude Architect**, seguindo o [Domínio 5 — Context Management & Reliability]({{< ref "/posts/claude-architect-06-context-management-reliability/" >}}). Essa é a série completa: da [Parte 1 — Visão Geral]({{< ref "/posts/claude-architect-01-overview/" >}}) até este quiz de prática.
