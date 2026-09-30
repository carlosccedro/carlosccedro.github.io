# Carlos Cedro: portal de materiais didáticos

Site com os slides, textos, laboratórios, podcasts e palestras das disciplinas do professor Carlos Costa Cedro. Feito com [Quarto](https://quarto.org) e publicado gratuitamente no GitHub Pages.

> Onde a teoria cria raízes na prática.

## Estrutura

```
carloscedro.github.io/
├── _quarto.yml               configuração geral do site
├── _variables.yml            usuário e repositório do GitHub (botões do Colab)
├── _identidade/              identidade visual
│   ├── tokens.scss           ÚNICO arquivo para mudar cores e fontes
│   ├── claro.scss            papéis das cores no modo claro
│   ├── escuro.scss           papéis das cores no modo escuro
│   ├── site.scss             estilos do site
│   ├── slides.scss           tema dos slides
│   ├── trilha.ejs            lista de materiais em forma de trilha
│   ├── disciplinas.ejs       cartões da página inicial
│   └── *.svg                 logotipo, símbolo, favicon e arte dos slides
├── _templates/
│   ├── disciplina/           modelo de disciplina nova
│   └── materiais/            modelos de slides, texto, laboratório, podcast e palestra
├── index.qmd                 página inicial
├── marca.qmd                 guia de marca
├── disciplinas/
│   └── inteligencia-artificial/
│       ├── index.qmd         ementa, objetivos, cronograma e listas de materiais
│       ├── slides/           um arquivo .qmd por aula (+ _metadata.yml com o tema)
│       ├── textos/
│       ├── labs/             notebooks .ipynb
│       ├── podcasts/
│       └── palestras/
├── nova-disciplina.sh        cria uma disciplina a partir do modelo
└── .github/workflows/publicar.yml   publicação automática
```

## Publicar pela primeira vez

1. Crie uma conta no GitHub (ou use a sua) e um repositório **público** chamado `SEU-USUARIO.github.io`. Com esse nome, o site fica em `https://SEU-USUARIO.github.io`.
2. Envie todos os arquivos desta pasta para o repositório. O jeito mais simples é o [GitHub Desktop](https://desktop.github.com): *File > Add local repository*, depois *Publish repository*.
3. No repositório, abra **Settings > Pages** e, em *Source*, escolha **GitHub Actions**.
4. Abra a aba **Actions** e acompanhe o workflow *Publicar portal*. Em 2 a 3 minutos o site estará no ar.

A partir daí, todo envio (push) para a branch `main` republica o site sozinho.

### Se o seu usuário do GitHub não for `carloscedro`

Troque o nome em três lugares:

- `_variables.yml`: campos `usuario` e `repositorio`
- `_quarto.yml`: linha `site-url`
- `_quarto.yml`: linha `href` do ícone do GitHub

## Visualizar no seu computador antes de publicar

1. Instale o Quarto: <https://quarto.org/docs/get-started/>
2. No terminal, dentro da pasta do projeto, rode `quarto preview`.
3. O navegador abre o site e atualiza a cada arquivo salvo.

## Adicionar um material

1. Copie o modelo correspondente de `_templates/materiais/` para a pasta da disciplina (`slides/`, `textos/`, `labs/`, `podcasts/` ou `palestras/`).
2. Renomeie seguindo o padrão `uNN-assunto`, por exemplo `u06-minimax.qmd`.
3. Preencha o cabeçalho e escreva o conteúdo.

O material aparece sozinho na trilha certa da disciplina, ordenado pela unidade. Os campos do cabeçalho são:

| Campo | Para que serve | Exemplo |
|:---|:---|:---|
| `title` | título do material | `"Teoria de jogos e Minimax"` |
| `description` | frase curta exibida na trilha | `"Como decidir quando há um adversário."` |
| `unidade` | número exibido no nó da trilha e usado na ordenação | `6` |
| `duracao` | tempo estimado | `"40 min"` |

### Slides

Escreva em Markdown: cada `##` inicia um slide. O tema, o logotipo e o rodapé vêm de `slides/_metadata.yml`, então o arquivo da aula só precisa do conteúdo. Para um slide de atividade em fundo escuro, use `## Título {.cc-escuro background-color="#1A1F4E"}`.

O link **Versão para PDF** abre os slides no formato de impressão. No Chrome ou no Edge, use *Imprimir > Salvar como PDF*, com margens "Nenhuma" e gráficos de fundo ativados.

### Laboratórios

Use notebooks `.ipynb`. A primeira célula deve ser do tipo *Raw* com o cabeçalho (veja o modelo). O botão **Abrir no Colab** é gerado automaticamente a partir de `_variables.yml` e só funciona com o repositório público.

Publique apenas a versão do estudante. Gabaritos, provas e notebooks com solução devem ficar em um **repositório privado separado**.

### Podcasts

1. No repositório, abra **Releases > Draft a new release**, crie a tag `podcasts` e anexe o arquivo `.mp3` (até 2 GB por arquivo).
2. No arquivo do episódio, ajuste o final do endereço do player para o nome do seu arquivo.
3. Mantenha a transcrição na página: ela garante acessibilidade e entra na busca do site.

Para o episódio aparecer no Spotify ou no Apple Podcasts, hospede-o também em uma plataforma de podcast e cole o player dela na página.

### Palestras

Publique o vídeo no YouTube (público ou não listado) e, no arquivo da palestra, troque o bloco `cc-video-vazio` por:

```
{{< video https://www.youtube.com/watch?v=ID_DO_VIDEO title="Título da palestra" >}}
```

## Criar uma disciplina

No Linux ou no macOS:

```bash
./nova-disciplina.sh seguranca-da-informacao "Segurança da Informação"
```

No Windows, ou se preferir fazer à mão: copie `_templates/disciplina/` para `disciplinas/nome-da-pasta/` e troque "Nome da disciplina" em `index.qmd` e em `slides/_metadata.yml`.

Depois, edite `index.qmd` (ementa, objetivos, cronograma e o campo `ordem`, que define a posição do cartão na página inicial). Enquanto a disciplina estiver em montagem, o cartão mostra "Em preparação". Apague a linha `status` quando publicar os primeiros materiais.

## Mudar cores e fontes

Edite apenas `_identidade/tokens.scss`. Site, modo escuro e slides são atualizados juntos. Ao trocar cores, confira o contraste em <https://webaim.org/resources/contrastchecker/> (mínimo de 4,5:1 para texto).

## Arquivos grandes

| Tipo | Onde hospedar |
|:---|:---|
| Áudios, PDFs extensos e datasets | Releases do próprio repositório |
| Vídeos | YouTube |
| Datasets muito grandes | Kaggle, Hugging Face ou Google Drive, com link na página |

Evite o Git LFS: o plano gratuito tem cota pequena de armazenamento e de tráfego. O GitHub Pages também limita o site publicado a 1 GB.

## Código executável

Notebooks são publicados com as saídas que estiverem salvas neles e não são executados na publicação. Se você incluir código executável em arquivos `.qmd`, renderize no seu computador antes do push e envie junto a pasta `_freeze/`, que o Quarto cria automaticamente.

## Problemas comuns

- **O site não atualizou:** veja a aba *Actions*. Um X vermelho indica erro, e o log mostra o arquivo com problema.
- **Aviso "listing ... doesn't match any files" no log:** é normal em seções ainda sem materiais.
- **Página 404 logo após publicar:** confira se *Settings > Pages > Source* está em *GitHub Actions* e aguarde alguns minutos.

## Segurança

O portal segue as correções do assessment baseado no OWASP Top 10:2025:

- **Sem scripts de terceiros:** fórmulas (KaTeX) e fontes ficam hospedadas no próprio site, em `_identidade/katex` e `_identidade/fontes`.
- **Política de segurança de conteúdo (CSP):** todas as páginas e slides trazem a política em `_identidade/seguranca.html` (o GitHub Pages não permite cabeçalhos próprios, então ela vai por meta tag). Ela só permite recursos do próprio site e vídeos do YouTube. Se incluir um serviço externo novo, libere o domínio nesse arquivo.
- **Workflow endurecido:** ações fixadas pelo hash do commit, permissões mínimas por etapa e versão fixa do Quarto. O Dependabot (`.github/dependabot.yml`) propõe atualizações toda semana.
- **Proteção contra envio acidental:** o `.gitignore` ignora arquivos com nomes como `gabarito`, `solucao`, `respostas`, `prova-1`, `notas-finais`, `frequencia` e a pasta `restrito/`. O workflow também **bloqueia a publicação** se algum desses arquivos chegar ao repositório por outro caminho, como o envio pelo navegador. Se um arquivo legítimo tiver um desses nomes (por exemplo, `prova-de-conceito`), renomeie-o.
- **Bloqueio no seu computador:** o gancho `.githooks/pre-commit` recusa commits com esses nomes antes mesmo do envio. Ative uma única vez: no GitHub Desktop, abra **Repository > Open in Command Prompt** (ou **Open in Terminal**) e rode `git config core.hooksPath .githooks`.

**Ações manuais no GitHub (uma única vez):**

1. Em **Settings > Code security**, ative **Secret scanning** e **Push protection**.
2. Na mesma tela, ative **Dependabot alerts** e **Dependabot security updates**.
3. Se houver colaboradores, em **Settings > Branches** crie uma regra para `main` exigindo revisão de pull requests.
4. Ative a verificação em duas etapas na sua conta do GitHub.

## Licenças

- Conteúdo didático: CC BY-NC-SA 4.0 (veja `LICENSE-CONTEUDO.md`)
- Código do site: MIT (veja `LICENSE`)
