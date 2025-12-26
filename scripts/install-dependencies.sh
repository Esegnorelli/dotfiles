#!/usr/bin/env bash

# ============================================================================
# INSTALAÇÃO DE DEPENDÊNCIAS PARA NEOVIM + LAZYVIM
# ============================================================================
# Instala todas as ferramentas necessárias para LazyVim funcionar perfeitamente

set -e

RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'
BLUE='\e[34m'

print_header() { echo -e "\n${BLUE}=== $1 ===${RC}\n"; }
print_success() { echo -e "${GREEN}✓${RC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${RC} $1"; }
print_error() { echo -e "${RED}✗${RC} $1"; }
print_info() { echo -e "${BLUE}ℹ${RC} $1"; }

# Verificar se está rodando com sudo
if [ "$EUID" -ne 0 ]; then
    print_error "Este script precisa rodar com sudo"
    echo "Execute: sudo $0"
    exit 1
fi

print_header "Instalando dependências para LazyVim"

# Detectar Wayland ou Xorg para clipboard
if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    CLIPBOARD_PKG="wl-clipboard"
    print_info "Detectado: Wayland - usando wl-clipboard"
else
    CLIPBOARD_PKG="xclip"
    print_info "Detectado: Xorg - usando xclip"
fi

# Lista de pacotes essenciais
PACKAGES=(
    # Core tools
    git
    curl
    wget
    unzip
    tar

    # Build essentials
    build-essential
    gcc
    make
    cmake

    # Neovim dependencies
    $CLIPBOARD_PKG      # Clipboard support
    ripgrep             # Telescope fuzzy finder
    fd-find             # File finder (alternativa ao find)
    fzf                 # Fuzzy finder

    # Language support
    python3
    python3-pip
    python3-venv
    nodejs
    npm

    # LSP and formatting tools
    shellcheck          # Bash LSP

    # Optional but recommended
    tree                # Directory visualization
    htop                # Process monitor
    bat                 # Cat with syntax highlighting
    eza                 # Modern ls replacement
)

print_info "Atualizando lista de pacotes..."
apt update
print_success "Lista atualizada"

print_info "Instalando ${#PACKAGES[@]} pacotes..."
apt install -y "${PACKAGES[@]}"
print_success "Pacotes principais instalados"

# Criar link para fd (fd-find no Ubuntu/Debian é instalado como fdfind)
if ! command -v fd &> /dev/null && command -v fdfind &> /dev/null; then
    print_info "Criando link: fdfind -> fd"
    ln -sf $(which fdfind) /usr/local/bin/fd
    print_success "Link fd criado"
fi

# Instalar Node.js moderno via NodeSource (opcional mas recomendado)
print_info "Deseja instalar Node.js LTS mais recente via NodeSource? [y/N]"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
    print_info "Instalando Node.js LTS..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
    apt install -y nodejs
    print_success "Node.js $(node --version) instalado"
fi

# Instalar Go (necessário para alguns LSPs)
print_info "Instalando Go..."
apt install -y golang-go
print_success "Go instalado: $(go version)"

# Instalar Lua e LuaRocks
print_info "Instalando Lua e LuaRocks..."
apt install -y lua5.4 luarocks
print_success "Lua instalado: $(lua -v 2>&1 | head -1)"

# Instalar ferramentas Python globais
print_info "Instalando ferramentas Python..."
pip3 install --upgrade pip
pip3 install pynvim virtualenv
print_success "Ferramentas Python instaladas"

# Verificação final
print_header "Verificação de dependências"

check_cmd() {
    if command -v "$1" &> /dev/null; then
        VERSION=$($1 --version 2>&1 | head -1 || echo "instalado")
        print_success "$1: $VERSION"
        return 0
    else
        print_error "$1: NÃO INSTALADO"
        return 1
    fi
}

MISSING=0

check_cmd nvim || ((MISSING++))
check_cmd git || ((MISSING++))
check_cmd rg || ((MISSING++))
check_cmd fd || ((MISSING++))
check_cmd fzf || ((MISSING++))
check_cmd node || ((MISSING++))
check_cmd npm || ((MISSING++))
check_cmd python3 || ((MISSING++))
check_cmd go || ((MISSING++))
check_cmd shellcheck || ((MISSING++))

if [ $MISSING -eq 0 ]; then
    print_header "Tudo instalado com sucesso!"
    echo ""
    print_info "Próximo passo: ./scripts/setup-lazyvim.sh"
else
    print_warning "$MISSING ferramenta(s) faltando - verifique os erros acima"
fi
