#!/bin/bash

# Script para sincronizar mudanças nos dotfiles
set -e

echo "🔄 Sincronizando dotfiles..."

cd ~/dotfiles

# Verificar se é um repositório git
if [ ! -d .git ]; then
    echo "❌ Este não é um repositório git."
    echo "Execute primeiro: cd ~/dotfiles && git init"
    exit 1
fi

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
echo "📝 Escreva a mensagem do commit:"
read -r COMMIT_MSG

# Validar mensagem do commit
if [ -z "$COMMIT_MSG" ]; then
    echo "❌ Mensagem do commit não pode estar vazia"
    exit 1
fi

git commit -m "$COMMIT_MSG"

# Push
echo "📤 Enviando para GitHub..."
if git push 2>&1 | grep -q "fatal:.*upstream"; then
    echo "⚠️  Upstream não configurado. Definindo..."
    git branch -M main
    git push -u origin main
elif git push; then
    echo "✅ Push bem-sucedido!"
fi

echo "✅ Sincronizado com sucesso!"
