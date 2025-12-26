# ============================================================================
# DOTFILES INTEGRATION - ZSH
# ============================================================================
# Adicione este arquivo ao seu .zshrc ou copie o conteúdo
# Source: source ~/documentos/github/dotfiles/config/zsh/dotfiles-integration.zsh

# Caminho dos dotfiles
export DOTFILES_DIR="$HOME/documentos/github/dotfiles"

# ============================================================================
# Aliases para gerenciar dotfiles
# ============================================================================

# Editar configs rapidamente
alias kittyconf='${EDITOR:-vim} $DOTFILES_DIR/config/kitty/kitty.conf'
alias zshconf='${EDITOR:-vim} ~/.zshrc'
alias nvimconf='${EDITOR:-vim} ~/.config/nvim/init.lua'

# Reload configs
alias reload-zsh='source ~/.zshrc && echo "✓ ZSH recarregado"'
alias reload-kitty='kitty @ load-config && echo "✓ Kitty recarregado"'

# Deploy dotfiles
alias dotfiles-deploy='$DOTFILES_DIR/scripts/deploy.sh'
alias dotfiles-update='cd $DOTFILES_DIR && git pull && $DOTFILES_DIR/scripts/deploy.sh --force'

# Git shortcuts para dotfiles
alias dotfiles='cd $DOTFILES_DIR'
alias dotfiles-status='cd $DOTFILES_DIR && git status'
alias dotfiles-push='cd $DOTFILES_DIR && git add . && git commit -m "chore: Update configs" && git push'

# ============================================================================
# Funções úteis
# ============================================================================

# Setup rápido do Neovim
setup-nvim() {
    if [ -f "$DOTFILES_DIR/scripts/setup-neovim.sh" ]; then
        bash "$DOTFILES_DIR/scripts/setup-neovim.sh"
    else
        echo "❌ Script não encontrado: $DOTFILES_DIR/scripts/setup-neovim.sh"
    fi
}

# Backup de dotfiles antes de fazer mudanças
dotfiles-backup() {
    local backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"

    echo "📦 Criando backup em: $backup_dir"

    [ -f ~/.zshrc ] && cp ~/.zshrc "$backup_dir/"
    [ -f ~/.bashrc ] && cp ~/.bashrc "$backup_dir/"
    [ -d ~/.config/kitty ] && cp -r ~/.config/kitty "$backup_dir/"
    [ -d ~/.config/nvim ] && cp -r ~/.config/nvim "$backup_dir/"

    echo "✓ Backup criado"
}

# Listar todos os dotfiles gerenciados
dotfiles-list() {
    echo "📁 Dotfiles gerenciados:"
    echo ""
    tree -L 2 "$DOTFILES_DIR" 2>/dev/null || ls -lah "$DOTFILES_DIR"
}

# Verificar saúde dos dotfiles
dotfiles-health() {
    echo "🏥 Verificando dotfiles..."
    echo ""

    # Verificar se dotfiles existe
    if [ -d "$DOTFILES_DIR" ]; then
        echo "✓ Diretório de dotfiles encontrado"
    else
        echo "❌ Diretório de dotfiles NÃO encontrado: $DOTFILES_DIR"
        return 1
    fi

    # Verificar symlinks do Kitty
    if [ -L ~/.config/kitty/kitty.conf ]; then
        echo "✓ kitty.conf está linkado"
    else
        echo "⚠ kitty.conf NÃO está linkado"
    fi

    # Verificar git
    if [ -d "$DOTFILES_DIR/.git" ]; then
        echo "✓ Git configurado"
        cd "$DOTFILES_DIR"
        echo "  Branch: $(git branch --show-current)"
        echo "  Commits: $(git log --oneline | wc -l)"
    else
        echo "⚠ Git NÃO inicializado"
    fi

    # Verificar ferramentas
    echo ""
    echo "🔧 Ferramentas:"
    command -v nvim &> /dev/null && echo "✓ Neovim: $(nvim --version | head -n1)" || echo "❌ Neovim não instalado"
    command -v kitty &> /dev/null && echo "✓ Kitty: $(kitty --version)" || echo "❌ Kitty não instalado"
    command -v fzf &> /dev/null && echo "✓ FZF instalado" || echo "❌ FZF não instalado"
    command -v rg &> /dev/null && echo "✓ ripgrep instalado" || echo "❌ ripgrep não instalado"
}

# Sincronizar dotfiles (pull + deploy)
dotfiles-sync() {
    echo "🔄 Sincronizando dotfiles..."
    cd "$DOTFILES_DIR"

    # Verificar se há mudanças locais
    if ! git diff-index --quiet HEAD --; then
        echo "⚠ Você tem mudanças não commitadas"
        git status --short
        echo ""
        echo "Deseja fazer commit antes de sincronizar? [y/N]"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            git add .
            echo "Digite a mensagem do commit:"
            read -r msg
            git commit -m "$msg"
        fi
    fi

    # Pull
    echo "📥 Baixando mudanças..."
    git pull

    # Deploy
    echo "🚀 Aplicando configurações..."
    bash "$DOTFILES_DIR/scripts/deploy.sh" --force

    echo "✓ Sincronização completa!"
}

# ============================================================================
# Tema e estética
# ============================================================================

# Trocar tema do Kitty facilmente
kitty-theme() {
    local themes_dir="$DOTFILES_DIR/themes"

    if [ -z "$1" ]; then
        echo "📁 Temas disponíveis:"
        ls "$themes_dir"/*.conf 2>/dev/null | xargs -n1 basename | sed 's/-kitty.conf//'
        echo ""
        echo "Uso: kitty-theme <nome>"
        echo "Exemplo: kitty-theme tokyo-night"
        return
    fi

    local theme_file="$themes_dir/$1-kitty.conf"

    if [ -f "$theme_file" ]; then
        ln -sf "$theme_file" ~/.config/kitty/theme.conf
        kitty @ load-config
        echo "✓ Tema alterado para: $1"
    else
        echo "❌ Tema não encontrado: $1"
    fi
}

# ============================================================================
# Auto-update (opcional)
# ============================================================================

# Verificar atualizações ao iniciar shell (descomente se quiser)
# if [ -d "$DOTFILES_DIR/.git" ]; then
#     cd "$DOTFILES_DIR"
#     git fetch &> /dev/null
#     if [ $(git rev-list HEAD...origin/main --count 2>/dev/null) -gt 0 ]; then
#         echo "💡 Há atualizações disponíveis nos dotfiles. Execute: dotfiles-update"
#     fi
# fi

# ============================================================================
# PATH additions (se necessário)
# ============================================================================

# Adicionar scripts dos dotfiles ao PATH
export PATH="$DOTFILES_DIR/scripts:$PATH"
