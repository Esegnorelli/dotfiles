#!/usr/bin/env bash

# ============================================================================
# POP!_OS OPTIMIZATION SCRIPT
# ============================================================================
# Configurações e melhorias para Pop!_OS 22.04
# Instala ferramentas modernas e otimiza o sistema

set -e

RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'
BLUE='\e[34m'
CYAN='\e[36m'
MAGENTA='\e[35m'

print_header() { echo -e "\n${MAGENTA}╔══════════════════════════════════════════════════╗${RC}"; echo -e "${MAGENTA}║${RC} ${BLUE}$1${RC}"; echo -e "${MAGENTA}╚══════════════════════════════════════════════════╝${RC}\n"; }
print_success() { echo -e "${GREEN}✓${RC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${RC} $1"; }
print_error() { echo -e "${RED}✗${RC} $1"; }
print_info() { echo -e "${CYAN}➜${RC} $1"; }

# Verificar se está rodando com sudo
if [ "$EUID" -ne 0 ]; then
    print_error "Este script precisa rodar com sudo"
    echo "Execute: sudo $0"
    exit 1
fi

REAL_USER="${SUDO_USER:-$USER}"
REAL_HOME=$(eval echo ~$REAL_USER)

print_header "🚀 Otimização do Pop!_OS"
print_info "Usuário: $REAL_USER"
print_info "Home: $REAL_HOME"

# ============================================================================
# 1. ATUALIZAR SISTEMA
# ============================================================================

print_header "📦 Atualizando sistema"
apt update
apt upgrade -y
apt autoremove -y
print_success "Sistema atualizado"

# ============================================================================
# 2. FERRAMENTAS MODERNAS CLI
# ============================================================================

print_header "🛠️  Instalando ferramentas modernas"

# Bat - cat com syntax highlighting
if ! command -v bat &> /dev/null; then
    print_info "Instalando bat..."
    apt install -y bat
    # Criar alias se bat está como batcat
    if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
        ln -sf $(which batcat) /usr/local/bin/bat
        print_success "bat instalado (link criado)"
    fi
else
    print_success "bat já instalado"
fi

# Eza - ls moderno
if ! command -v eza &> /dev/null; then
    print_info "Instalando eza..."
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | tee /etc/apt/sources.list.d/gierens.list
    chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    apt update
    apt install -y eza
    print_success "eza instalado"
else
    print_success "eza já instalado"
fi

# Zoxide - cd inteligente
if ! command -v zoxide &> /dev/null; then
    print_info "Instalando zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    mv ~/.local/bin/zoxide /usr/local/bin/
    print_success "zoxide instalado"
else
    print_success "zoxide já instalado"
fi

# Starship - prompt moderno
if ! command -v starship &> /dev/null; then
    print_info "Instalando starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    print_success "starship instalado"
else
    print_success "starship já instalado"
fi

# Outras ferramentas úteis
print_info "Instalando ferramentas adicionais..."
apt install -y \
    htop \
    ncdu \
    tldr \
    jq \
    tree \
    curl \
    wget \
    stow \
    tmux \
    ripgrep \
    fd-find \
    fzf \
    silversearcher-ag \
    git-delta \
    2>/dev/null || true

print_success "Ferramentas modernas instaladas"

# ============================================================================
# 3. CONFIGURAR GIT
# ============================================================================

print_header "⚙️  Configurando Git"

# Configurar delta como pager
sudo -u $REAL_USER git config --global core.pager "delta"
sudo -u $REAL_USER git config --global interactive.diffFilter "delta --color-only"
sudo -u $REAL_USER git config --global delta.navigate true
sudo -u $REAL_USER git config --global delta.side-by-side true
sudo -u $REAL_USER git config --global merge.conflictstyle "diff3"
sudo -u $REAL_USER git config --global diff.colorMoved "default"

# Aliases úteis
sudo -u $REAL_USER git config --global alias.st "status -sb"
sudo -u $REAL_USER git config --global alias.co "checkout"
sudo -u $REAL_USER git config --global alias.br "branch"
sudo -u $REAL_USER git config --global alias.ci "commit"
sudo -u $REAL_USER git config --global alias.last "log -1 HEAD"
sudo -u $REAL_USER git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

print_success "Git configurado com delta e aliases"

# ============================================================================
# 4. CRIAR ALIASES PARA SHELL
# ============================================================================

print_header "🎯 Configurando aliases úteis"

ALIASES_FILE="$REAL_HOME/.bash_aliases"

cat > "$ALIASES_FILE" << 'EOF'
# ============================================================================
# ALIASES - Atalhos úteis para o terminal
# ============================================================================

# Navegação
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Ls moderno com eza
if command -v eza &> /dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -lh --icons --group-directories-first'
    alias la='eza -lah --icons --group-directories-first'
    alias lt='eza --tree --level=2 --icons'
    alias lta='eza --tree --level=2 --icons -a'
else
    alias ll='ls -lh'
    alias la='ls -lah'
fi

# Cat moderno com bat
if command -v bat &> /dev/null; then
    alias cat='bat --paging=never'
    alias ccat='/usr/bin/cat'  # cat original
fi

# Grep com cores
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git aliases
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'

# Sistema
alias update='sudo apt update && sudo apt upgrade -y'
alias cleanup='sudo apt autoremove -y && sudo apt autoclean'
alias ports='netstat -tulanp'

# Utilitários
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'

# Edição
alias v='nvim'
alias vim='nvim'
alias e='nvim'

# Desenvolvimento
alias py='python3'
alias pip='pip3'
alias serve='python3 -m http.server'

# Docker (se instalado)
if command -v docker &> /dev/null; then
    alias d='docker'
    alias dc='docker-compose'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    alias drm='docker rm'
    alias drmi='docker rmi'
fi

# Kubernetes (se instalado)
if command -v kubectl &> /dev/null; then
    alias k='kubectl'
    alias kgp='kubectl get pods'
    alias kgs='kubectl get services'
    alias kgd='kubectl get deployments'
fi

# Funções úteis
mkcd() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' não pode ser extraído via extract()" ;;
        esac
    else
        echo "'$1' não é um arquivo válido!"
    fi
}
EOF

chown $REAL_USER:$REAL_USER "$ALIASES_FILE"
print_success "Aliases criados em: $ALIASES_FILE"

# ============================================================================
# 5. CONFIGURAR STARSHIP (PROMPT MODERNO)
# ============================================================================

print_header "✨ Configurando Starship"

STARSHIP_CONFIG="$REAL_HOME/.config/starship.toml"
mkdir -p "$REAL_HOME/.config"

cat > "$STARSHIP_CONFIG" << 'EOF'
# ============================================================================
# STARSHIP PROMPT - Configuração moderna
# ============================================================================

format = """
[┌─](bold blue)$username$hostname$directory$git_branch$git_status$nodejs$python$rust$golang
[└─>](bold blue) """

add_newline = true

[username]
style_user = "bold cyan"
style_root = "bold red"
format = "[$user]($style) "
disabled = false
show_always = true

[hostname]
ssh_only = false
format = "[@$hostname](bold green) "
disabled = false

[directory]
truncation_length = 3
truncate_to_repo = true
format = "[$path]($style) "
style = "bold yellow"

[git_branch]
symbol = " "
format = "[$symbol$branch]($style) "
style = "bold purple"

[git_status]
format = '([\[$all_status$ahead_behind\]]($style) )'
style = "bold red"

[nodejs]
symbol = " "
format = "[$symbol($version )]($style)"
style = "bold green"

[python]
symbol = " "
format = "[$symbol$pyenv_prefix($version )]($style)"
style = "bold yellow"

[rust]
symbol = " "
format = "[$symbol($version )]($style)"
style = "bold red"

[golang]
symbol = " "
format = "[$symbol($version )]($style)"
style = "bold cyan"

[cmd_duration]
min_time = 500
format = "[$duration](bold yellow)"

[time]
disabled = false
format = '[$time]($style) '
style = "bold white"
EOF

chown -R $REAL_USER:$REAL_USER "$REAL_HOME/.config"
print_success "Starship configurado"

# Adicionar ao .bashrc se não estiver
if ! grep -q "starship init bash" "$REAL_HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(starship init bash)"' >> "$REAL_HOME/.bashrc"
    print_info "Starship adicionado ao .bashrc"
fi

# Adicionar zoxide ao .bashrc
if ! grep -q "zoxide init bash" "$REAL_HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(zoxide init bash)"' >> "$REAL_HOME/.bashrc"
    print_info "Zoxide adicionado ao .bashrc"
fi

# ============================================================================
# 6. OTIMIZAÇÕES DO SISTEMA
# ============================================================================

print_header "⚡ Aplicando otimizações"

# Melhorar I/O para SSDs
if grep -q "deadline" /sys/block/*/queue/scheduler 2>/dev/null; then
    print_info "Sistema com SSD detectado - otimizando I/O scheduler"
    echo "mq-deadline" > /sys/block/sda/queue/scheduler 2>/dev/null || true
fi

# Reduzir swappiness (melhor para SSDs)
sysctl vm.swappiness=10 2>/dev/null || true
if ! grep -q "vm.swappiness" /etc/sysctl.conf 2>/dev/null; then
    echo "vm.swappiness=10" >> /etc/sysctl.conf
    print_success "Swappiness reduzido para 10"
fi

# Aumentar file watchers (útil para desenvolvimento)
sysctl fs.inotify.max_user_watches=524288 2>/dev/null || true
if ! grep -q "fs.inotify.max_user_watches" /etc/sysctl.conf 2>/dev/null; then
    echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf
    print_success "File watchers aumentados"
fi

print_success "Otimizações aplicadas"

# ============================================================================
# 7. LIMPEZA FINAL
# ============================================================================

print_header "🧹 Limpeza final"

apt autoremove -y
apt autoclean -y
journalctl --vacuum-time=3d 2>/dev/null || true

print_success "Limpeza concluída"

# ============================================================================
# RESUMO FINAL
# ============================================================================

print_header "✅ Otimização concluída!"

echo ""
print_success "Ferramentas instaladas:"
echo "  • bat       - Cat moderno com syntax highlighting"
echo "  • eza       - Ls moderno com ícones"
echo "  • zoxide    - CD inteligente (lembra seus diretórios)"
echo "  • starship  - Prompt moderno e bonito"
echo "  • delta     - Git diff melhorado"
echo "  • htop      - Monitor de processos"
echo "  • ncdu      - Analisador de espaço em disco"
echo "  • tldr      - Man pages simplificadas"
echo "  • jq        - JSON processor"
echo "  • stow      - Gerenciador de symlinks para dotfiles"

echo ""
print_success "Configurações aplicadas:"
echo "  • Git configurado com delta"
echo "  • Aliases úteis em ~/.bash_aliases"
echo "  • Starship configurado em ~/.config/starship.toml"
echo "  • Swappiness otimizado para 10"
echo "  • File watchers aumentados"

echo ""
print_info "Próximos passos:"
echo "  1. Feche e abra o terminal (ou execute: source ~/.bashrc)"
echo "  2. Experimente os novos comandos:"
echo "     ${GREEN}ll${RC}       - Listar arquivos com ícones"
echo "     ${GREEN}cat${RC}      - Ver arquivos com syntax highlighting"
echo "     ${GREEN}z <dir>${RC}  - Navegar rapidamente (após usar cd algumas vezes)"
echo "     ${GREEN}gs${RC}       - Git status simplificado"
echo "  3. Configure seu Git:"
echo "     ${YELLOW}git config --global user.name \"Seu Nome\"${RC}"
echo "     ${YELLOW}git config --global user.email \"seu@email.com\"${RC}"

echo ""
print_warning "Reinicie o terminal para aplicar todas as mudanças!"
echo ""
