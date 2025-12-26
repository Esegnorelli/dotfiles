#!/usr/bin/env bash

# ============================================================================
# DOTFILES DEPLOY SCRIPT
# ============================================================================
# Script para instalar/atualizar dotfiles em qualquer máquina
# Uso: ./deploy.sh [--force] [--backup]

set -e  # Exit on error

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Diretórios
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Flags
FORCE=false
CREATE_BACKUP=false

# ============================================================================
# Funções auxiliares
# ============================================================================

print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Criar symlink com backup opcional
create_symlink() {
    local source="$1"
    local target="$2"

    # Se target já existe
    if [ -e "$target" ] || [ -L "$target" ]; then
        # Se já é um symlink para o lugar certo, skip
        if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
            print_info "Já linkado: $target"
            return 0
        fi

        # Backup se pedido
        if [ "$CREATE_BACKUP" = true ]; then
            mkdir -p "$BACKUP_DIR/$(dirname "$target")"
            mv "$target" "$BACKUP_DIR/$target"
            print_warning "Backup criado: $target -> $BACKUP_DIR"
        elif [ "$FORCE" = false ]; then
            print_warning "Arquivo existe: $target (use --force ou --backup)"
            return 1
        else
            rm -rf "$target"
        fi
    fi

    # Criar diretório pai se necessário
    mkdir -p "$(dirname "$target")"

    # Criar symlink
    ln -sf "$source" "$target"
    print_success "Linkado: $target -> $source"
}

# Verificar se comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# ============================================================================
# Parse argumentos
# ============================================================================

for arg in "$@"; do
    case $arg in
        --force)
            FORCE=true
            ;;
        --backup)
            CREATE_BACKUP=true
            ;;
        --help)
            echo "Uso: $0 [OPTIONS]"
            echo ""
            echo "Opções:"
            echo "  --force     Sobrescrever arquivos existentes"
            echo "  --backup    Criar backup antes de sobrescrever"
            echo "  --help      Mostrar esta ajuda"
            exit 0
            ;;
    esac
done

# ============================================================================
# Banner
# ============================================================================

clear
cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║   ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
║   ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
║   ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
║   ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
║   ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
║   ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
║                                                               ║
║              Setup Profissional - Deploy Script               ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF

print_info "Dotfiles dir: $DOTFILES_DIR"
print_info "Backup dir: $BACKUP_DIR"
echo ""

# ============================================================================
# Verificar dependências
# ============================================================================

print_header "Verificando Dependências"

MISSING_DEPS=()

if ! command_exists kitty; then
    MISSING_DEPS+=("kitty")
    print_warning "kitty não instalado"
else
    print_success "kitty instalado"
fi

if ! command_exists zsh; then
    MISSING_DEPS+=("zsh")
    print_warning "zsh não instalado"
else
    print_success "zsh instalado"
fi

if ! fc-list | grep -qi "JetBrainsMono"; then
    MISSING_DEPS+=("JetBrainsMono Nerd Font")
    print_warning "JetBrainsMono Nerd Font não instalada"
else
    print_success "JetBrainsMono Nerd Font instalada"
fi

if [ ${#MISSING_DEPS[@]} -gt 0 ]; then
    echo ""
    print_warning "Dependências faltando: ${MISSING_DEPS[*]}"
    print_info "Continue mesmo assim? [y/N]"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# ============================================================================
# Criar symlinks - Kitty
# ============================================================================

print_header "Configurando Kitty"

create_symlink "$DOTFILES_DIR/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
create_symlink "$DOTFILES_DIR/config/kitty/theme.conf" "$HOME/.config/kitty/theme.conf"
create_symlink "$DOTFILES_DIR/config/kitty/session.conf" "$HOME/.config/kitty/session.conf"

# Temas adicionais
mkdir -p "$HOME/.config/kitty/themes"
create_symlink "$DOTFILES_DIR/themes/tokyo-night-kitty.conf" "$HOME/.config/kitty/themes/tokyo-night.conf"
create_symlink "$DOTFILES_DIR/themes/dracula-kitty.conf" "$HOME/.config/kitty/themes/dracula.conf"

# ============================================================================
# Criar symlinks - ZSH (futuro)
# ============================================================================

print_header "Configurando ZSH"

if [ -f "$DOTFILES_DIR/config/zsh/.zshrc" ]; then
    create_symlink "$DOTFILES_DIR/config/zsh/.zshrc" "$HOME/.zshrc"
else
    print_info "Arquivo .zshrc ainda não existe no repo (será adicionado)"
fi

# ============================================================================
# Git config (opcional)
# ============================================================================

print_header "Configurando Git"

if [ -f "$DOTFILES_DIR/.gitconfig" ]; then
    create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
else
    print_info ".gitconfig não encontrado (opcional)"
fi

# ============================================================================
# Finalização
# ============================================================================

print_header "Finalizando"

# Mostrar arquivos de backup se criados
if [ -d "$BACKUP_DIR" ] && [ "$(ls -A "$BACKUP_DIR")" ]; then
    print_info "Backups salvos em: $BACKUP_DIR"
fi

print_success "Deploy concluído com sucesso!"
echo ""
print_info "Próximos passos:"
echo "  1. Reinicie o Kitty (Ctrl+Shift+F5 ou feche e abra)"
echo "  2. Para zsh: chsh -s \$(which zsh)"
echo "  3. Veja o README.md para mais informações"
echo ""

# Oferecer recarregar kitty se estiver rodando
if command_exists kitty && pgrep -x kitty > /dev/null; then
    print_info "Recarregar configs do Kitty agora? [y/N]"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        kitty @ load-config
        print_success "Kitty recarregado!"
    fi
fi

print_success "Tudo pronto! Aproveite seu novo setup."
