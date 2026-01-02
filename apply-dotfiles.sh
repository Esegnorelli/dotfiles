#!/bin/bash
# Script para aplicar dotfiles sem usar stow

set -e

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles-backup-$(date +%Y%m%d_%H%M%S)"

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}Aplicando dotfiles...${NC}"

# Criar backup se necessário
mkdir -p "$BACKUP_DIR"

# Função para criar symlink com backup
create_symlink() {
    local source="$1"
    local target="$2"

    # Criar diretório pai se não existir
    mkdir -p "$(dirname "$target")"

    # Fazer backup se arquivo/link existe
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo -e "${YELLOW}Backup: $target${NC}"
        mv "$target" "$BACKUP_DIR/"
    fi

    # Criar symlink
    ln -sf "$source" "$target"
    echo -e "${GREEN}✓ Linked: $target -> $source${NC}"
}

cd "$DOTFILES_DIR"

# ZSH
if [ -f "zsh/.zshrc" ]; then
    create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
fi

# Starship
mkdir -p "$HOME/.config"
for theme in starship/.config/starship-*.toml; do
    if [ -f "$theme" ]; then
        create_symlink "$DOTFILES_DIR/$theme" "$HOME/.config/$(basename $theme)"
    fi
done
# Link tema padrão
if [ -f "starship/.config/starship-base-gruvbox.toml" ]; then
    create_symlink "$DOTFILES_DIR/starship/.config/starship-base-gruvbox.toml" "$HOME/.config/starship.toml"
fi

# Kitty
if [ -d "kitty/.config/kitty" ]; then
    mkdir -p "$HOME/.config/kitty"
    for file in kitty/.config/kitty/*; do
        if [ -f "$file" ]; then
            create_symlink "$DOTFILES_DIR/$file" "$HOME/.config/kitty/$(basename $file)"
        fi
    done
fi

# Nvim
if [ -d "nvim/.config/nvim" ]; then
    if [ -e "$HOME/.config/nvim" ] || [ -L "$HOME/.config/nvim" ]; then
        echo -e "${YELLOW}Backup: $HOME/.config/nvim${NC}"
        mv "$HOME/.config/nvim" "$BACKUP_DIR/"
    fi
    create_symlink "$DOTFILES_DIR/nvim/.config/nvim" "$HOME/.config/nvim"
fi

# Atuin
if [ -d "atuin/.config/atuin" ]; then
    mkdir -p "$HOME/.config/atuin"
    for file in atuin/.config/atuin/*; do
        if [ -f "$file" ]; then
            create_symlink "$DOTFILES_DIR/$file" "$HOME/.config/atuin/$(basename $file)"
        fi
    done
fi

# Fastfetch
if [ -d "fastfetch/.config/fastfetch" ]; then
    if [ -e "$HOME/.config/fastfetch" ] || [ -L "$HOME/.config/fastfetch" ]; then
        echo -e "${YELLOW}Backup: $HOME/.config/fastfetch${NC}"
        mv "$HOME/.config/fastfetch" "$BACKUP_DIR/"
    fi
    create_symlink "$DOTFILES_DIR/fastfetch/.config/fastfetch" "$HOME/.config/fastfetch"
fi

# Micro
if [ -d "micro/.config/micro" ]; then
    if [ -e "$HOME/.config/micro" ] || [ -L "$HOME/.config/micro" ]; then
        echo -e "${YELLOW}Backup: $HOME/.config/micro${NC}"
        mv "$HOME/.config/micro" "$BACKUP_DIR/"
    fi
    create_symlink "$DOTFILES_DIR/micro/.config/micro" "$HOME/.config/micro"
fi

# TheFuck
if [ -d "thefuck/.config/thefuck" ]; then
    if [ -e "$HOME/.config/thefuck" ] || [ -L "$HOME/.config/thefuck" ]; then
        echo -e "${YELLOW}Backup: $HOME/.config/thefuck${NC}"
        mv "$HOME/.config/thefuck" "$BACKUP_DIR/"
    fi
    create_symlink "$DOTFILES_DIR/thefuck/.config/thefuck" "$HOME/.config/thefuck"
fi

# Claude
if [ -d "claude/.config/claude" ]; then
    if [ -e "$HOME/.config/claude" ] || [ -L "$HOME/.config/claude" ]; then
        echo -e "${YELLOW}Backup: $HOME/.config/claude${NC}"
        mv "$HOME/.config/claude" "$BACKUP_DIR/"
    fi
    create_symlink "$DOTFILES_DIR/claude/.config/claude" "$HOME/.config/claude"
fi

# Hyprland
if [ -d "hyprland/.config/hypr" ]; then
    if [ -e "$HOME/.config/hypr" ] || [ -L "$HOME/.config/hypr" ]; then
        echo -e "${YELLOW}Backup: $HOME/.config/hypr${NC}"
        mv "$HOME/.config/hypr" "$BACKUP_DIR/"
    fi
    create_symlink "$DOTFILES_DIR/hyprland/.config/hypr" "$HOME/.config/hypr"
fi

echo -e "${GREEN}Dotfiles aplicados com sucesso!${NC}"
echo -e "${BLUE}Backup criado em: $BACKUP_DIR${NC}"
echo -e "${YELLOW}Faça logout e login para aplicar todas as mudanças${NC}"
