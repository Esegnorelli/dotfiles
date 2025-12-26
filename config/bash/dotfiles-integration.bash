# ============================================================================
# DOTFILES INTEGRATION - BASH
# ============================================================================
# Adicione ao seu .bashrc: source ~/documentos/github/dotfiles/config/bash/dotfiles-integration.bash

# Caminho dos dotfiles
export DOTFILES_DIR="$HOME/documentos/github/dotfiles"

# ============================================================================
# Aliases
# ============================================================================

alias kittyconf='${EDITOR:-vim} $DOTFILES_DIR/config/kitty/kitty.conf'
alias bashconf='${EDITOR:-vim} ~/.bashrc'
alias nvimconf='${EDITOR:-vim} ~/.config/nvim/init.lua'

alias reload-bash='source ~/.bashrc && echo "✓ Bash recarregado"'
alias reload-kitty='kitty @ load-config && echo "✓ Kitty recarregado"'

alias dotfiles='cd $DOTFILES_DIR'
alias dotfiles-deploy='$DOTFILES_DIR/scripts/deploy.sh'
alias dotfiles-update='cd $DOTFILES_DIR && git pull && $DOTFILES_DIR/scripts/deploy.sh --force'

# ============================================================================
# Funções
# ============================================================================

setup-nvim() {
    bash "$DOTFILES_DIR/scripts/setup-neovim.sh"
}

dotfiles-backup() {
    local backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"

    echo "📦 Criando backup em: $backup_dir"

    [ -f ~/.bashrc ] && cp ~/.bashrc "$backup_dir/"
    [ -d ~/.config/kitty ] && cp -r ~/.config/kitty "$backup_dir/"
    [ -d ~/.config/nvim ] && cp -r ~/.config/nvim "$backup_dir/"

    echo "✓ Backup criado"
}

dotfiles-health() {
    echo "🏥 Verificando dotfiles..."
    echo ""

    [ -d "$DOTFILES_DIR" ] && echo "✓ Diretório de dotfiles encontrado" || echo "❌ Diretório NÃO encontrado"
    [ -L ~/.config/kitty/kitty.conf ] && echo "✓ kitty.conf linkado" || echo "⚠ kitty.conf NÃO linkado"

    if [ -d "$DOTFILES_DIR/.git" ]; then
        echo "✓ Git configurado"
    else
        echo "⚠ Git NÃO inicializado"
    fi

    echo ""
    echo "🔧 Ferramentas:"
    command -v nvim &> /dev/null && echo "✓ Neovim instalado" || echo "❌ Neovim não instalado"
    command -v kitty &> /dev/null && echo "✓ Kitty instalado" || echo "❌ Kitty não instalado"
    command -v fzf &> /dev/null && echo "✓ FZF instalado" || echo "❌ FZF não instalado"
}

kitty-theme() {
    local themes_dir="$DOTFILES_DIR/themes"

    if [ -z "$1" ]; then
        echo "📁 Temas disponíveis:"
        ls "$themes_dir"/*.conf 2>/dev/null | xargs -n1 basename | sed 's/-kitty.conf//'
        echo ""
        echo "Uso: kitty-theme <nome>"
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
# PATH
# ============================================================================

export PATH="$DOTFILES_DIR/scripts:$PATH"
