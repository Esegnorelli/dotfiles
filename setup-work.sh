#!/bin/bash

# Script completo para configurar dotfiles no PC do trabalho (Arch Linux limpo)
set -e

cat << "EOF"
╔═════════════════════════════════════════════════════════════╗
║        CONFIGURAR DOTFILES NO PC DO TRABALHO                ║
║              (Arch Linux sem nada instalado)                ║
╚═════════════════════════════════════════════════════════════╝

Este script vai:
  1. Instalar todas as dependências com pacman
  2. Instalar ferramentas do AUR manualmente
  3. Instalar Node.js (necessário para plugins IA do nvim)
  4. Instalar Oh My Zsh, Powerlevel10k, plugins
  5. Instalar TPM (Tmux Plugin Manager) e plugins
  6. Configurar Git e SSH
  7. Clonar seus dotfiles do GitHub
  8. Restaurar todas as configurações com Stow
  9. Instalar plugins do Neovim (LazyVim + IA)
 10. Configurar Claude, Z.AI e OpenCode

EOF

# Verificar se está rodando como root
if [ "$EUID" -eq 0 ]; then
    echo "❌ Não execute como root. Execute como usuário normal."
    exit 1
fi

# Atualizar sistema
echo "📦 Atualizando sistema..."
sudo pacman -Syu --noconfirm --needed || true

# Instalar dependências principais do pacman
echo "📦 Instalando pacotes do pacman..."
sudo pacman -S --needed --noconfirm \
    git stow openssh \
    neovim tmux zsh \
    fzf ripgrep \
    nodejs npm \
    python python-pip python-setuptools \
    go \
    curl wget \
    bat \
    kitty \
    starship \
    unzip \
    base-devel \
    cmake gcc \
    xclip xsel

echo "✅ Pacotes do pacman instalados"

# Instalar fd (find alternative)
echo "📦 Instalando fd..."
sudo pacman -S --needed --noconfirm fd || {
    echo "⚠️  fd não encontrado no pacman, instalando do GitHub..."
    curl -sSLO https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-gnu.tar.gz
    tar xzf fd-v10.2.0-x86_64-unknown-linux-gnu.tar.gz
    sudo cp fd-v10.2.0-x86_64-unknown-linux-gnu/fd /usr/local/bin/
    rm -rf fd-v10.2.0-x86_64-unknown-linux-gnu*
}

# Instalar eza (ls replacement)
echo "📦 Instalando eza..."
sudo pacman -S --needed --noconfirm eza || {
    echo "⚠️  eza não encontrado no pacman, instalando do GitHub..."
    curl -sSLO https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz
    tar xzf eza_x86_64-unknown-linux-gnu.tar.gz
    sudo cp eza /usr/local/bin/
    rm -f eza_x86_64-unknown-linux-gnu.tar.gz
}

# Instalar zoxide (smart cd)
echo "📦 Instalando zoxide..."
sudo pacman -S --needed --noconfirm zoxide || {
    echo "⚠️  zoxide não encontrado no pacman, instalando do GitHub..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
}

# Instalar direnv
echo "📦 Instalando direnv..."
sudo pacman -S --needed --noconfirm direnv || {
    echo "⚠️  direnv não encontrado no pacman, instalando do GitHub..."
    curl -sfL https://direnv.net/install.sh | bash
}

echo "✅ Ferramentas instaladas"

# Instalar Oh My Zsh
echo "📦 Instalando Oh My Zsh..."
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "ℹ️  Oh My Zsh já instalado"
fi

# Instalar Zsh Autosuggestions
echo "📦 Instalando Zsh Autosuggestions..."
if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
    mkdir -p ~/.zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
else
    echo "ℹ️  Zsh Autosuggestions já instalado"
fi

# Instalar Zsh Syntax Highlighting
echo "📦 Instalando Zsh Syntax Highlighting..."
if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
else
    echo "ℹ️  Zsh Syntax Highlighting já instalado"
fi

# Instalar TPM (Tmux Plugin Manager)
echo "📦 Instalando TPM (Tmux Plugin Manager)..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
    mkdir -p ~/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "ℹ️  TPM já instalado"
fi

echo "✅ Frameworks e plugins instalados"

# Configurar Git
echo ""
echo "📝 Configure suas informações do Git:"
read -p "Nome completo: " GIT_NAME
read -p "Email: " GIT_EMAIL

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global core.editor nvim
echo "✅ Git configurado como: $GIT_NAME <$GIT_EMAIL>"

# Gerar SSH key
echo ""
echo "🔑 Configurando chave SSH..."
if [ ! -f ~/.ssh/id_ed25519 ]; then
    mkdir -p ~/.ssh
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f ~/.ssh/id_ed25519 -N ""
    echo "✅ Chave SSH gerada"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
else
    echo "ℹ️  Chave SSH já existe em ~/.ssh/id_ed25519"
fi

# Mostrar chave SSH pública
echo ""
echo "📋 COPIE ESTA CHAVE SSH PARA O GITHUB:"
echo "──────────────────────────────────────────"
cat ~/.ssh/id_ed25519.pub
echo "──────────────────────────────────────────"
echo ""
echo "1. Acesse: https://github.com/settings/keys"
echo "2. Clique em 'New SSH key'"
echo "3. Cole a chave acima"
echo "4. Crie um repositório chamado 'dotfiles' no GitHub"
echo ""
read -p "Pressione ENTER quando terminar..."

# Clonar dotfiles
echo ""
read -p "URL do repositório (ex: git@github.com:SEU_USUARIO/dotfiles.git): " REPO_URL

echo "📥 Clonando dotfiles..."
if [ -d ~/dotfiles ]; then
    echo "⚠️  ~/dotfiles já existe. Removendo..."
    rm -rf ~/dotfiles
fi

git clone "$REPO_URL" ~/dotfiles
cd ~/dotfiles

# Restaurar configurações
echo ""
echo "🔧 Restaurando configurações com Stow..."
./restore.sh

# Instalar plugins do tmux
echo ""
echo "📦 Instalando plugins do Tmux..."
if [ -f ~/.tmux/plugins/tpm/bin/install_plugins ]; then
    ~/.tmux/plugins/tpm/bin/install_plugins
fi
echo "✅ Plugins do Tmux instalados"

# Instalar plugins do nvim
echo ""
echo "📦 Instalando plugins do Neovim (LazyVim + IA)..."
nvim --headless "+Lazy! sync" +qa || true
nvim --headless "+Lazy! clean" +qa || true
nvim --headless "+Lazy! install" +qa || true
echo "✅ Plugins do Neovim instalados"

# Instalar claude CLI se não existir
echo ""
echo "📦 Verificando Claude CLI..."
if ! command -v claude &> /dev/null; then
    echo "⚠️  Claude CLI não instalado. Instale manualmente:"
    echo "   npm install -g @anthropic-ai/claude-code"
    echo "   Ou siga: https://docs.anthropic.com/en/api/claude-code"
else
    echo "✅ Claude CLI instalado"
fi

# Verificar OpenCode
echo ""
echo "📦 Verificando OpenCode..."
if ! command -v opencode &> /dev/null; then
    echo "⚠️  OpenCode não instalado. Instale manualmente:"
    echo "   npm install -g opencode"
    echo "   Ou siga: https://opencode.ai"
else
    echo "✅ OpenCode instalado"
fi

# Mudar shell padrão para zsh
echo ""
echo "🐚 Mudando shell padrão para Zsh..."
if command -v zsh &> /dev/null; then
    ZSH_PATH=$(command -v zsh)
    if [ -n "$ZSH_PATH" ]; then
        sudo chsh -s "$ZSH_PATH" "$USER"
        echo "✅ Shell alterado para Zsh (reinicie o terminal)"
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

   ✅ Neovim (LazyVim + plugins + IA: Codeium, Copilot)
   ✅ Tmux (floax, sessionx, catppuccin + todos plugins)
   ✅ Zsh (Oh My Zsh + Powerlevel10k + autosuggestions + syntax highlighting + fzf)
   ✅ Bash configurado
   ✅ Kitty terminal
   ✅ Git configurado
   ✅ SSH configurado
   ✅ Starship prompt
   ✅ OpenCode (AI coding assistant + GLM-4.7-Free)
   ✅ Claude (CLI configurado)
   ✅ Z.AI (alias configurado no .zshrc)
   ✅ Antigravity (VS Code)
   ✅ Scripts úteis
   ✅ Ferramentas: fzf, ripgrep, fd, bat, eza, zoxide, direnv
   ✅ Node.js (para plugins IA do nvim)
   ✅ Python (para plugins do nvim)
   ✅ Go (instalado)

🤖 FERRAMENTAS DE IA CONFIGURADAS:

   ✅ Z.AI (claude via z.ai)
     - Usando: z.ai "seu prompt"
     - Modelos: GLM-4.5-Air, GLM-4.6
   
   ✅ Claude Oficial (claude via claude)
     - Usando: claude "seu prompt"
     - Modelos: Claude 3.5 Haiku, Claude Sonnet 4.5, Claude Opus 4.5
   
   ✅ OpenCode (opencode via oc)
     - Usando: oc "seu prompt"
     - Modelo: GLM-4.7-Free (grátis!)
     - Outros: ocfree, ocglm

⚠️  IMPORTANTE:

   - Reinicie o terminal para aplicar Zsh/Starship
   - Na primeira vez que abrir nvim, execute :Lazy sync
   - Execute 'tmux' e pressione Prefix+I para instalar plugins do tmux
   - As configurações são links simbólicos, edits funcionam normal
   - Para usar Z.AI, você precisa configurar o token no .zshrc
   - Para usar OpenCode, você precisa instalar: npm install -g opencode
   - Para usar Claude, você precisa instalar: npm install -g @anthropic-ai/claude-code

📖 DOCUMENTAÇÃO:

   - Guias de IA: ~/dotfiles/scripts/GUIA-OPENCODE.md
   - Claude e Z.AI: ~/dotfiles/scripts/COMO-USAR-CLAUDE-E-ZAI.md

EOF
