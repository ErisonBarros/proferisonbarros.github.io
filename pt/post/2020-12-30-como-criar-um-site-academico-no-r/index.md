---
title: "Como criar um site acadêmico no R"
author: mauricio
date: '2020-12-30'
summary: "Um guia para criar um site acadêmico no R utilizando o pacote blogdown, GitHub e Hugo"
image:
  caption: "[Imagem do Hugo Themes](https://sourcethemes.com/academic)"
  focal_point: "center"
output:
  blogdown::html_page:
    toc: true
    toc_depth: 1
categories: [r, tutorial]
tags: [r, rmarkdown, blogdown, hugo]
editor_options: 
  markdown: 
    wrap: 72
---

Que o [R](https://www.r-project.org/) possui múltiplas utilidades para análise e visualização de dados de [diversos formatos](https://cran.r-project.org/web/views/) e em [diversas áreas](https://data-flair.training/blogs/r-applications/) é indiscutível. Entretanto, a união dessa linguagem com o [Markdown](https://pt.wikipedia.org/wiki/Markdown), dando origem ao [RMarkdown](https://rmarkdown.rstudio.com/index.html), aliada ao IDE [RStudio](https://rstudio.com/products/rstudio/) ainda pode ser novidade para muitas pessoas. Essa junção permite diversas possibilidades de criação de [aplicações complementares ao R](https://bookdown.org/yihui/rmarkdown/). Pretendo escrever mais sobre essa união e utilidades num post futuro.

Neste post, vou focar nos passos para a criação de um site acadêmico no R, uma forma bem interessante que achei de desafiar meu conhecimento até então, e principalmente minha paciência...

Existem várias formas de criar um [site acadêmico](https://wowchemy.com/templates/), mas focarei aqui no formato que consegui fazer de forma mais rápida e tranquila, usando o pacote [blogdown](https://cran.r-project.org/web/packages/blogdown/index.html), hospedando no [github](https://github.com/), com esse formato: <username.github.io>, [git](https://git-scm.com/), e o [RStudio](https://rstudio.com/products/rstudio/). 

Todas as informações referentes à criação e onfiguração do site podem ser consultadas no livro do pacote [blogdown: Creating Websites with R Markdown](https://bookdown.org/yihui/blogdown/), do [Yihui Xie](https://yihui.org/). 

Outra fonte de informação são os geniais posts da [Profa. Alison Hill](https://alison.rbind.io/). Deixo eles listados em destaque aqui:

1. [Up & Running with blogdown](https://alison.rbind.io/post/2017-06-12-up-and-running-with-blogdown/)
1. [A Spoonful of Hugo: Archetypes](https://alison.rbind.io/post/2019-02-19-hugo-archetypes/)
1. [A Spoonful of Hugo: The netlify.toml File](https://alison.rbind.io/post/2019-02-19-hugo-netlify-toml/)
1. [A Spoonful of Hugo: Page Bundles](https://alison.rbind.io/post/2019-02-21-hugo-page-bundles/)
1. [A Spoonful of Hugo: Troubleshooting Your Build](https://alison.rbind.io/post/2019-03-04-hugo-troubleshooting/)
1. [A Spoonful of Hugo: How much Hugo do I need to know?](https://alison.rbind.io/post/2020-12-12-how-much-hugo/)
1. [Unbreak your blogdown site](https://alison.rbind.io/post/2020-12-27-blogdown-checks/)

Fundamental destacar que só encontrei um [post](https://diegopftrindade.netlify.app/post/blogdown-tutorial-in-portuguese/) em português do [Diego Trindade](https://diegopftrindade.netlify.app/). Nele é possível ler mais informações e também uma discussão muito legal sobro o porquê criar e manter um site acadêmico.

## Passos para criação do site

Os passos à seguir seguem essa listagem:

1. GitHub
1. RStudio
1. Git
1. blogdown
1. Edição do site

## 1. GitHub

Primeiramente é necessário criar duas contas on-line:

1. GitHub: <https://github.com/>
2. Criar um repositório no GitHub  

Com a conta do GitHub feita, será necessário [criar um
repositório](https://help.github.com/pt/github/getting-started-with-github/create-a-repo).
Eu criei com o nome de "mauriciovancine2", só de exemplo, mas pode ser
qualquer outro.

![](criar_repositorio.png)

1.  Criar um repositório no GitHub NO README + NO .gitignore (ainda!)

2.  clonar o repositório - git clone File \> New Project \> Version
    Control \> Git

3.  RStudio: install.packages("blogdown") library(blogdown)
    new_site(theme = "gcushen/hugo-academic", sample = TRUE,
    theme_example = TRUE, empty_dirs = TRUE, to_yaml = TRUE)

Conferir a versão do Hugo <https://themes.gohugo.io/academic/>

is your version less than the minimum version? hugo_version()

if yes, then do this update_hugo(force = TRUE)

4.  Netlify segure e arraste a pasta public/ para
    <https://app.netlify.com/drop>

5.  criar um arquivo "netlify.toml" file.create("netlify.toml")

Open, then copy & paste:

[build] publish = "public" command = "hugo"
[context.production.environment] HUGO_VERSION = "0.58.2" HUGO_ENV =
"production" HUGO_ENABLEGITINFO = "true"
[context.branch-deploy.environment] HUGO_VERSION = "0.58.2"
[context.deploy-preview.environment] HUGO_VERSION = "0.58.2"

6.  linkar o site com o GitHub no Netlify

## 2. RStudio


## 3. Git


## 4. Pacote blogdown


## 5. Edição do site
