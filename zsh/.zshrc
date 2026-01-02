# ==============================================
# ZSH CONFIGURATION (ZINIT + GRUVBOX + ULTIMATE)
# ==============================================

# --- 1. ZINIT (PLUGIN MANAGER) ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname $ZINIT_HOME)" && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# --- 2. PLUGINS ---
# Core
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# OMZ Snippets (Bibliotecas úteis)
zinit snippet OMZL::git.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::directories.zsh

# --- 3. CONFIGURAÇÃO AVANÇADA DO FZF-TAB ---
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --color=always --style=numbers --line-range=:500 {}'
zstyle ':fzf-tab:*' switch-group ',' '.'

# --- 4. CONFIGURAÇÃO BÁSICA ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY

autoload -Uz compinit && compinit
zinit cdreplay -q

# --- 5. ALIASES (Ferramentas Modernas) ---
alias ls='eza --icons --group-directories-first'
alias ll='eza -alF --icons --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias tree='eza --tree --icons'
alias cat='bat'
alias less='bat'
alias grep='rg'
alias find='fd'
alias ps='procs'
alias top='btop'
alias help='tldr'

# Git & Rede
alias ping='gping'
alias lg='lazygit'
alias g='git'
alias diff='delta'

# Operações de Arquivo
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash'
alias clipboard='wl-copy'
alias c='clear'

# Editores
alias v='nvim'
alias nano='micro'
alias hx='helix'

# Manutenção Arch (Yay)
alias update='yay -Syu'
alias ins='yay -S'
alias rem='yay -Rns'
alias clean='yay -Sc'

# Eye Candy
alias ff='fastfetch'
alias matrix='cmatrix'
alias pipes='pipes.sh'
alias bonsai='cbonsai -l'
alias clock='tty-clock -c -C 3'
alias gitinfo='onefetch'

# The Fuck
eval "$(thefuck --alias)"

# --- 6. INICIALIZAÇÕES ---
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
alias cd='z'
eval "$(atuin init zsh)"
eval "$(direnv hook zsh)"

# --- 7. PATHS ---
export PATH=$PATH:$HOME/.npm-global/bin
export PATH="$HOME/.local/bin:$PATH"

# --- 8. STARTUP ---
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"
fastfetch

# ============================================================
# --- 9. CLAUDE API STRATEGY (CONFIGURAÇÃO CORRIGIDA) ---
# ============================================================

# Alias padrão (aponta para o econômico por segurança)
alias ai='claude-eco'

# Define a URL da Z.AI, define o Token da Z.AI e remove a chave da Anthropic para evitar conflito
alias claude-eco='export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic" && export ANTHROPIC_AUTH_TOKEN="e81d209ce9ff493daaeb6f747de0b44b.u6QnO4jSwaZGaQ6S" && unset ANTHROPIC_API_KEY && echo "🌱 Modo: GLM-4 (Z.AI)" && claude'

# ============================================================
