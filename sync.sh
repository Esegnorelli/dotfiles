#!/bin/bash

# Script para sincronizar mudanças nos dotfiles
set -e

echo "🔄 Sincronizando dotfiles..."

cd ~/dotfiles

# Verificar mudanças
if git diff --quiet && git diff --cached --quiet; then
    echo "ℹ️  Não há mudanças para sincronizar"
    exit 0
fi

# Mostrar mudanças
echo "📋 Mudanças:"
git status -s
echo ""

# Commit
git add -A
read -p "Mensagem do commit: " COMMIT_MSG
git commit -m "$COMMIT_MSG"

# Push
echo "📤 Enviando para GitHub..."
git push

echo "✅ Sincronizado com sucesso!"
