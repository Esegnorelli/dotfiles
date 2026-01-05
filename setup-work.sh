#!/bin/bash

# Script completo para configurar dotfiles no PC do trabalho
set -e

cat << "EOF"
╔═════════════════════════════════════════════════════════════╗
║        CONFIGURAR DOTFILES NO PC DO TRABALHO                ║
╚═════════════════════════════════════════════════════════════╝

Este script vai:
  1. Instalar dependências necessárias
  2. Configurar Git
  3. Clonar seus dotfiles do GitHub
  4. Restaurar todas as configurações
  5. Instalar ferramentas adicionais

EOF

# Verificar se está rodando como root
if [ "$EUID" -eq 0 ]; then
    echo "❌ Não execute como root. Execute como usuário normal."
    exit 1
fi

echo "🔍 Verificando dependências..."

# Instalar pacotes necessários (Arch Linux)
if command -v pacman &> /dev/null; then
    echo "📦 Instalando pacotes com pacman..."
    sudo pacman -S --needed --noconfirm \
        git stow openssh \
        neovim tmux zsh \
        fzf ripgrep fd bat \
        nodejs npm \
        python python-pip \
        go \
        starship \
        kitty
else
    echo "⚠️  Sistema não é Arch/Manjaro. Instale manualmente:"
    echo "   git, stow, openssh, neovim, tmux, zsh, fzf, ripgrep, fd, bat, starship, kitty"
fi

echo "✅ Dependências instaladas"

# Configurar Git
echo ""
echo "📝 Configure Git:"
read -p "Nome completo: " GIT_NAME
read -p "Email: " GIT_EMAIL

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
echo "✅ Git configurado"

# Gerar SSH key
echo ""
echo "🔑 Configurando SSH..."
if [ ! -f ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f ~/.ssh/id_ed25519 -N ""
    echo "✅ Chave SSH gerada"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
else
    echo "ℹ️  Chave SSH já existe"
fi

# Mostrar chave
echo ""
echo "📋 COPIE ESTA CHAVE PARA O GITHUB:"
echo "──────────────────────────────────────────"
cat ~/.ssh/id_ed25519.pub
echo "──────────────────────────────────────────"
echo ""
echo "Adicione em: https://github.com/settings/keys"
read -p "Pressione ENTER quando terminar..."

# Clonar dotfiles
echo ""
read -p "URL do repositório (ex: git@github.com:Esegnorelli/dotfiles.git): " REPO_URL

echo "📥 Clonando dotfiles..."
if [ -d ~/dotfiles ]; then
    echo "⚠️  ~/dotfiles já existe. Removendo..."
    rm -rf ~/dotfiles
fi

git clone "$REPO_URL" ~/dotfiles
cd ~/dotfiles

# Restaurar configurações
echo ""
echo "🔧 Restaurando configurações..."
./restore.sh

# Instalar plugins nvim
echo ""
echo "📦 Instalando plugins do nvim..."
nvim --headless "+Lazy! sync" +qa

# Mudar shell padrão para zsh
echo ""
echo "🐚 Mudando shell padrão para Zsh..."
if command -v zsh &> /dev/null; then
    ZSH_PATH=$(command -v zsh)
    if [ -n "$ZSH_PATH" ]; then
        chsh -s "$ZSH_PATH"
        echo "✅ Shell alterado para Zsh (reiniciei o terminal)"
    else
        echo "⚠️  Não foi possível encontrar o caminho do zsh"
    fi
else
    echo "⚠️  Zsh não encontrado, mantendo shell atual"
fi

echo ""
cat << "EOF"
╔═════════════════════════════════════════════════════════════╗
║  ✅ CONFIGURAÇÃO COMPLETA!                                  ║
╚═════════════════════════════════════════════════════════════╝

🔄 PARA ATUALIZAR NO FUTURO:

  cd ~/dotfiles && ./sync.sh

📝 PARA ADICIONAR NOVA CONFIGURAÇÃO:

  1. Edite os arquivos normalmente (eles são links simbólicos)
  2. Execute: cd ~/dotfiles && ./sync.sh

📦 PACOTES INSTALADOS:

  ✅ Neovim (LazyVim + plugins + AI)
  ✅ Tmux (floax, sessionx, catppuccin)
  ✅ Zsh (Oh My Zsh + Powerlevel10k + fzf)
  ✅ Kitty terminal
  ✅ Git configurado
  ✅ SSH configurado
  ✅ Starship prompt
  ✅ OpenCode (configurações)
  ✅ Claude (configurações)
  ✅ Antigravity (configurações)
  ✅ Scripts úteis
  ✅ Ferramentas (fzf, ripgrep, fd, bat)

⚠️  IMPORTANTE:

  - Reinicie o terminal para aplicar Zsh/Starship
  - Na primeira vez que abrir nvim, execute :Lazy sync
  - Execute 'tmux' e pressione Prefix+I para instalar plugins do tmux
  - As configurações são links simbólicos, edits funcionam normal

EOF
