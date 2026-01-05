#!/bin/bash

# Script para sincronizar mudanças dos dotfiles para GitHub
set -e

cat << "EOF"
╔═════════════════════════════════════════════════════════════╗
║         SINCRONIZAR DOTFILES PARA GITHUB                    ║
╚═════════════════════════════════════════════════════════════╝

EOF

# Ir para diretório dotfiles
cd ~/dotfiles

# Verificar status do git
echo "📊 Status atual:"
git status --short

# Pedir mensagem de commit
echo ""
echo "📝 Descreva as mudanças:"
read -p "Mensagem do commit: " COMMIT_MESSAGE

if [ -z "$COMMIT_MESSAGE" ]; then
    echo "❌ Mensagem de commit vazia. Abortando."
    exit 1
fi

# Adicionar todas as mudanças
echo ""
echo "📦 Adicionando mudanças..."
git add .

# Commit
echo "📝 Criando commit..."
git commit -m "$COMMIT_MESSAGE"

# Push
echo ""
echo "📤 Enviando para GitHub..."
if git push; then
    echo ""
    echo "✅ SUCESSO! Dotfiles sincronizados!"
else
    echo ""
    echo "⚠️  Erro ao fazer push. Tentando push --force..."
    read -p "Deseja fazer force push? (s/N): " FORCE_PUSH
    if [ "$FORCE_PUSH" = "s" ] || [ "$FORCE_PUSH" = "S" ]; then
        git push --force
        echo "✅ Force push realizado!"
    else
        echo "❌ Push não realizado."
        exit 1
    fi
fi

echo ""
echo "📦 Resumo:"
echo "   - Commit: $(git log -1 --oneline)"
echo "   - Branch: $(git branch --show-current)"
echo ""
echo "🔄 Para atualizar no PC do trabalho:"
echo "   cd ~/dotfiles && git pull && ./restore.sh"
