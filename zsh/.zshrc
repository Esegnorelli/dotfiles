# ==============================================
# ZSH CONFIGURATION (ZINIT + GRUVBOX + ULTIMATE)
# ==============================================

# --- 1. ZINIT (PLUGIN MANAGER) ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname $ZINIT_HOME)" &&     git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
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
# (Isso cria o preview lateral quando você aperta TAB)
# Desativa ordenação para git checkout
zstyle ':completion:*:git-checkout:*' sort false
# Formato das descrições
zstyle ':completion:*:descriptions' format '[%d]'
# Preview de diretórios com Eza ao dar cd [tab]
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# Preview de arquivos com Bat ao dar cat/vim [tab]
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

# Autocomplete Init
autoload -Uz compinit && compinit
zinit cdreplay -q

# --- 5. ALIASES (A Parte Divertida) ---

# Substitutos Modernos (Rust Tools)
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

# Operações de Arquivo Seguras
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash' # Envia para lixeira
alias clipboard='wl-copy'
alias c='clear'

# Editores
alias v='nvim'
alias nano='micro'
alias hx='helix'

# Pacman & Yay (Manutenção)
alias update='yay -Syu'              # Atualiza tudo
alias ins='yay -S'                   # Instala pacote
alias rem='yay -Rns'                 # Remove pacote e dependências
alias clean='yay -Sc'                # Limpa cache

# Eye Candy & Fun (Seus novos brinquedos)
alias ff='fastfetch'
alias matrix='cmatrix'
alias pipes='pipes.sh'
alias bonsai='cbonsai -l'
alias clock='tty-clock -c -C 3'      # Relógio cor 3 (Verde/Amarelo)
alias gitinfo='onefetch'

# AI
alias ai='claude'

# The Fuck (Correção automática com ESC ESC)
eval "$(thefuck --alias)"

# --- 6. INICIALIZAÇÕES ---
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
alias cd='z' # Zoxide substitui o cd padrão
eval "$(atuin init zsh)"
eval "$(direnv hook zsh)"

# --- 7. PATHS ---
export PATH=$PATH:$HOME/.npm-global/bin

# --- 8. STARTUP ---
# Inicia o Starship
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# Roda o Fastfetch ao abrir o terminal (Boas vindas)
fastfetch
export PATH="$HOME/.local/bin:$PATH"

# ============================================================
# --- 9. CLAUDE API PROVIDERS ---
# Troque facilmente entre GLM e Claude oficial

# GLM (Zhipu AI) - GLM Coding Lite com GLM-4.7
alias use-glm='~/.claude/use-glm.sh'
alias use-claude='~/.claude/use-claude.sh'

# Configuração atual: GLM API
export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/paas/v4"
export ANTHROPIC_API_KEY="d86b6e08aa434387a9c9393e816c74bd.gguR0XjQxXo5w2V8"

# ============================================================
