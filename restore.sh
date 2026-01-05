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
    ".tmux.conf"
    ".gitconfig"
)

for file in "${FILES_TO_BACKUP[@]}"; do
    if [ -f "$HOME/$file" ]; then
        cp "$HOME/$file" "$BACKUP_DIR/"
        rm "$HOME/$file"
    fi
done

# Usar stow para cada pacote
echo "🔗 Criando links simbólicos com Stow..."

stow -R nvim
stow -R tmux
stow -R zsh
stow -R bash
stow -R git

echo ""
echo "✅ Dotfiles restaurados com sucesso!"
echo ""
echo "💡 Dicas:"
echo "   - nvim config: ~/.config/nvim"
echo "   - tmux config: ~/.tmux.conf"
echo "   - zsh config: ~/.zshrc"
echo "   - bash config: ~/.bashrc"
echo "   - git config: ~/.gitconfig"
echo ""
echo "🔄 Para atualizar dotfiles:"
echo "   cd ~/dotfiles && git add . && git commit -m 'update' && git push"
