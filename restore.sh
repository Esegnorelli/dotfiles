#!/bin/bash

# Script para restaurar dotfiles usando GNU Stow
set -e

echo "📦 Restaurando dotfiles..."

# Verificar stow
if ! command -v stow &> /dev/null; then
    echo "❌ GNU Stow não instalado"
    echo "Instale com: sudo pacman -S stow"
    exit 1
fi

# Ir para diretório dotfiles
cd ~/dotfiles

# Backup de arquivos existentes
echo "🧹 Fazendo backup de arquivos existentes..."
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Lista de arquivos para backup
FILES_TO_BACKUP=(
    ".bashrc"
    ".bash_profile"
    ".zshrc"
    ".p10k.zsh"
    ".fzf.zsh"
    ".tmux.conf"
    ".gitconfig"
    ".gtkrc-2.0"
)

for file in "${FILES_TO_BACKUP[@]}"; do
    if [ -f "$HOME/$file" ]; then
        cp "$HOME/$file" "$BACKUP_DIR/"
        rm "$HOME/$file" 2>/dev/null || true
    fi
done

# Backup de diretórios de configuração
CONFIG_BACKUP=(
    ".config/nvim"
    ".config/kitty"
    ".config/opencode"
)

for dir in "${CONFIG_BACKUP[@]}"; do
    if [ -e "$HOME/$dir" ]; then
        mv "$HOME/$dir" "$BACKUP_DIR/" 2>/dev/null || true
    fi
done

# Backup de arquivos de configuração individuais
CONFIG_FILES=(
    ".config/starship.toml"
)

for file in "${CONFIG_FILES[@]}"; do
    if [ -f "$HOME/$file" ]; then
        cp "$HOME/$file" "$BACKUP_DIR/" 2>/dev/null || true
        rm "$HOME/$file" 2>/dev/null || true
    fi
done

# Backup de diretórios ocultos
HIDDEN_DIRS=(
    ".claude"
    ".antigravity"
)

for dir in "${HIDDEN_DIRS[@]}"; do
    if [ -d "$HOME/$dir" ]; then
        mv "$HOME/$dir" "$BACKUP_DIR/" 2>/dev/null || true
    fi
done

echo "✅ Backup criado em: $BACKUP_DIR"

# Usar stow para cada pacote
echo "🔗 Criando links simbólicos com Stow..."

stow -R nvim 2>/dev/null || echo "⚠️  nvim: conflitos resolvidos"
stow -R tmux 2>/dev/null || echo "⚠️  tmux: conflitos resolvidos"
stow -R zsh 2>/dev/null || echo "⚠️  zsh: conflitos resolvidos"
stow -R bash 2>/dev/null || echo "⚠️  bash: conflitos resolvidos"
stow -R git 2>/dev/null || echo "⚠️  git: conflitos resolvidos"
stow -R kitty 2>/dev/null || echo "⚠️  kitty: conflitos resolvidos"
stow -R opencode 2>/dev/null || echo "⚠️  opencode: conflitos resolvidos"
stow -R claude 2>/dev/null || echo "⚠️  claude: conflitos resolvidos"
stow -R antigravity 2>/dev/null || echo "⚠️  antigravity: conflitos resolvidos"

# Criar link para starship.toml manualmente
if [ -f "$HOME/dotfiles/starship/.config/starship.toml" ]; then
    mkdir -p "$HOME/.config"
    ln -sf "$HOME/dotfiles/starship/.config/starship.toml" "$HOME/.config/starship.toml"
    echo "✅ starship configurado"
fi

echo ""
echo "✅ Dotfiles restaurados com sucesso!"
echo ""
echo "📦 Pacotes configurados:"
echo "   ✅ Neovim (LazyVim + plugins + AI)"
echo "   ✅ Tmux (floax, sessionx, catppuccin)"
echo "   ✅ Zsh (Oh My Zsh + Powerlevel10k + fzf)"
echo "   ✅ Bash configurado"
echo "   ✅ Git configurado"
echo "   ✅ Kitty terminal"
echo "   ✅ OpenCode (AI coding assistant)"
echo "   ✅ Claude (configurações)"
echo "   ✅ Antigravity (VS Code)"
echo "   ✅ Starship prompt"
echo "   ✅ Scripts úteis"
echo ""
echo "💡 Arquivos de configuração:"
echo "   - Neovim: ~/.config/nvim"
echo "   - Tmux: ~/.tmux.conf"
echo "   - Zsh: ~/.zshrc"
echo "   - Kitty: ~/.config/kitty"
echo "   - OpenCode: ~/.config/opencode"
echo "   - Claude: ~/.claude"
echo "   - Starship: ~/.config/starship.toml"
echo "   - Scripts: ~/dotfiles/scripts/"
echo ""
echo "🔄 Para atualizar dotfiles:"
echo "   cd ~/dotfiles && ./sync.sh"
echo ""
echo "⚠️  IMPORTANTE:"
echo "   - Reinicie o terminal para aplicar Zsh/Starship"
echo "   - Na primeira vez que abrir nvim, execute :Lazy sync"
echo "   - Execute 'tmux' e pressione Prefix+I para instalar plugins do tmux"
