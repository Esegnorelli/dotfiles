#!/usr/bin/env bash

# ============================================================================
# INSTALADOR DE DEPENDÊNCIAS
# ============================================================================
# Instala todas as ferramentas necessárias para o setup funcionar
# Testado em: Ubuntu 22.04+, Debian 12+, Pop!_OS 22.04+

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "\n${BLUE}=== $1 ===${NC}\n"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }

# ============================================================================
# Verificar se é Debian/Ubuntu based
# ============================================================================

if ! command -v apt &> /dev/null; then
    print_error "Este script é para sistemas baseados em Debian/Ubuntu"
    exit 1
fi

# ============================================================================
# Atualizar sistema
# ============================================================================

print_header "Atualizando sistema"
sudo apt update
print_success "Sistema atualizado"

# ============================================================================
# Ferramentas essenciais
# ============================================================================

print_header "Instalando ferramentas essenciais"

PACKAGES=(
    "curl"
    "wget"
    "git"
    "build-essential"
    "unzip"
)

for pkg in "${PACKAGES[@]}"; do
    if dpkg -l | grep -q "^ii  $pkg "; then
        print_info "$pkg já instalado"
    else
        sudo apt install -y "$pkg"
        print_success "$pkg instalado"
    fi
done

# ============================================================================
# ZSH
# ============================================================================

print_header "Instalando ZSH"

if command -v zsh &> /dev/null; then
    print_info "ZSH já instalado ($(zsh --version))"
else
    sudo apt install -y zsh
    print_success "ZSH instalado"

    # Definir como shell padrão
    print_info "Deseja definir ZSH como shell padrão? [y/N]"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        chsh -s $(which zsh)
        print_success "ZSH definido como shell padrão (requer logout)"
    fi
fi

# ============================================================================
# Kitty Terminal
# ============================================================================

print_header "Instalando Kitty"

if command -v kitty &> /dev/null; then
    print_info "Kitty já instalado ($(kitty --version))"
else
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    # Criar symlinks
    sudo ln -sf ~/.local/kitty.app/bin/kitty /usr/local/bin/
    sudo ln -sf ~/.local/kitty.app/bin/kitten /usr/local/bin/

    # Desktop entry
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

    print_success "Kitty instalado"
fi

# ============================================================================
# JetBrains Mono Nerd Font
# ============================================================================

print_header "Instalando JetBrains Mono Nerd Font"

if fc-list | grep -qi "JetBrainsMono"; then
    print_info "JetBrains Mono Nerd Font já instalada"
else
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"

    cd /tmp
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
    unzip -o JetBrainsMono.zip -d "$FONT_DIR/JetBrainsMono"
    rm JetBrainsMono.zip

    fc-cache -fv
    print_success "JetBrains Mono Nerd Font instalada"
fi

# ============================================================================
# Fastfetch (alternativa moderna ao neofetch)
# ============================================================================

print_header "Instalando Fastfetch"

if command -v fastfetch &> /dev/null; then
    print_info "Fastfetch já instalado"
else
    # Adicionar PPA ou instalar via snap
    if command -v snap &> /dev/null; then
        sudo snap install fastfetch
        print_success "Fastfetch instalado via snap"
    else
        wget https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb
        sudo dpkg -i fastfetch-linux-amd64.deb
        rm fastfetch-linux-amd64.deb
        print_success "Fastfetch instalado"
    fi
fi

# ============================================================================
# FZF (Fuzzy finder)
# ============================================================================

print_header "Instalando FZF"

if command -v fzf &> /dev/null; then
    print_info "FZF já instalado"
else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
    print_success "FZF instalado"
fi

# ============================================================================
# Ferramentas opcionais
# ============================================================================

print_header "Ferramentas opcionais"

print_info "Deseja instalar ferramentas adicionais? (ripgrep, bat, eza, zoxide) [y/N]"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    # ripgrep (melhor grep)
    if ! command -v rg &> /dev/null; then
        sudo apt install -y ripgrep
        print_success "ripgrep instalado"
    fi

    # bat (melhor cat)
    if ! command -v bat &> /dev/null; then
        sudo apt install -y bat
        # Criar alias se bat for batcat
        if command -v batcat &> /dev/null; then
            mkdir -p ~/.local/bin
            ln -sf /usr/bin/batcat ~/.local/bin/bat
        fi
        print_success "bat instalado"
    fi

    # eza (melhor ls)
    if ! command -v eza &> /dev/null; then
        sudo apt install -y gpg
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
        sudo apt update
        sudo apt install -y eza
        print_success "eza instalado"
    fi

    # zoxide (melhor cd)
    if ! command -v zoxide &> /dev/null; then
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
        print_success "zoxide instalado"
    fi
fi

# ============================================================================
# Finalização
# ============================================================================

print_header "Instalação concluída!"

print_success "Todas as dependências foram instaladas"
print_info "\nPróximos passos:"
echo "  1. Execute: cd ~/documentos/github/dotfiles"
echo "  2. Execute: ./scripts/deploy.sh --backup"
echo "  3. Reinicie o terminal ou faça logout/login"
echo ""
print_warning "IMPORTANTE: Se mudou o shell para ZSH, você precisa fazer logout e login novamente"
