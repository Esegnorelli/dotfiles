#!/usr/bin/env bash

# ============================================================================
# NEOVIM SETUP SCRIPT
# ============================================================================
# Configuração automática do Neovim com detecção de distro
# Baseado no setup do Chris Titus Tech

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

# Caminho do repositório de dotfiles
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NVIM_CONFIG_SRC="$DOTFILES_DIR/config/nvim"
NVIM_CONFIG_DST="$HOME/.config/nvim"

print_header "Configurando Neovim"

# ============================================================================
# Limpar configurações antigas
# ============================================================================

print_info "Deseja remover configurações antigas do Neovim? [y/N]"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    print_warning "Removendo configurações antigas..."
    rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
    print_success "Configurações antigas removidas"
fi

# ============================================================================
# Criar diretórios necessários
# ============================================================================

print_info "Criando diretórios necessários..."
mkdir -p "$HOME/.vim/undodir"
mkdir -p "$HOME/.scripts"
mkdir -p "$HOME/.config"
print_success "Diretórios criados"

# ============================================================================
# Detectar sistema operacional e gerenciador de pacotes
# ============================================================================

print_header "Detectando sistema operacional"

if [ ! -f /etc/os-release ]; then
    print_error "Não foi possível detectar o sistema operacional"
    exit 1
fi

. /etc/os-release

# Detectar Wayland ou Xorg para clipboard
if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    CLIPBOARD_PKG="wl-clipboard"
    print_info "Detectado: Wayland"
else
    CLIPBOARD_PKG="xclip"
    print_info "Detectado: Xorg"
fi

print_success "Sistema: ${ID_LIKE:-$ID}"

# ============================================================================
# Instalar dependências
# ============================================================================

print_header "Instalando dependências do Neovim"

COMMON_PKGS="ripgrep fzf neovim python3-virtualenv luarocks go shellcheck"

case "${ID_LIKE:-$ID}" in
    *debian*|*ubuntu*|pop)
        print_info "Instalando pacotes para Debian/Ubuntu..."
        sudo apt update
        sudo apt install -y ripgrep fd-find $CLIPBOARD_PKG python3-venv luarocks golang-go shellcheck neovim

        # fd-find precisa de link em algumas versões
        if ! command -v fd &> /dev/null && command -v fdfind &> /dev/null; then
            sudo ln -sf $(which fdfind) /usr/local/bin/fd
            print_info "Criado link: fdfind -> fd"
        fi
        print_success "Pacotes instalados (Debian/Ubuntu)"
        ;;

    fedora)
        print_info "Instalando pacotes para Fedora..."
        sudo dnf install -y ripgrep fzf $CLIPBOARD_PKG neovim python3-virtualenv luarocks golang ShellCheck
        print_success "Pacotes instalados (Fedora)"
        ;;

    arch|manjaro)
        print_info "Instalando pacotes para Arch/Manjaro..."
        sudo pacman -S --noconfirm ripgrep fzf $CLIPBOARD_PKG neovim python-virtualenv luarocks go shellcheck
        print_success "Pacotes instalados (Arch/Manjaro)"
        ;;

    opensuse|suse)
        print_info "Instalando pacotes para openSUSE..."
        sudo zypper install -y ripgrep fzf $CLIPBOARD_PKG neovim python3-virtualenv luarocks go ShellCheck
        print_success "Pacotes instalados (openSUSE)"
        ;;

    *)
        print_warning "Distribuição não reconhecida: ${ID_LIKE:-$ID}"
        print_info "Instale manualmente:"
        echo "  • ripgrep"
        echo "  • fzf"
        echo "  • $CLIPBOARD_PKG"
        echo "  • neovim (>= 0.9.0)"
        echo "  • python3-virtualenv"
        echo "  • luarocks"
        echo "  • go"
        echo "  • shellcheck"
        print_info "Continuar mesmo assim? [y/N]"
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            exit 1
        fi
        ;;
esac

# ============================================================================
# Link da configuração do Neovim
# ============================================================================

print_header "Configurando Neovim"

if [ -d "$NVIM_CONFIG_SRC" ]; then
    # Se já existe config no destino
    if [ -e "$NVIM_CONFIG_DST" ] || [ -L "$NVIM_CONFIG_DST" ]; then
        # Se já é um symlink para o lugar certo, skip
        if [ -L "$NVIM_CONFIG_DST" ] && [ "$(readlink "$NVIM_CONFIG_DST")" = "$NVIM_CONFIG_SRC" ]; then
            print_info "Configuração do Neovim já está linkada"
        else
            print_warning "Configuração existente será substituída"
            rm -rf "$NVIM_CONFIG_DST"
            ln -sf "$NVIM_CONFIG_SRC" "$NVIM_CONFIG_DST"
            print_success "Configuração do Neovim linkada"
        fi
    else
        ln -sf "$NVIM_CONFIG_SRC" "$NVIM_CONFIG_DST"
        print_success "Configuração do Neovim linkada"
    fi
else
    print_warning "Configuração do Neovim não encontrada em: $NVIM_CONFIG_SRC"
    print_info "Você precisará criar ou clonar uma configuração manualmente"
    print_info "Recomendação: Kickstart.nvim ou NvChad"
    echo ""
    echo "Opções:"
    echo "  1. Kickstart.nvim (minimalista): https://github.com/nvim-lua/kickstart.nvim"
    echo "  2. NvChad (completo): https://github.com/NvChad/NvChad"
    echo "  3. Chris Titus Tech: https://github.com/ChrisTitusTech/titus-kickstart"
    echo ""
    print_info "Clonar uma agora? [1/2/3/N]"
    read -r choice

    case $choice in
        1)
            git clone https://github.com/nvim-lua/kickstart.nvim.git "$NVIM_CONFIG_SRC"
            ln -sf "$NVIM_CONFIG_SRC" "$NVIM_CONFIG_DST"
            print_success "Kickstart.nvim clonado e linkado"
            ;;
        2)
            git clone https://github.com/NvChad/NvChad.git "$NVIM_CONFIG_SRC" --depth 1
            ln -sf "$NVIM_CONFIG_SRC" "$NVIM_CONFIG_DST"
            print_success "NvChad clonado e linkado"
            ;;
        3)
            git clone https://github.com/ChrisTitusTech/titus-kickstart.git "$NVIM_CONFIG_SRC"
            ln -sf "$NVIM_CONFIG_SRC" "$NVIM_CONFIG_DST"
            print_success "Titus Kickstart clonado e linkado"
            ;;
        *)
            print_info "Configuração pulada. Configure manualmente depois."
            ;;
    esac
fi

# ============================================================================
# Verificar versão do Neovim
# ============================================================================

print_header "Verificação final"

if command -v nvim &> /dev/null; then
    NVIM_VERSION=$(nvim --version | head -n1)
    print_success "Neovim instalado: $NVIM_VERSION"

    # Verificar se versão é >= 0.9.0
    NVIM_VER_NUM=$(nvim --version | head -n1 | grep -oP 'v\K[0-9]+\.[0-9]+' | head -1)
    REQUIRED_VER="0.9"

    if [ "$(printf '%s\n' "$REQUIRED_VER" "$NVIM_VER_NUM" | sort -V | head -n1)" = "$REQUIRED_VER" ]; then
        print_success "Versão compatível (>= 0.9.0)"
    else
        print_warning "Versão antiga detectada. Algumas features podem não funcionar."
        print_info "Considere atualizar para >= 0.9.0"
    fi
else
    print_error "Neovim não encontrado. Algo deu errado na instalação."
    exit 1
fi

# ============================================================================
# Finalização
# ============================================================================

print_header "Setup concluído!"

print_success "Neovim configurado com sucesso"
echo ""
print_info "Próximos passos:"
echo "  1. Abra o Neovim: nvim"
echo "  2. Aguarde instalação dos plugins (primeiro uso demora)"
echo "  3. Execute :checkhealth para verificar tudo"
echo ""
print_info "Comandos úteis:"
echo "  • :Lazy     - Gerenciar plugins (se usar lazy.nvim)"
echo "  • :Mason    - Gerenciar LSP/DAP/linters/formatters"
echo "  • :checkhealth - Verificar saúde do Neovim"
echo ""

print_warning "IMPORTANTE: Na primeira vez que abrir o Neovim, aguarde a instalação dos plugins terminar!"
