# Experiment 01 — Estrutura do Projeto

## Objetivo

Compreender o que a Godot cria ao inicializar um novo projeto e identificar quais arquivos pertencem ao projeto, quais são configurações compartilhadas e quais são artefatos gerados pelo editor.

## Contexto

O projeto Godot foi criado dentro de um repositório Git já existente.

Após a criação, a estrutura inicial foi inspecionada antes de qualquer implementação de jogo.

## Observações

A Godot criou os seguintes elementos principais:

```text
godot-lab/
├── .editorconfig
├── .gitattributes
├── .gitignore
├── icon.svg
├── icon.svg.import
├── project.godot
└── .godot/
```

Também foram preservados os arquivos e diretórios que já faziam parte do repositório:

```text
README.md
docs/
```

## Descobertas

### `project.godot`

É o arquivo principal de configuração do projeto.

Nele são armazenadas informações como:

* nome do projeto;
* versão/configurações da engine;
* ícone;
* configurações de exibição;
* configurações de renderização.

As configurações definidas durante a criação do projeto foram registradas nesse arquivo.

### `icon.svg`

É o recurso visual inicial fornecido pela Godot e utilizado como ícone do projeto.

### `icon.svg.import`

Contém metadados relacionados à importação do `icon.svg`.

A Godot utiliza o arquivo original como fonte e gera recursos derivados dentro de `.godot/imported/`.

### `.godot/`

Contém dados gerados e utilizados localmente pela Godot, incluindo recursos importados, caches e informações do editor.

Esse diretório não deve ser versionado.

### `.gitignore`

A Godot criou regras específicas para evitar que determinados arquivos gerados sejam adicionados ao Git, incluindo:

```gitignore
.godot/
/android/
```

As regras específicas do Godot Lab foram posteriormente reintegradas ao arquivo.

### `.gitattributes`

Define configurações de normalização de arquivos utilizadas pelo Git, incluindo a utilização de `LF` como final de linha.

### `.editorconfig`

Fornece configurações básicas compartilhadas para ferramentas de edição, como o encoding UTF-8.

## Relação com conhecimentos anteriores

A estrutura observada apresenta um princípio semelhante ao encontrado em projetos Java com Maven ou Gradle:

```text
arquivos-fonte
      ↓
processamento
      ↓
artefatos gerados
```

Na Godot:

```text
asset original
      ↓
Import System
      ↓
recurso importado/cache
```

Assim como em projetos Java, arquivos gerados não precisam ser tratados da mesma forma que os arquivos que representam a fonte ou configuração do projeto.

Os mecanismos são diferentes, mas o princípio de separar **fonte, configuração e artefatos gerados** é semelhante.

## Conclusão

A criação de um projeto Godot não produz apenas uma cena vazia. A engine estabelece uma estrutura inicial composta por arquivos de configuração, recursos, metadados de importação e dados gerados pelo editor.

Compreender essa estrutura é importante para trabalhar corretamente com versionamento e para entender como a engine organiza um projeto.

## Resultado

**Experimento concluído.**

Foi possível identificar a função básica dos principais arquivos criados pela Godot e estabelecer uma primeira distinção entre arquivos que devem ser versionados e dados gerados localmente.

## Próximo passo

Criar a primeira `Scene` e investigar a relação entre **Scene** e **Node**.
