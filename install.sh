#!/bin/bash

# Script de instalação automatizada de dotfiles para Pop!_OS
# Autor: esegnorelli
# Descrição: Instala zsh, oh-my-zsh, powerlevel10k, ferramentas de desenvolvimento e CLIs

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Funções para imprimir mensagens coloridas
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

print_section() {
    echo -e "\n${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${MAGENTA}  $1${NC}"
    echo -e "${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Verificar se está rodando no Pop!_OS
if ! grep -q "Pop!_OS" /etc/os-release 2>/dev/null; then
    print_warning "Este script foi desenvolvido para Pop!_OS, mas pode funcionar em outras distros baseadas em Ubuntu/Debian."
fi

print_section "🚀 Instalação dos Dotfiles para Pop!_OS"

# ============================================================================
# 1. Atualizar sistema
# ============================================================================
print_section "📦 Atualizando Sistema"
print_info "Atualizando repositórios e pacotes..."
sudo apt update && sudo apt upgrade -y
print_message "Sistema atualizado"

# ============================================================================
# 2. Instalar dependências básicas
# ============================================================================
print_section "🔧 Instalando Dependências Básicas"
print_info "Instalando git, curl, wget, zsh, build-essential..."
sudo apt install -y git curl wget zsh fonts-powerline build-essential \
    software-properties-common apt-transport-https ca-certificates \
    gnupg lsb-release unzip
print_message "Dependências básicas instaladas"

# ============================================================================
# 3. Instalar Fontes Nerd Font
# ============================================================================
print_section "🔤 Instalando Nerd Fonts"
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
cd /tmp

# Meslo Nerd Font
print_info "Instalando Meslo Nerd Font..."
wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
mv MesloLGS*.ttf "$FONT_DIR/"
print_message "Meslo Nerd Font instalada"

# JetBrains Mono Nerd Font
print_info "Instalando JetBrains Mono Nerd Font..."
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip -q JetBrainsMono.zip -d JetBrainsMono
mv JetBrainsMono/*.ttf "$FONT_DIR/"
rm -rf JetBrainsMono JetBrainsMono.zip
print_message "JetBrains Mono Nerd Font instalada"

# Fira Code Nerd Font
print_info "Instalando Fira Code Nerd Font..."
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
unzip -q FiraCode.zip -d FiraCode
mv FiraCode/*.ttf "$FONT_DIR/"
rm -rf FiraCode FiraCode.zip
print_message "Fira Code Nerd Font instalada"

# Atualizar cache de fontes
fc-cache -f -v > /dev/null 2>&1
print_message "Cache de fontes atualizado"

# ============================================================================
# 4. Instalar Oh My Zsh
# ============================================================================
print_section "💻 Instalando Oh My Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_info "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_message "Oh My Zsh instalado"
else
    print_warning "Oh My Zsh já está instalado"
fi

# ============================================================================
# 5. Instalar Powerlevel10k
# ============================================================================
print_section "🎨 Instalando Powerlevel10k"
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    print_info "Instalando tema Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    print_message "Powerlevel10k instalado"
else
    print_warning "Powerlevel10k já está instalado"
fi

# ============================================================================
# 6. Instalar plugins do zsh
# ============================================================================
print_section "🔌 Instalando Plugins do Zsh"

# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    print_info "Instalando zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    print_message "zsh-autosuggestions instalado"
else
    print_warning "zsh-autosuggestions já está instalado"
fi

# zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    print_info "Instalando zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    print_message "zsh-syntax-highlighting instalado"
else
    print_warning "zsh-syntax-highlighting já está instalado"
fi

# zsh-completions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions" ]; then
    print_info "Instalando zsh-completions..."
    git clone https://github.com/zsh-users/zsh-completions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
    print_message "zsh-completions instalado"
else
    print_warning "zsh-completions já está instalado"
fi

# ============================================================================
# 7. Instalar Ferramentas Modernas de Terminal
# ============================================================================
print_section "⚡ Instalando Ferramentas Modernas de Terminal"

# bat (cat com syntax highlighting)
print_info "Instalando bat..."
sudo apt install -y bat
# Criar link simbólico (no Ubuntu/Debian, o executável é 'batcat')
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat
print_message "bat instalado"

# exa (ls moderno)
print_info "Instalando exa..."
sudo apt install -y exa
print_message "exa instalado"

# fzf (fuzzy finder)
print_info "Instalando fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-bash --no-fish
print_message "fzf instalado"

# ripgrep (grep rápido)
print_info "Instalando ripgrep..."
sudo apt install -y ripgrep
print_message "ripgrep instalado"

# fd (find moderno)
print_info "Instalando fd..."
sudo apt install -y fd-find
ln -sf /usr/bin/fdfind ~/.local/bin/fd
print_message "fd instalado"

# neovim
print_info "Instalando neovim..."
sudo apt install -y neovim
print_message "neovim instalado"

# tmux
print_info "Instalando tmux..."
sudo apt install -y tmux
print_message "tmux instalado"

# htop
print_info "Instalando htop..."
sudo apt install -y htop
print_message "htop instalado"

# neofetch
print_info "Instalando neofetch..."
sudo apt install -y neofetch
print_message "neofetch instalado"

# ============================================================================
# 8. Instalar Node.js via NVM
# ============================================================================
print_section "📦 Instalando Node.js (via NVM)"
if [ ! -d "$HOME/.nvm" ]; then
    print_info "Instalando NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    # Carregar NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    print_message "NVM instalado"

    print_info "Instalando Node.js LTS..."
    nvm install --lts
    nvm use --lts
    print_message "Node.js LTS instalado"
else
    print_warning "NVM já está instalado"
fi

# ============================================================================
# 9. Instalar Python via pyenv
# ============================================================================
print_section "🐍 Instalando Python (via pyenv)"
if [ ! -d "$HOME/.pyenv" ]; then
    print_info "Instalando dependências do Python..."
    sudo apt install -y make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
        libffi-dev liblzma-dev

    print_info "Instalando pyenv..."
    curl https://pyenv.run | bash
    print_message "pyenv instalado"

    print_info "Python será configurado na próxima sessão do terminal"
else
    print_warning "pyenv já está instalado"
fi

# ============================================================================
# 10. Instalar Docker e Docker Compose
# ============================================================================
print_section "🐳 Instalando Docker e Docker Compose"
if ! command -v docker &> /dev/null; then
    print_info "Instalando Docker..."

    # Adicionar repositório do Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Adicionar usuário ao grupo docker
    sudo usermod -aG docker $USER

    print_message "Docker instalado"
    print_warning "Você precisará fazer logout e login novamente para usar o Docker sem sudo"
else
    print_warning "Docker já está instalado"
fi

# ============================================================================
# 11. Instalar GitHub CLI
# ============================================================================
print_section "🐙 Instalando GitHub CLI (gh)"
if ! command -v gh &> /dev/null; then
    print_info "Instalando GitHub CLI..."
    type -p curl >/dev/null || sudo apt install curl -y
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install -y gh
    print_message "GitHub CLI instalado"
else
    print_warning "GitHub CLI já está instalado"
fi

# ============================================================================
# 12. Instalar Claude Code CLI
# ============================================================================
print_section "🤖 Instalando Claude Code CLI"
if ! command -v claude &> /dev/null; then
    print_info "Instalando Claude Code..."
    curl -fsSL https://static.claudeusercontent.com/claudecode_installer.sh | sh
    print_message "Claude Code instalado"
    print_info "Execute 'claude auth login' para fazer login"
else
    print_warning "Claude Code já está instalado"
fi

# ============================================================================
# 13. Copiar arquivos de configuração
# ============================================================================
print_section "📝 Copiando Arquivos de Configuração"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Backup do .zshrc existente
if [ -f "$HOME/.zshrc" ]; then
    print_warning "Fazendo backup do .zshrc existente..."
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    print_message "Backup criado"
fi

# Copiar .zshrc
if [ -f "$SCRIPT_DIR/.zshrc" ]; then
    cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
    print_message "Arquivo .zshrc copiado"
else
    print_error "Arquivo .zshrc não encontrado no diretório do script"
fi

# Copiar .p10k.zsh
if [ -f "$SCRIPT_DIR/.p10k.zsh" ]; then
    cp "$SCRIPT_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
    print_message "Arquivo .p10k.zsh copiado"
else
    print_error "Arquivo .p10k.zsh não encontrado no diretório do script"
fi

# ============================================================================
# 14. Mudar shell padrão para zsh
# ============================================================================
print_section "🐚 Configurando Shell Padrão"
if [ "$SHELL" != "$(which zsh)" ]; then
    print_info "Alterando shell padrão para zsh..."
    chsh -s $(which zsh)
    print_message "Shell padrão alterado para zsh"
    print_warning "Você precisará fazer logout e login novamente para que a mudança tenha efeito"
else
    print_message "Zsh já é o shell padrão"
fi

# ============================================================================
# 15. Resumo Final
# ============================================================================
print_section "✨ Instalação Concluída!"

echo ""
print_info "📋 Resumo do que foi instalado:"
echo ""
echo "  🎨 Terminal:"
echo "    • Zsh + Oh My Zsh + Powerlevel10k"
echo "    • Plugins: autosuggestions, syntax-highlighting, completions"
echo "    • Fontes: Meslo NF, JetBrains Mono NF, Fira Code NF"
echo ""
echo "  ⚡ Ferramentas Modernas:"
echo "    • bat, exa, fzf, ripgrep, fd"
echo "    • neovim, tmux, htop, neofetch"
echo ""
echo "  🛠️  Desenvolvimento:"
echo "    • Node.js (via NVM)"
echo "    • Python (via pyenv)"
echo "    • Docker + Docker Compose"
echo ""
echo "  🤖 CLIs:"
echo "    • GitHub CLI (gh)"
echo "    • Claude Code CLI"
echo ""
print_info "📌 Próximos passos:"
echo ""
echo "  1. Configure a fonte do terminal:"
echo "     • MesloLGS NF (recomendado para Powerlevel10k)"
echo "     • JetBrains Mono Nerd Font"
echo "     • Fira Code Nerd Font"
echo ""
echo "  2. Faça logout e login novamente (necessário para Docker e Zsh)"
echo ""
echo "  3. Autentique-se nas ferramentas:"
echo "     • gh auth login    (GitHub CLI)"
echo "     • claude auth login (Claude Code)"
echo ""
echo "  4. O Powerlevel10k será configurado automaticamente na primeira execução"
echo "     • Para reconfigurar: p10k configure"
echo ""
echo "  5. Comandos úteis instalados:"
echo "     • nvim - Editor Neovim"
echo "     • bat - cat com syntax highlighting"
echo "     • exa - ls moderno (alias: ll, la)"
echo "     • fzf - Fuzzy finder (Ctrl+R para histórico)"
echo "     • rg - ripgrep (busca rápida)"
echo "     • fd - find moderno"
echo "     • tmux - Multiplexador de terminal"
echo ""
print_message "Aproveite seu novo ambiente de desenvolvimento! 🎉"
echo ""
