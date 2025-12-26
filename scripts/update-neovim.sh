#!/usr/bin/env bash

# ============================================================================
# ATUALIZAÇÃO DO NEOVIM PARA VERSÃO MODERNA
# ============================================================================
# Instala Neovim >= 0.10.0 no Pop!_OS/Ubuntu via PPA oficial

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

print_header "Atualizando Neovim para versão moderna"

# Verificar versão atual
if command -v nvim &> /dev/null; then
    CURRENT_VERSION=$(nvim --version | head -n1)
    print_info "Versão atual: $CURRENT_VERSION"
else
    print_info "Neovim não encontrado"
fi

# Adicionar PPA do Neovim Unstable (versões estáveis e modernas)
print_info "Adicionando PPA do Neovim..."
add-apt-repository -y ppa:neovim-ppa/unstable
print_success "PPA adicionado"

# Atualizar lista de pacotes
print_info "Atualizando lista de pacotes..."
apt update
print_success "Lista atualizada"

# Instalar/Atualizar Neovim
print_info "Instalando Neovim..."
apt install -y neovim
print_success "Neovim instalado/atualizado"

# Verificar nova versão
if command -v nvim &> /dev/null; then
    NEW_VERSION=$(nvim --version | head -n1)
    print_success "Nova versão: $NEW_VERSION"

    # Verificar se é >= 0.10.0
    NVIM_VER_NUM=$(nvim --version | head -n1 | grep -oP 'v\K[0-9]+\.[0-9]+' | head -1)
    REQUIRED_VER="0.10"

    if [ "$(printf '%s\n' "$REQUIRED_VER" "$NVIM_VER_NUM" | sort -V | head -n1)" = "$REQUIRED_VER" ]; then
        print_success "Versão compatível com LazyVim! (>= 0.10.0)"
    else
        print_warning "Versão pode não ser suficiente para LazyVim"
    fi
else
    print_error "Algo deu errado - Neovim não encontrado após instalação"
    exit 1
fi

print_header "Atualização concluída!"
echo ""
print_info "Execute agora: sudo ./scripts/install-dependencies.sh"
print_info "Depois: ./scripts/setup-lazyvim.sh"
