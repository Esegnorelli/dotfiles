# 📖 Exemplos de Uso

Este arquivo contém exemplos práticos de como usar os aliases, funções e recursos dos dotfiles.

## 🎯 Navegação Rápida

### Navegando entre diretórios

```bash
# Voltar um diretório
..

# Voltar dois diretórios
...

# Voltar três diretórios
....

# Ir para o diretório home
~

# Criar diretório e entrar nele
mkcd meu-projeto
# É o mesmo que: mkdir meu-projeto && cd meu-projeto
```

### Plugin Z - Jump rápido

O plugin `z` aprende os diretórios que você mais acessa:

```bash
# Depois de visitar /var/www/meu-site algumas vezes
z meu-site  # Vai direto para /var/www/meu-site

# Funciona com partes do caminho
z www  # Pode ir para /var/www
```

## 📁 Gerenciamento de Arquivos

### Listagem

```bash
# Listagem simples
ls

# Listagem detalhada com arquivos ocultos
ll

# Mostrar apenas arquivos ocultos
la

# Listagem compacta
l
```

### Busca de arquivos

```bash
# Buscar arquivo por nome (recursivo)
buscar "config.json"

# Resultado exemplo:
# ./projeto/config.json
# ./backup/config.json

# Buscar arquivo começando com específico padrão
buscar "*.sh"
```

### Backup de arquivos

```bash
# Criar backup de um arquivo
backup importante.txt

# Cria: importante.txt.backup.20231130_153045
```

### Extrair arquivos compactados

```bash
# A função 'extrair' detecta automaticamente o formato
extrair arquivo.zip
extrair arquivo.tar.gz
extrair arquivo.rar
extrair arquivo.7z

# Ou use o alias do plugin 'extract'
x arquivo.zip
```

## 🔧 Git - Controle de Versão

### Status e informações

```bash
# Ver status
gs
# Equivale a: git status

# Ver diferenças
gd
# Equivale a: git diff

# Ver log bonito com gráfico
gl
# Equivale a: git log --oneline --graph --decorate

# Ver branches
gb
# Equivale a: git branch
```

### Commits e push

```bash
# Adicionar arquivos
ga arquivo.txt
# Ou adicionar todos
ga .

# Fazer commit
gc -m "Mensagem do commit"
# Equivale a: git commit -m "Mensagem do commit"

# Push para o repositório
gp
# Equivale a: git push

# Checkout de branch
gco develop
# Equivale a: git checkout develop
```

### Workflow completo

```bash
# 1. Ver o que mudou
gs

# 2. Adicionar arquivos
ga .

# 3. Fazer commit
gc -m "feat: adiciona nova funcionalidade"

# 4. Enviar para o repositório
gp

# Tudo em uma linha (com &&)
ga . && gc -m "fix: corrige bug" && gp
```

## 🐳 Docker

### Gerenciamento de containers

```bash
# Listar containers em execução
dps

# Listar todos os containers (incluindo parados)
dpsa

# Ver imagens
di

# Entrar em um container
dex nome-do-container bash
# Exemplo: dex mysql bash

# Ver logs de um container
dlogs nome-do-container
```

### Limpeza

```bash
# Parar todos os containers
dstop

# Remover todos os containers parados
drm

# Remover todas as imagens não utilizadas
drmi

# CUIDADO: Isso remove TUDO!
```

## 💻 Sistema e Manutenção

### Gerenciamento de pacotes

```bash
# Atualizar sistema
atualizar
# Equivale a: sudo apt update && sudo apt upgrade -y

# Instalar pacote
instalar vim
# Equivale a: sudo apt install vim

# Remover pacote
remover vim
# Equivale a: sudo apt remove vim

# Limpar pacotes desnecessários
limpar
# Equivale a: sudo apt autoremove && sudo apt autoclean
```

### Monitoramento

```bash
# Ver uso de disco
uso-disco
# Resultado exemplo:
# Filesystem      Size  Used Avail Use% Mounted on
# /dev/sda1       100G   45G   50G  48% /

# Ver uso de memória
uso-memoria
# Resultado exemplo:
#               total        used        free      shared
# Mem:           16Gi       8.2Gi       4.1Gi       1.2Gi

# Ver processos específicos
processos chrome
# Ou use a função:
proc chrome

# Ver portas em uso
portas
# Equivale a: sudo netstat -tulanp
```

### Informações de rede

```bash
# Ver seu IP público
meu-ip
# Resultado exemplo: 203.0.113.45

# Ver IP local
ip-local
# Resultado exemplo: 192.168.1.100
```

## 🐍 Python - Ambientes Virtuais

### Com virtualenv

```bash
# Criar ambiente virtual
python3 -m venv venv

# Ativar (o ícone 🐍 aparecerá no prompt)
source venv/bin/activate

# Desativar
deactivate
```

### Com Anaconda

```bash
# Criar ambiente
conda create -n meu-env python=3.9

# Ativar (o ícone 🅒 aparecerá no prompt)
conda activate meu-env

# Desativar
conda deactivate
```

## ⌨️ Atalhos do Terminal

### Comandos úteis do Zsh

```bash
# Pressione ESC duas vezes para adicionar 'sudo'
apt update  # Digite isso
# Pressione ESC ESC
# Resultado: sudo apt update

# Busca no histórico
# Digite Ctrl+R e comece a digitar
# Exemplo: Ctrl+R depois "git"
# Mostrará comandos git anteriores
```

### Autocomplete inteligente

```bash
# Digite parte do comando e pressione TAB
git ch<TAB>
# Completa para: git checkout

# Com múltiplas opções, mostra menu
git co<TAB>
# Mostra: commit, config, checkout, etc.

# Case-insensitive
GiT StA<TAB>
# Completa para: git status
```

## 📊 Prompt - Informações Exibidas

### O que significa cada ícone?

```
  ~/projeto (main ✘) ⚙ 2 🐍 venv
❯
```

Explicação:
- `` - Ícone do Pop!_OS
- `~/projeto` - Diretório atual
- `(main ✘)` - Branch Git com modificações não salvas
- `⚙ 2` - 2 jobs em background
- `🐍 venv` - Python virtualenv ativo
- `❯` - Prompt (verde se último comando OK, vermelho se erro)

### Estados do Git

```
(main)      # Branch limpo, sem modificações
(main !)    # Arquivos modificados não staged
(main +)    # Arquivos staged
(main ?)    # Arquivos não rastreados
(main ⇡)    # Commits à frente do remote
(main ⇣)    # Commits atrás do remote
(main *)    # Há mudanças no stash
```

## 🎨 Personalização Rápida

### Adicionar seus próprios aliases

Edite o arquivo `~/.zshrc` e adicione:

```bash
# Seus aliases personalizados
alias meu-alias='comando'
alias att='atualizar && limpar'
alias dev='cd ~/Desenvolvimento'
```

Depois recarregue:
```bash
recarregar-zsh
```

### Adicionar funções personalizadas

```bash
# Função para criar projeto Node.js
criar-node() {
    mkcd $1
    npm init -y
    echo "node_modules/" > .gitignore
    git init
}

# Uso:
criar-node meu-projeto
```

## 🔍 Comandos de Ajuda

```bash
# Ver comandos úteis
help

# Ver todos os aliases disponíveis
aliases

# Reconfigurar o prompt
p10k configure

# Ver manual de um comando
man ls

# Ver ajuda rápida de um comando
ls --help
```

## 💡 Dicas e Truques

### 1. Histórico compartilhado

Todos os terminais compartilham o mesmo histórico. Comando executado em um terminal fica disponível em todos.

### 2. Sugestões automáticas

Digite o início de um comando que você já usou antes. A sugestão aparece em cinza. Pressione `→` (seta direita) para aceitar.

```bash
git pus  # Aparece sugestão: git push origin main
# Pressione → para aceitar
```

### 3. Plugin Z - Atalhos

```bash
# Depois de usar bastante, você pode fazer:
z doc  # Vai para ~/Documentos
z dow  # Vai para ~/Downloads
z pro  # Vai para ~/Projetos
```

### 4. Correção automática

O Zsh sugere correções quando você erra um comando:

```bash
gti status
# Zsh pergunta: "Você quis dizer 'git'?"
```

### 5. Glob avançado

```bash
# Listar apenas arquivos .js
ls **/*.js

# Listar arquivos modificados hoje
ls -l *(.m0)

# Listar apenas diretórios
ls -d */
```

## 🚀 Workflow de Desenvolvimento

### Exemplo: Iniciando novo projeto

```bash
# 1. Criar e entrar no diretório
mkcd ~/Projetos/novo-projeto

# 2. Inicializar Git
git init

# 3. Criar arquivo README
echo "# Novo Projeto" > README.md

# 4. Primeiro commit
ga . && gc -m "chore: commit inicial"

# 5. Ver status
gs
```

### Exemplo: Atualizando sistema antes de trabalhar

```bash
# Atualizar tudo de uma vez
atualizar && limpar

# Ver uso de recursos
uso-disco && uso-memoria
```

## 📝 Notas Finais

- Use `TAB` frequentemente para autocompletar
- Use `Ctrl+R` para buscar no histórico
- Use `Ctrl+L` para limpar a tela (ou digite `c`)
- Explore os plugins disponíveis no Oh My Zsh
- Personalize conforme sua necessidade

---

**Divirta-se explorando seu novo terminal! 🎉**
