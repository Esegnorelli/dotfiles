#!/bin/bash

# Guia rápido para configurar dotfiles
set -e

cat << "EOF"
╔══════════════════════════════════════════════════════════╗
║           DOTFILES - Configuração Automática             ║
╚══════════════════════════════════════════════════════════╝

Este script vai configurar:
  ✅ SSH key para GitHub
  ✅ Repositório Git
  ✅ Estrutura de Dotfiles com GNU Stow
  ✅ Scripts de backup e restauração

EOF

echo "🚀 Iniciando configuração..."

# Verificar dependências
for cmd in git stow ssh; do
    if ! command -v $cmd &> /dev/null; then
        echo "❌ $cmd não instalado. Instale com: sudo pacman -S git stow openssh"
        exit 1
    fi
done

echo "✅ Dependências encontradas"

# Configurar Git
echo ""
echo "📝 Configure suas informações do Git:"
read -p "Nome completo: " GIT_NAME
read -p "Email: " GIT_EMAIL

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
echo "✅ Git configurado como: $GIT_NAME <$GIT_EMAIL>"

# Gerar SSH key
echo ""
echo "🔑 Configurando chave SSH..."
if [ ! -f ~/.ssh/id_ed25519 ]; then
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

# Perguntar URL do repositório
echo ""
read -p "URL do repositório (ex: git@github.com:usuario/dotfiles.git): " REPO_URL

# Inicializar git
cd ~/dotfiles
git init
git add .
git commit -m "Initial commit: dotfiles setup with stow"

# Adicionar remote
git remote add origin "$REPO_URL"
git branch -M main

# Push
echo ""
echo "📤 Enviando para GitHub..."
if git push -u origin main; then
    echo ""
    echo "✅ SUCESSO! Dotfiles configurados e enviados!"
else
    echo ""
    echo "❌ Erro ao fazer push. Verifique sua chave SSH e tente novamente."
    exit 1
fi

echo ""
cat << "EOF"

═══════════════════════════════════════════════════════════════════
  🎉 CONFIGURAÇÃO CONCLUÍDA!
═══════════════════════════════════════════════════════════════════

📦 RESTAURAR NO PC DO TRABALHO:

  1. Clone o repositório:
     git clone git@github.com:SEU_USUARIO/dotfiles.git ~/dotfiles

  2. Execute o script de restauração:
     cd ~/dotfiles
     ./restore.sh

🔄 SINCRONIZAR MUDANÇAS:

  cd ~/dotfiles
  ./sync.sh

📝 ADICIONAR NOVA CONFIGURAÇÃO:

  1. Mova arquivos para a pasta apropriada
  2. Execute: cd ~/dotfiles && ./sync.sh

EOF
