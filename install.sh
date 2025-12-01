#!/bin/bash

# Script de instalação automatizada de dotfiles para Pop!_OS
# Autor: esegnorelli
# Descrição: Instala e configura zsh, oh-my-zsh, powerlevel10k, plugins e fonte Meslo Nerd Font

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para imprimir mensagens coloridas
print_message() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[ℹ]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Verificar se está rodando no Pop!_OS
if ! grep -q "Pop!_OS" /etc/os-release 2>/dev/null; then
    print_warning "Este script foi desenvolvido para Pop!_OS, mas pode funcionar em outras distros baseadas em Ubuntu/Debian."
fi

print_info "Iniciando instalação dos dotfiles..."
echo ""

# 1. Atualizar sistema
print_info "Atualizando sistema..."
sudo apt update && sudo apt upgrade -y
print_message "Sistema atualizado"
echo ""

# 2. Instalar dependências
print_info "Instalando dependências..."
sudo apt install -y git curl wget zsh fonts-powerline
print_message "Dependências instaladas"
echo ""

# 3. Instalar Meslo Nerd Font
print_info "Instalando fonte Meslo Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# Download Meslo Nerd Font
cd /tmp
wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

mv MesloLGS*.ttf "$FONT_DIR/"
fc-cache -f -v > /dev/null 2>&1
print_message "Fonte Meslo Nerd Font instalada"
echo ""

# 4. Instalar Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_info "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_message "Oh My Zsh instalado"
else
    print_warning "Oh My Zsh já está instalado"
fi
echo ""

# 5. Instalar Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    print_info "Instalando tema Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    print_message "Powerlevel10k instalado"
else
    print_warning "Powerlevel10k já está instalado"
fi
echo ""

# 6. Instalar plugins do zsh
print_info "Instalando plugins do zsh..."

# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    print_message "Plugin zsh-autosuggestions instalado"
else
    print_warning "Plugin zsh-autosuggestions já está instalado"
fi

# zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    print_message "Plugin zsh-syntax-highlighting instalado"
else
    print_warning "Plugin zsh-syntax-highlighting já está instalado"
fi

# zsh-completions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
    print_message "Plugin zsh-completions instalado"
else
    print_warning "Plugin zsh-completions já está instalado"
fi

echo ""

# 7. Backup do .zshrc existente
if [ -f "$HOME/.zshrc" ]; then
    print_warning "Fazendo backup do .zshrc existente..."
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    print_message "Backup criado"
fi

# 8. Copiar arquivos de configuração
print_info "Copiando arquivos de configuração..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$SCRIPT_DIR/.zshrc" ]; then
    cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
    print_message "Arquivo .zshrc copiado"
else
    print_error "Arquivo .zshrc não encontrado no diretório do script"
fi

if [ -f "$SCRIPT_DIR/.p10k.zsh" ]; then
    cp "$SCRIPT_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
    print_message "Arquivo .p10k.zsh copiado"
else
    print_error "Arquivo .p10k.zsh não encontrado no diretório do script"
fi

echo ""

# 9. Mudar shell padrão para zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    print_info "Alterando shell padrão para zsh..."
    chsh -s $(which zsh)
    print_message "Shell padrão alterado para zsh"
    print_warning "Você precisará fazer logout e login novamente para que a mudança tenha efeito"
else
    print_message "Zsh já é o shell padrão"
fi

echo ""
print_message "Instalação concluída com sucesso!"
echo ""
print_info "Próximos passos:"
echo "  1. Configure a fonte do terminal para 'MesloLGS NF'"
echo "  2. Feche e abra novamente o terminal (ou faça logout/login)"
echo "  3. O Powerlevel10k será configurado automaticamente na primeira execução"
echo ""
print_info "Para reconfigurar o Powerlevel10k a qualquer momento, execute: p10k configure"
echo ""
