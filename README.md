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
git clone https://github.com/JoaoLagos/taubleaux.git
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

<hr>

## Roteiro de Execução

### 1 - Instalando o GHCup (vem o framework cabal junto)
```bash
Set-ExecutionPolicy Bypass -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; try { Invoke-Command -ScriptBlock ([ScriptBlock]::Create((Invoke-WebRequest https://www.haskell.org/ghcup/sh/bootstrap-haskell.ps1 -UseBasicParsing))) -ArgumentList $true } catch { Write-Error $_ }
```

Basta seguir as etapas de instalação no próprio CMD.

#### 1.1. Verifique se o cabal foi corretamente instalado
```bash
cabal --version
```

Caso contrário, instale o mesmo com: `ghcup install cabal`. Depois verifique se foi instalado com o comando acima (`cabal --version`).

### 2 - Baixe esse repositório e Entre no projeto
Baixe esse repositório e coloque no caminho que desejar. Em seguida, use o CMD para entrar dentro desse diretório com o comando abaixo:

```bash
cd caminho/para/seu/projeto
```

_O caminho irá variar dependendo de onde você colocou o diretório raiz do projeto._<br><br>

OU<br><br>

```bash
git clone https://github.com/JoaoLagos/taubleaux.git
cd taubleaux
```

### 3 - Atualize o índice de pacotes do Cabal
```bash
cabal update
```

### 5 - Compile o projeto
```bash
cabal build
```

### 6 - Execute o projeto
```bash
cabal run
```

## OBS:
A entrada dos dados deve ser SEM ESPAÇOS e toda variável atômica deve ser englobada por (), bem como toda subfórmula esquerda e direita.<br>
EXEMPLO: `(((a)E(b))->(b))OU((c)->(d))`

<hr>

### Caso deseje rodar os arquivos de exemplo, basta fazer:
```bash
make run-example1.txt
make run-example2.txt
make run-example3.txt
make run-example4.txt
make run-example5.txt # Exemplo fornecido
make run-example6.txt # Exemplo fornecido
make run-example7.txt # Exemplo fornecido
```
_Para isso, precisa-se instalar o make._
