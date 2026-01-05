#!/bin/bash

# Script para copiar dotfiles para pen drive
set -e

cat << "EOF"
╔═════════════════════════════════════════════════════════════╗
║           COPIAR DOTFILES PARA PEN DRIVE                    ║
╚═════════════════════════════════════════════════════════════╝

Este script vai:
  1. Sincronizar mudanças com GitHub
  2. Copiar dotfiles para pen drive
  3. Criar script de instalação no pen drive

EOF

# Sincronizar com GitHub primeiro
echo "🔄 Sincronizando com GitHub..."
cd ~/dotfiles
./sync.sh

# Detectar pen drive
echo ""
echo "🔍 Procurando pen drive..."

PEN_DRIVE=""
for mount in /media/*/*/ /run/media/*/*/; do
    if [ -d "$mount" ] && [ "$(df -h "$mount" 2>/dev/null | tail -1 | awk '{print $1}')" != "Filesystem" ]; then
        PEN_DRIVE="$mount"
        break
    fi
done

if [ -z "$PEN_DRIVE" ]; then
    echo "❌ Pen drive não encontrado. Certifique-se de que está montado."
    exit 1
fi

echo "✅ Pen drive encontrado: $PEN_DRIVE"

# Verificar espaço
AVAILABLE=$(df -BG "$PEN_DRIVE" | tail -1 | awk '{print $4}')
echo "💾 Espaço disponível: ${AVAILABLE}G"

DOTFILES_SIZE=$(du -sh ~/dotfiles 2>/dev/null | awk '{print $1}')
echo "📦 Tamanho dos dotfiles: $DOTFILES_SIZE"

# Confirmar
echo ""
read -p "Continuar? (s/n): " CONFIRM
if [ "$CONFIRM" != "s" ]; then
    echo "❌ Cancelado."
    exit 0
fi

# Copiar dotfiles
echo ""
echo "📥 Copiando dotfiles para pen drive..."

if [ -d "$PEN_DRIVE/dotfiles" ]; then
    echo "🧹 Removendo cópia antiga..."
    rm -rf "$PEN_DRIVE/dotfiles"
fi

rsync -av --progress ~/dotfiles/ "$PEN_DRIVE/dotfiles/" \
    --exclude '.git' \
    --exclude 'node_modules' \
    --exclude '.cache' \
    --exclude '*.pyc' \
    --exclude '__pycache__'

echo "✅ Dotfiles copiados!"

# Criar script de instalação no pen drive
cat > "$PEN_DRIVE/instalar.sh" << 'INSTALL_SCRIPT'
#!/bin/bash

# Script para instalar dotfiles do pen drive
set -e

echo "📦 Instalando dotfiles do pen drive..."

# Verificar se pen drive está montado
PEN_MOUNT=$(dirname "$(readlink -f "$0")")
DOTFILES="$PEN_MOUNT/dotfiles"

if [ ! -d "$DOTFILES" ]; then
    echo "❌ Dotfiles não encontrados em $DOTFILES"
    exit 1
fi

# Copiar para home
echo "📥 Copiando dotfiles para home..."
if [ -d ~/dotfiles ]; then
    echo "⚠️  ~/dotfiles já existe. Removendo..."
    rm -rf ~/dotfiles
fi

cp -r "$DOTFILES" ~/dotfiles

# Instalar dependências (Arch)
if command -v pacman &> /dev/null; then
    echo "📦 Instalando dependências..."
    sudo pacman -S --needed --noconfirm \
        git stow openssh \
        neovim tmux zsh \
        fzf ripgrep fd bat \
        nodejs npm \
        python python-pip \
        go \
        starship \
        kitty
fi

# Restaurar configurações
echo ""
echo "🔧 Restaurando configurações..."
cd ~/dotfiles
./restore.sh

# Instalar plugins nvim
echo ""
echo "📦 Instalando plugins do nvim..."
nvim --headless "+Lazy! sync" +qa

# Mudar shell padrão
if command -v zsh &> /dev/null; then
    echo ""
    read -p "Mudar shell padrão para Zsh? (s/n): " CHANGE_SHELL
    if [ "$CHANGE_SHELL" = "s" ]; then
        chsh -s $(which zsh)
        echo "✅ Shell alterado para Zsh"
    fi
fi

echo ""
echo "✅ Instalação concluída!"
echo "Reinicie o terminal para aplicar as mudanças."
INSTALL_SCRIPT

chmod +x "$PEN_DRIVE/instalar.sh"

# Criar README no pen drive
cat > "$PEN_DRIVE/LEIA-ME.txt" << 'README'
╔═════════════════════════════════════════════════════════════╗
║              DOTFILES - PEN DRIVE                            ║
╚═════════════════════════════════════════════════════════════╝

📦 CONTEÚDO:
  - dotfiles/          # Todos os seus arquivos de configuração
  - instalar.sh        # Script de instalação automática

🚀 INSTALAÇÃO:

  1. Monte este pen drive
  2. Execute:
     ./instalar.sh

📂 PACOTES INCLUÍDOS:

  ✅ Neovim (editor de código completo)
     - LazyVim
     - Plugins de IA (Codeium, Copilot)
     - Formatação automática
     - Sintaxe colorida (treesitter)

  ✅ Tmux (multiplicador de terminal)
     - Plugins: floax, sessionx, catppuccin
     - Persistência de sessões

  ✅ Zsh (shell)
     - Oh My Zsh
     - Powerlevel10k (tema)
     - Fzf (busca fuzzy)

  ✅ Kitty (terminal moderno)
     - Configurações otimizadas

  ✅ Git
     - Configuração global

  ✅ Starship (prompt)
     - Prompt colorido e informativo

  ✅ OpenCode (assistant de código)
     - Configurações do OpenCode AI

  ✅ Claude
     - Configurações do Claude AI

  ✅ Antigravity
     - Configurações do VS Code

  ✅ Scripts úteis
     - Scripts de automação

💻 USO APÓS INSTALAÇÃO:

  1. Reinicie o terminal para aplicar Zsh/Starship
  2. Abra nvim: nvim
  3. Execute: :Lazy sync
  4. Abra tmux: tmux
  5. Pressione: Prefix + I (para instalar plugins)

🔄 ATUALIZAÇÃO:

  Para atualizar suas configurações:
  cd ~/dotfiles
  ./sync.sh

  Isso envia as mudanças para GitHub.

📱 SINCRONIZAÇÃO ENTRE PC CASA E TRABALHO:

  PC CASA → GITHUB:
    cd ~/dotfiles && ./sync.sh

  PC TRABALHO ← GITHUB:
    cd ~/dotfiles && git pull

  Ou use o pen drive para cópia direta!

╚═════════════════════════════════════════════════════════════╝
README

echo ""
echo "✅ Script de instalação criado no pen drive"

# Mostrar resumo
echo ""
cat << "EOF"
╔═════════════════════════════════════════════════════════════╗
║  ✅ DOTFILES COPIADOS PARA PEN DRIVE!                       ║
╚═════════════════════════════════════════════════════════════╝

📦 O que foi copiado:
  ✅ Neovim + LazyVim + Plugins
  ✅ Tmux + Todos os plugins
  ✅ Zsh + Oh My Zsh + Powerlevel10k
  ✅ Kitty terminal
  ✅ Git configurado
  ✅ Starship prompt
  ✅ OpenCode (configurações)
  ✅ Claude (configurações)
  ✅ Antigravity (configurações)
  ✅ Scripts úteis
  ✅ Scripts de instalação

💻 NO PC DO TRABALHO:

  Opção 1 - Via Pen Drive:
    1. Insira o pen drive
    2. Execute: ./instalar.sh

  Opção 2 - Via GitHub:
    git clone git@github.com:Esegnorelli/dotfiles.git ~/dotfiles
    cd ~/dotfiles && ./setup-work.sh

🔄 Para atualizar:
  cd ~/dotfiles && ./sync.sh

EOF
