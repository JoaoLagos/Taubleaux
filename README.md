 # 🎨 Taubleaux - Ferramenta de Lógica Proposicional 🎨

<p align="left">
    <img src="https://img.shields.io/badge/Status-Em%20Desenvolvimento...-orange?style=for-the-badge"/>
</p>

Bem-vindo ao repositório do projeto Taubleaux, uma implementação em Haskell de um sistema de Tableaux para a Lógica Clássica Proposicional. Este projeto é parte da avaliação da disciplina de Linguagens de Programação (2024.1) do curso de Ciência da Computação na Universidade Federal Fluminense - UFF.

<hr>

## 👩‍💻 Desenvolvedor

- JOÃO VICTOR LAGOS
- KEVIN MOREIRA

## 🖥️ Instalação

Certifique-se de ter o GHC (Glasgow Haskell Compiler) e o Cabal instalados em seu sistema. Em seguida, você pode clonar este repositório e instalar as dependências usando o Cabal:

```bash
git clone https://github.com/seu-usuario/taubleaux.git
cd taubleaux
cabal build
```

## ▶️ Uso

Você pode usar a aplicação Taubleaux para validar expressões lógicas. Basta executar o seguinte comando:

```bash
cabal run Taubleaux
```

A aplicação solicitará que você insira uma expressão lógica e informará se a expressão é válida ou não.

## ⚙️ Tecnologias Utilizadas

O projeto está sendo desenvolvido utilizando as seguintes tecnologias:

- **Linguagem de Programação [Haskell](https://www.haskell.org/):** Linguagem funcional amplamente utilizada, conhecida por sua forte tipagem estática e avaliação preguiçosa.
- **Biblioteca de Análise de Expressões:** Utilizaremos bibliotecas como [Text.Regex.TDFA](https://hackage.haskell.org/package/regex-tdfa) para lidar com expressões regulares e análise sintática de expressões lógicas.

## 📂 Estrutura do Repositório

- **`app/`:** Pasta contendo os arquivos relacionados à aplicação principal, como o Main.hs.
- **`src/`:** Pasta contendo os arquivos de pacotes, módulos, bibliotecas e entre outros.
- **`dist-newstyle/`:** Pasta contendo os artefatos de construção do projeto gerados pelo Cabal.
- **`Taubleaux.cabal`:** Arquivo de configuração do Cabal para o projeto.
- **`README.md`:** Documentação do projeto com informações sobre os objetivos, funcionalidades, tecnologias utilizadas, entre outros.


