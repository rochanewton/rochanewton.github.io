---
title: "GitHub Student Developer Pack: o que está incluído e como eu usaria"
date: 2026-09-30
description: "O que estudantes verificados realmente recebem do GitHub Education — Copilot Student, Codespaces, GitHub Pro e ofertas de parceiros para cloud, domínios, dados e observabilidade — e as condições que você precisa checar antes de ativar qualquer coisa."
tags:
  - github
  - github-education
  - student-developer-pack
  - github-copilot
  - codespaces
  - cloud
  - devops
  - learning
categories:
  - GitHub
series:
  - github-in-practice
series_order: 1
showAuthor: true
image: cover.png
---

## Do que se trata

Aprender cloud e DevOps tem um problema de custo. As ferramentas são pagas, a infraestrutura cobra por hora e os bons cursos ficam atrás de assinaturas. Muita gente aprende os conceitos e nunca chega a usar as ferramentas profissionais que vêm com eles.

O **GitHub Student Developer Pack** tira boa parte desse custo enquanto você é um estudante verificado. Eu tenho o Pack, uso parte dele, e este post mostra o que tem nele, como eu escolheria as ofertas sendo alguém que está construindo carreira em Cloud/DevOps, e as letras miúdas que importam antes de clicar em "ativar".

*Última revisão: 30 de setembro de 2026. As ofertas mudam, então os links oficiais abaixo sempre têm a palavra final.*

## Ponto-chave 1: GitHub Education vs. Student Developer Pack

Os dois nomes são usados como sinônimos, mas são coisas diferentes:

- **[GitHub Education](https://education.github.com/)** é o programa. Você se inscreve uma vez, comprova que é estudante e o GitHub te verifica.
- **O [Student Developer Pack](https://education.github.com/pack)** é o catálogo de ofertas liberado depois da verificação: os benefícios do próprio GitHub mais dezenas de ofertas de parceiros.

O que muita gente perde: **a verificação não ativa tudo.** Cada oferta de parceiro é resgatada separadamente, geralmente no site do parceiro e com uma conta própria. Até o Copilot é uma etapa separada depois da aprovação, e o GitHub avisa que o benefício de estudante [pode levar vários dias para ser aplicado](https://docs.github.com/en/copilot/how-tos/copilot-on-github/set-up-copilot/enable-copilot/set-up-for-students). Se logo após a aprovação você só vir planos pagos do Copilot, espere. Não compre nenhum.

## Ponto-chave 2: O que o GitHub oferece diretamente

| Benefício | O que você recebe | O detalhe que importa |
| --- | --- | --- |
| **GitHub Pro** | Gratuito enquanto você for estudante | Um upgrade do plano da conta pessoal. Muitos recursos principais já estão no GitHub Free ([compare os planos](https://docs.github.com/en/get-started/learning-about-github/githubs-plans)) |
| **Copilot Student** | Assistente de código com IA, gratuito | Um plano próprio, **não** é o Copilot Pro: uma cota de créditos de IA, apenas seleção automática de modelo, sem agentes de terceiros ([planos](https://docs.github.com/en/copilot/get-started/plans)) |
| **Codespaces** | Ambientes de desenvolvimento na nuvem, no navegador ou no VS Code | Até **180 core-hours/mês** mais armazenamento no nível do Pro ([docs para estudantes](https://docs.github.com/en/education/about-github-education/github-education-for-students/about-github-education-for-students)) |

Dois desses precisam de mais explicação.

![Banner do GitHub Education nas configurações da conta, com o texto "Free GitHub developer resources for students and teachers — Get Copilot for free, 180 monthly Codespaces hours for cloud coding, unlimited private repositories with GitHub Pro or Team, and dozens of premium tools in the Student Developer Pack" e um botão Learn more](github-education-benefits-banner.webp "Até o banner do próprio GitHub fala em '180 monthly Codespaces hours'. A documentação define como core-hours, que é o número que realmente conta")

**Codespaces: core-hours, não horas.** O banner acima fala em "hours", mas a documentação conta **core-hours**, e o uso é multiplicado pelo tamanho da máquina. Numa máquina de 2 cores, 180 core-hours dão cerca de **90 horas** de uso por mês; numa de 4 cores, cerca de 45. O armazenamento é cobrado à parte, enquanto o codespace *existir*, e não só enquanto ele estiver rodando ([docs de cobrança](https://docs.github.com/en/billing/concepts/product-billing/github-codespaces)). Apague os codespaces que você não usa mais.

**Copilot Student: útil, mas não é um Copilot Pro de graça.** Você não escolhe o modelo manualmente, e o uso do chat e dos agentes depende da sua cota de créditos. O GitHub também reavalia sua elegibilidade de estudante todo mês.

## Ponto-chave 3: Benefícios de parceiros ao longo da trilha de aprendizado

A página do Pack lista as ofertas por parceiro, o que dificulta enxergar o que você realmente usaria. Acho mais útil mapeá-las para o caminho que todo projeto pequeno percorre:

![Catálogo do Student Developer Pack com cards de ofertas de parceiros: Microsoft (ferramentas de desenvolvimento, serviços de cloud e treinamento gratuitos), New Relic (plataforma de observabilidade), OpenSauced (ferramentas para acompanhar sua experiência em open source), Heroku, JetBrains (IDEs profissionais) e MongoDB, cada um com o link "Get access to offer"](pack-catalog-offers.webp "Cada card é um resgate separado, geralmente no site do próprio parceiro. A verificação libera o catálogo; ela não ativa as ofertas")

{{< mermaid >}}
flowchart TD
    A["Código<br/>JetBrains · Termius"] --> B["Ambiente<br/>Codespaces"]
    B --> C["Deploy<br/>Azure · Heroku"]
    C --> D["Dados<br/>MongoDB Atlas"]
    D --> E["Observar<br/>Datadog · New Relic"]
    E --> F["Publicar<br/>Domínio .me da Namecheap"]
    S["Segredos<br/>Doppler · 1Password"] -.-> C
    L["Estudar<br/>Frontend Masters · Educative · DataCamp"] -.-> A
    style F fill:#1f6f43,stroke:#3fb950,color:#fff
{{< /mermaid >}}

O que cada etapa oferece, segundo o [catálogo do Pack](https://education.github.com/pack) na data de hoje:

- **Cloud:** a Microsoft Azure dá acesso a mais de 25 serviços gratuitos mais **US$ 100 em créditos** (18+). A Heroku dá um crédito de **US$ 13 por mês durante 24 meses**.
- **Dados:** o MongoDB dá **US$ 50 em créditos do MongoDB Atlas**, mais o Compass e a MongoDB University.
- **Observabilidade** (enxergar o que sua aplicação e sua infraestrutura estão fazendo em execução): conta Datadog Pro com 10 servidores, **grátis por 2 anos**, e New Relic gratuito enquanto você for estudante.
- **Segredos:** Doppler Team gratuito enquanto você for estudante, e 1Password grátis por um ano, incluindo as ferramentas para desenvolvedores.
- **Ferramentas de desenvolvimento:** IDEs da JetBrains (renovadas anualmente) e Termius Pro, um cliente SSH, enquanto você for estudante.
- **Domínios:** a Namecheap dá **1 ano de registro de domínio .me** mais um certificado SSL por um ano.
- **Estudo:** Frontend Masters e Educative por 6 meses cada, e DataCamp por 3 meses.

Essa lista é um recorte, não o catálogo inteiro. O catálogo completo é longo, e tentar resgatar tudo é o jeito certo de acabar com doze contas e nenhum projeto.

## Ponto-chave 4: Por onde eu começaria, dependendo do objetivo

Escolha dois ou três benefícios que combinem com a próxima coisa que você quer aprender e ignore o resto até precisar dele.

{{< mermaid >}}
flowchart TD
    Q{O que você quer<br/>aprender agora?} --> A[Cloud e infraestrutura]
    Q --> B[Backend e dados]
    Q --> C[Um portfólio público]
    A --> A1["Crédito Azure + Codespaces<br/>+ Datadog para ver rodando"]
    B --> B1["Crédito Heroku + MongoDB Atlas<br/>+ Copilot Student"]
    C --> C1["Domínio .me da Namecheap<br/>+ GitHub Pages + Copilot Student"]
{{< /mermaid >}}

A ordem importa. Aprenda um conceito, construa algo pequeno, faça o deploy, observe rodando e depois documente. Ter acesso a uma ferramenta não prova habilidade. Um repositório que mostra o que você construiu com ela, sim.

## Ponto-chave 5: O que eu realmente uso

Sendo transparente sobre o meu uso: eu uso dois benefícios do Pack.

- **Copilot Student.** Uso no VS Code, meu editor principal. Ele acelera as partes chatas, mas eu leio cada sugestão antes de aceitar. É um ajudante, não um substituto para entender o código.
- **O domínio .me da Namecheap.** O domínio deste site, **rochanewton.me**, veio do ano grátis de registro .me do Pack. Essa é a primeira lição da seção "confira as condições": a parte gratuita é de **um ano**. A renovação do ano que vem é pelo preço normal, e quem paga sou eu.

Todo o resto deste post é descrito a partir dos termos oficiais, não de testes práticos. Quando eu usar alguma dessas ofertas no meu laboratório de cloud, ela vai ganhar um post próprio.

## Ponto-chave 6: Confira isso antes de ativar qualquer coisa

O Pack mistura quatro tipos de valor, e eles funcionam de formas diferentes:

- **Uso incluído** (core-hours do Codespaces): renova todo mês e é bloqueado quando acaba se você não tiver um método de pagamento cadastrado.
- **Créditos** (Azure, Heroku, MongoDB): um valor fixo. Quando acaba ou expira, você paga ou para.
- **Assinaturas com prazo** (Datadog, 1Password, os cursos): grátis por um período definido, depois vem o preço de renovação.
- **Benefícios enquanto verificado** (GitHub Pro, Copilot Student, Termius, Doppler): duram enquanto durar o seu status de estudante.

![Gráfico de barras horizontais intitulado "Not every benefit lasts as long as your student status" (nem todo benefício dura tanto quanto seu status de estudante), mostrando o período gratuito de ofertas selecionadas do Student Developer Pack em meses: Heroku 24 meses (crédito de US$ 13/mês), Datadog Pro 24, domínio .me da Namecheap 12, 1Password 12, Frontend Masters 6, Educative 6, DataCamp 3. Um painel lateral lista as ofertas sem data fixa de término enquanto você for estudante verificado: GitHub Pro, Copilot Student, Codespaces (180 core-hours/mês), Termius Pro, Doppler Team, New Relic e JetBrains (renovado anualmente).](offer-duration-chart.webp "Ative as ofertas curtas quando for usá-las, não no dia da verificação: um prazo de 3 meses que acaba no meio das provas não ajuda em nada")

Antes de cada ativação, confira: **prazo e data-limite para resgate, se exige cartão de crédito, limites de idade ou região** (Azure é 18+), **limites de uso** e **quanto custa depois do período gratuito**. O momento certo importa mais nas ofertas curtas. Resgate quando tiver um projeto pronto para usá-las.

## Como se inscrever

Segundo o [guia oficial de inscrição](https://docs.github.com/en/education/about-github-education/github-education-for-students/apply-to-github-education-as-a-student), você precisa ter pelo menos 13 anos, estar matriculado em um curso que conceda grau ou diploma e ter uma conta pessoal no GitHub. A matrícula é comprovada com algo como uma carteirinha de estudante com data, grade de horários, histórico escolar ou declaração de matrícula. Dependendo da sua instituição, pode ser necessário usar um e-mail acadêmico.

Comece pelas configurações de **Education benefits** da sua conta, envie a inscrição, aguarde a verificação e depois ative os benefícios que você escolheu. O GitHub não promete um prazo de análise, então não conte com um.

Foi assim que a aprovação apareceu na minha conta. Dois detalhes merecem atenção: o Copilot é resgatado numa página de cadastro própria, e os benefícios têm **data de expiração**.

![Painel Education Benefits nas configurações do GitHub mostrando "Coupon applied" com uma barra de progresso "Expires in almost 2 years" e uma caixa verde: "Verified (benefits available) on September 21, 2026, Application Type: Student. Your academic benefits, including Partner offers, are now available. You can access Student Developer Pack offers here and redeem Copilot via the Copilot sign-up page. Your benefits will expire on September 21, 2028."](education-benefits-verified.webp "Minha verificação vale por dois anos. Confira a data de expiração nas suas configurações e coloque no calendário")

## FAQ rápido

**Perco tudo quando me formar?** Os benefícios vinculados à verificação acabam quando você deixa de ser estudante, e a própria verificação tem uma data de expiração que aparece nas configurações de Education benefits (a minha vale por dois anos). As ofertas com prazo fixo que você já resgatou seguem os próprios termos, então leia cada uma.

**O Codespaces é ilimitado?** Não. São 180 core-hours por mês mais uma cota de armazenamento, e o uso é bloqueado quando você atinge o limite se não tiver um método de pagamento cadastrado.

**O Pack custa alguma coisa?** A inscrição e os benefícios em si são gratuitos. Renovações, uso excedente e qualquer coisa além do limite de um crédito, não.

## Conclusão

O Student Developer Pack é um programa com duas camadas: os benefícios do próprio GitHub (Pro, Copilot Student e 180 core-hours de Codespaces) e um grande conjunto de ofertas de parceiros para cloud, dados, observabilidade, segredos, domínios e estudo. O valor está em escolher duas ou três que combinem com seu próximo objetivo de aprendizado e ativá-las quando você estiver pronto para usá-las. Atenção às letras miúdas: core-hours não são horas, créditos acabam, e um ano grátis de domínio termina com uma fatura de renovação.

**[Explore o Student Developer Pack oficial](https://education.github.com/pack), [confira sua elegibilidade](https://docs.github.com/en/education/about-github-education/github-education-for-students/apply-to-github-education-as-a-student) e escolha os benefícios que combinam com o que você vai aprender agora.** Qual categoria ajudaria mais nos seus estudos: cloud, ferramentas de desenvolvimento ou plataformas de estudo?

## Fontes

- [GitHub Student Developer Pack](https://education.github.com/pack): ofertas de parceiros e condições
- [About GitHub Education for students](https://docs.github.com/en/education/about-github-education/github-education-for-students/about-github-education-for-students): benefícios de Copilot e Codespaces
- [Plans for GitHub Copilot](https://docs.github.com/en/copilot/get-started/plans): Copilot Student vs. outros planos

*Este post é uma visão geral independente, não uma publicação oficial do GitHub. O Claude ajudou a pesquisar os termos oficiais, estruturar o post e escrever o rascunho. O enquadramento Cloud/DevOps, as notas sobre o meu próprio uso e a revisão final são meus.*

## Onde isso se encaixa

Parte 1 de **GitHub in Practice**, uma nova série sobre como usar as ferramentas do GitHub em estudos e trabalhos reais de Cloud/DevOps.
