#!/bin/bash

# Script para testar todos os scripts de dotfiles
set -e

echo "🧪 Testando scripts de dotfiles..."
echo ""

# Cores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

tests_passed=0
tests_failed=0

# Função para testar comando
test_command() {
    local name="$1"
    local command="$2"

    echo -n "Testando: $name ... "
    if eval "$command" &> /dev/null; then
        echo -e "${GREEN}✅ PASSOU${NC}"
        ((tests_passed++))
    else
        echo -e "${RED}❌ FALHOU${NC}"
        ((tests_failed++))
    fi
}

# Testar sintaxe dos scripts
echo "📝 Verificando sintaxe dos scripts..."
test_command "restore.sh" "bash -n ~/dotfiles/restore.sh"
test_command "sync.sh" "bash -n ~/dotfiles/sync.sh"
test_command "setup-esegnorelli.sh" "bash -n ~/dotfiles/setup-esegnorelli.sh"
test_command "setup-work.sh" "bash -n ~/dotfiles/setup-work.sh"
test_command "copy-to-pendrive.sh" "bash -n ~/dotfiles/copy-to-pendrive.sh"

echo ""
echo "🔍 Verificando permissões de execução..."
test_command "restore.sh executável" "[ -x ~/dotfiles/restore.sh ]"
test_command "sync.sh executável" "[ -x ~/dotfiles/sync.sh ]"
test_command "setup-esegnorelli.sh executável" "[ -x ~/dotfiles/setup-esegnorelli.sh ]"
test_command "setup-work.sh executável" "[ -x ~/dotfiles/setup-work.sh ]"
test_command "copy-to-pendrive.sh executável" "[ -x ~/dotfiles/copy-to-pendrive.sh ]"

echo ""
echo "📦 Verificando estrutura de diretórios..."
test_command "nvim/" "[ -d ~/dotfiles/nvim ]"
test_command "tmux/" "[ -d ~/dotfiles/tmux ]"
test_command "zsh/" "[ -d ~/dotfiles/zsh ]"
test_command "bash/" "[ -d ~/dotfiles/bash ]"
test_command "git/" "[ -d ~/dotfiles/git ]"
test_command "kitty/" "[ -d ~/dotfiles/kitty ]"
test_command "opencode/" "[ -d ~/dotfiles/opencode ]"
test_command "claude/" "[ -d ~/dotfiles/claude ]"
test_command "antigravity/" "[ -d ~/dotfiles/antigravity ]"

echo ""
echo "📄 Verificando arquivos de configuração..."
test_command ".gitignore" "[ -f ~/dotfiles/.gitignore ]"
test_command "README.md" "[ -f ~/dotfiles/README.md ]"

echo ""
echo "🔧 Verificando dependências..."
test_command "git instalado" "command -v git"
test_command "stow instalado" "command -v stow"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 RESULTADOS:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Tests passados: ${GREEN}$tests_passed${NC}"
echo -e "Tests falhados: ${RED}$tests_failed${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $tests_failed -eq 0 ]; then
    echo -e "${GREEN}✅ Todos os testes passaram!${NC}"
    exit 0
else
    echo -e "${RED}❌ Alguns testes falharam${NC}"
    exit 1
fi
