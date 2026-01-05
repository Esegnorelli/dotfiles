#!/bin/bash
# Script para configurar dotfiles após adicionar chave SSH no GitHub

set -e

echo "🚀 Configurando dotfiles para esegnorelli..."

# Inicializar git no dotfiles
cd ~/dotfiles
if [ ! -d .git ]; then
    git init
    echo "✅ Git inicializado"
else
    echo "ℹ️  Git já inicializado"
fi

# Configurar remote
echo ""
echo "📝 Insira a URL do seu repositório GitHub:"
read -p "Exemplo: git@github.com:esegnorelli/dotfiles.git: " REPO_URL

# Remover remote existente se houver
if git remote get-url origin &> /dev/null; then
    git remote remove origin
fi

# Adicionar remote
git remote add origin "$REPO_URL"
echo "✅ Remote configurado"

# Fazer commit inicial
if ! git rev-parse HEAD &> /dev/null; then
    git add .
    git commit -m "Initial commit: dotfiles setup - esegnorelli"
    echo "✅ Commit inicial criado"
else
    echo "ℹ️  Commit já existe, fazendo commit de mudanças..."
    git add .
    git commit -m "Update: dotfiles changes" || echo "Nenhuma mudança nova"
fi

# Push para GitHub
echo ""
echo "📤 Enviando para GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "✅ SUCESSO! Dotfiles enviados para GitHub!"
echo ""
echo "💻 Para usar no PC do trabalho:"
echo "   git clone git@github.com:esegnorelli/dotfiles.git ~/dotfiles"
echo "   cd ~/dotfiles && ./setup-work.sh"
