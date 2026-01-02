#!/bin/bash
# ==========================================
# 🔧 Arch Linux Dotfiles Auto-Installer
# ==========================================
# Autor: Seu Nome
# Descrição: Script automatizado para replicar ambiente Arch Linux
# Uso: ./install.sh
#

set -e  # Para em caso de erro

# ==========================================
# 🎨 CONFIGURAÇÕES
# ==========================================

DOTFILES_REPO="https://github.com/seu-usuario/dotfiles.git"  # 🔧 ALTERE ISSO
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles-backup-$(date +%Y%m%d_%H%M%S)"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ==========================================
# 📦 FUNÇÕES AUXILIARES
# ==========================================

print_header() {
    echo -e "${BLUE}============================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}============================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

check_command() {
    if command -v "$1" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# ==========================================
# 🔍 PRÉ-CHECKS
# ==========================================

print_header "🔍 Verificações Iniciais"

# Verifica se está rodando como root
if [ "$EUID" -eq 0 ]; then
    print_error "Não rode este script como root!"
    print_info "Execute como usuário normal para configurar seu HOME"
    exit 1
fi

# Verifica se está no Arch Linux
if [ ! -f /etc/arch-release ]; then
    print_error "Este script é destinado apenas para Arch Linux!"
    exit 1
fi

print_success "Sistema Arch Linux detectado"
print_info "Usuário: $USER"
print_info "Home: $HOME"

# ==========================================
# 🚀 INSTALAÇÃO DO YAY (AUR Helper)
# ==========================================

print_header "📦 Instalando Yay (AUR Helper)"

if check_command yay; then
    print_success "Yay já está instalado"
else
    print_info "Instalando Yay..."

    # Instala dependências
    sudo pacman -S --needed --noconfirm base-devel git

    # Clona e compila o yay
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm

    # Limpeza
    cd /
    rm -rf /tmp/yay

    print_success "Yay instalado com sucesso"
fi

# ==========================================
# 📦 INSTALAÇÃO DE PACOTES OFICIAIS
# ==========================================

print_header "📦 Instalando Pacotes Oficiais (Pacman)"

print_info "Atualizando banco de dados de pacotes..."
sudo pacman -Sy

# Lista de pacotes oficiais
PACMAN_PACKAGES=(
    # Shell & Plugin Manager
    zsh
    git
    curl

    # Ferramentas Modernas de CLI
    eza
    bat
    ripgrep
    fd
    procs
    btop
    tldr
    gping
    lazygit
    git-delta
    trash-cli
    wl-clipboard
    neovim
    micro
    helix

    # Fzf e Zoxide
    fzf
    zoxide

    # Histórico e Ambiente
    atuin
    direnv

    # Prompt
    starship

    # "Eye Candy"
    fastfetch
    cmatrix
    pipes.sh
    cbonsai
    tty-clock
    onefetch

    # Correção de Comandos
    thefuck

    # Terminal Emulator
    kitty
)

print_info "Instalando ${#PACMAN_PACKAGES[@]} pacotes..."

for package in "${PACMAN_PACKAGES[@]}"; do
    if check_command "$package" || pacman -Qi "$package" &> /dev/null; then
        print_success "$package já instalado"
    else
        print_info "Instalando $package..."
        sudo pacman -S --noconfirm --needed "$package" && print_success "$package instalado" || print_error "Falha ao instalar $package"
    fi
done

# ==========================================
# 📦 INSTALAÇÃO DE PACOTES AUR
# ==========================================

print_header "🌟 Instalando Pacotes AUR (Yay)"

# Lista de pacotes AUR
AUR_PACKAGES=(
    # Nerd Fonts (para ícones no Starship/Eza)
    meslolgs-nf
    jetbrains-mono-nerd-font
    # Adicione outros pacotes AUR aqui se necessário
)

for package in "${AUR_PACKAGES[@]}"; do
    if pacman -Qi "$package" &> /dev/null; then
        print_success "$package já instalado"
    else
        print_info "Instalando $package (AUR)..."
        yay -S --noconfirm --needed "$package" && print_success "$package instalado" || print_error "Falha ao instalar $package"
    fi
done

# ==========================================
# 🔧 CONFIGURAÇÃO DO ZINIT (PLUGIN MANAGER)
# ==========================================

print_header "⚡ Configurando Zinit"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ -d "$ZINIT_HOME" ]; then
    print_success "Zinit já está instalado"
else
    print_info "Instalando Zinit..."
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    print_success "Zinit instalado"
fi

# ==========================================
# 📥 CLONANDO DOTFILES
# ==========================================

print_header "📥 Clonando Dotfiles"

if [ -d "$DOTFILES_DIR" ]; then
    print_warning "Diretório $DOTFILES_DIR já existe!"
    read -p "Deseja fazer backup e re-clonar? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Fazendo backup para $BACKUP_DIR"
        mv "$DOTFILES_DIR" "$BACKUP_DIR"

        print_info "Clonando repositório de dotfiles..."
        git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
        print_success "Dotfiles clonado"
    else
        print_info "Usando dotfiles existentes"
    fi
else
    print_info "Clonando repositório de dotfiles..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    print_success "Dotfiles clonado"
fi

# ==========================================
# 🔗 CRIANDO SYMLINKS COM GNU STOW
# ==========================================

print_header "🔗 Criando Symlinks (GNU Stow)"

cd "$DOTFILES_DIR"

# Lista de pacotes para fazer stow
STOW_PACKAGES=(
    zsh
    starship
    git
    nvim
    helix
    lazygit
    btop
    atuin
    direnv
    fastfetch
    kitty
    # Adicione outros pacotes conforme necessário
)

for package in "${STOW_PACKAGES[@]}"; do
    if [ -d "$DOTFILES_DIR/$package" ]; then
        print_info "Fazendo stow do pacote: $package"
        stow "$package" && print_success "$package linkado" || print_warning "Falha ao fazer stow de $package"
    else
        print_warning "Pacote $package não encontrado em $DOTFILES_DIR"
    fi
done

# ==========================================
# 🐚 MUDANDO SHELL PADRÃO PARA ZSH
# ==========================================

print_header "🐚 Configurando Zsh como Shell Padrão"

if [ "$SHELL" = "$(which zsh)" ]; then
    print_success "Zsh já é o shell padrão"
else
    print_info "Mudando shell para Zsh..."
    chsh -s "$(which zsh)"
    print_success "Shell padrão alterado para Zsh"
    print_warning "Você precisa fazer logout e login para que a alteração tenha efeito"
fi

# ==========================================
# ✅ FINALIZAÇÃO
# ==========================================

print_header "✅ Instalação Concluída!"

echo -e "${GREEN}Seu ambiente Arch Linux está configurado!${NC}"
echo
echo "📋 Próximos Passos:"
echo "   1. Faça logout e login novamente para carregar o Zsh"
echo "   2. Abra um novo terminal"
echo "   3. Zinit instalará automaticamente os plugins na primeira execução"
echo "   4. Configure o Atuin (se necessário):"
echo "      atuin init zsh"
echo
echo "🎨 Temas Kitty disponíveis:"
echo "   - Gruvbox (padrão)"
echo "   - Catppuccin"
echo "   - Tokyo Night"
echo "   Altere em: ~/.config/kitty/kitty.conf"
echo
echo "📚 Repositório de dotfiles: $DOTFILES_DIR"
echo

# Opção de reiniciar
read -p "Deseja abrir uma nova sessão Zsh agora? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    exec zsh
fi
