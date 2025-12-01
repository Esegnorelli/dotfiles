# ============================================================================
# Configuração do Zsh - Pop!_OS
# Autor: esegnorelli
# ============================================================================

# Habilitar Powerlevel10k instant prompt. Deve ficar no topo do .zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# Oh My Zsh
# ============================================================================

# Caminho da instalação do Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Tema do Zsh - Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# ============================================================================
# Plugins
# ============================================================================

plugins=(
    git                      # Aliases e funções para git
    docker                   # Autocompletar para docker
    docker-compose          # Autocompletar para docker-compose
    sudo                    # Pressione ESC duas vezes para adicionar sudo
    command-not-found       # Sugere pacotes quando comando não é encontrado
    colored-man-pages       # Páginas man coloridas
    extract                 # Extrai arquivos compactados com 'extract <arquivo>'
    z                       # Jump rapidamente para diretórios frequentes
    history                 # Aliases para histórico
    zsh-autosuggestions     # Sugestões baseadas no histórico
    zsh-syntax-highlighting # Destaque de sintaxe na linha de comando
    zsh-completions         # Completações adicionais
)

# Carregar Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ============================================================================
# Configurações de Histórico
# ============================================================================

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS  # Remove duplicatas
setopt HIST_FIND_NO_DUPS     # Não mostra duplicatas na busca
setopt HIST_REDUCE_BLANKS    # Remove espaços extras
setopt SHARE_HISTORY         # Compartilha histórico entre sessões
setopt APPEND_HISTORY        # Anexa ao histórico ao invés de sobrescrever

# ============================================================================
# Variáveis de Ambiente
# ============================================================================

# Editor padrão
export EDITOR='nano'
export VISUAL='nano'

# Locale em PT-BR
export LANG=pt_BR.UTF-8
export LC_ALL=pt_BR.UTF-8

# Adicionar diretórios ao PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# ============================================================================
# NVM - Node Version Manager
# ============================================================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Carrega nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Carrega nvm bash_completion

# ============================================================================
# Pyenv - Python Version Manager
# ============================================================================

export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# ============================================================================
# FZF - Fuzzy Finder
# ============================================================================

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Configurações do FZF
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ============================================================================
# Aliases
# ============================================================================

# Navegação
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# Listagem de arquivos (usando exa se disponível)
if command -v exa &> /dev/null; then
    alias ls='exa --icons'
    alias ll='exa -lah --icons --git'
    alias la='exa -a --icons'
    alias l='exa --icons'
    alias tree='exa --tree --icons'
else
    alias ls='ls --color=auto'
    alias ll='ls -lah'
    alias la='ls -A'
    alias l='ls -CF'
fi

# Confirmação para comandos destrutivos
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

# Apt (gerenciador de pacotes)
alias atualizar='sudo apt update && sudo apt upgrade -y'
alias instalar='sudo apt install'
alias remover='sudo apt remove'
alias limpar='sudo apt autoremove && sudo apt autoclean'

# Sistema
alias limpar-memoria='sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"'
alias portas='sudo netstat -tulanp'
alias uso-disco='df -h'
alias uso-memoria='free -h'
alias processos='ps aux | grep'

# Docker
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlogs='docker logs -f'
alias dstop='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -aq)'
alias drmi='docker rmi $(docker images -q)'

# Ferramentas Modernas
if command -v bat &> /dev/null; then
    alias cat='bat --paging=never'
    alias catp='bat'  # cat com paginação
fi

if command -v fd &> /dev/null; then
    alias find='fd'
fi

if command -v rg &> /dev/null; then
    alias grep='rg'
fi

# Editor
alias vim='nvim'
alias vi='nvim'

# Utilitários
alias atualizar-dotfiles='cd ~/Documentos && git pull && ./install.sh'
alias editar-zsh='nano ~/.zshrc'
alias recarregar-zsh='source ~/.zshrc'
alias limpar-terminal='clear'
alias c='clear'
alias h='history'
alias j='jobs -l'

# IP
alias meu-ip='curl -s https://ipinfo.io/ip'
alias ip-local='hostname -I'

# ============================================================================
# Funções Personalizadas
# ============================================================================

# Criar diretório e entrar nele
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extrair arquivos compactados
extrair() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' não pode ser extraído via extrair()" ;;
        esac
    else
        echo "'$1' não é um arquivo válido!"
    fi
}

# Buscar arquivo por nome
buscar() {
    find . -type f -iname "*$1*"
}

# Buscar processo
proc() {
    ps aux | grep "$1"
}

# Tamanho de diretório
tamanho() {
    du -sh "$1"
}

# Backup rápido de arquivo
backup() {
    cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
}

# ============================================================================
# Autocompletação
# ============================================================================

# Completação case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Completação colorida
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Menu de seleção para completação
zstyle ':completion:*' menu select

# Cache de completação
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# ============================================================================
# Powerlevel10k
# ============================================================================

# Carregar configuração do Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================================================
# Mensagem de boas-vindas
# ============================================================================

# Descomente a linha abaixo para mostrar informações do sistema ao iniciar
# neofetch

echo "Bem-vindo ao Pop!_OS, $USER!"
echo "Digite 'help' para ver comandos úteis ou 'aliases' para ver todos os aliases disponíveis."

# Função helper
help() {
    echo "\n📚 Comandos Úteis:\n"
    echo "  atualizar         - Atualiza o sistema"
    echo "  instalar <pkg>    - Instala um pacote"
    echo "  limpar            - Remove pacotes desnecessários"
    echo "  meu-ip            - Mostra seu IP público"
    echo "  uso-disco         - Mostra uso do disco"
    echo "  uso-memoria       - Mostra uso da memória"
    echo "  mkcd <dir>        - Cria e entra em um diretório"
    echo "  backup <arquivo>  - Faz backup de um arquivo"
    echo "  buscar <nome>     - Busca arquivo por nome"
    echo "  extrair <arquivo> - Extrai arquivos compactados"
    echo "\nPara ver todos os aliases: aliases"
    echo "Para reconfigurar o prompt: p10k configure\n"
}

aliases() {
    echo "\n📋 Aliases Disponíveis:\n"
    alias | grep -v '^_' | column -t -s '='
}
