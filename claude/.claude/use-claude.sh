#!/bin/bash
# Script para usar Claude/Anthropic API oficial

cat > ~/.claude/settings.json << 'EOF'
{
  "env": {}
}
EOF

echo "✅ Configurado para usar Claude/Anthropic API"
echo "⚠️  Certifique-se de ter uma API key da Anthropic configurada"
echo "Configure com: export ANTHROPIC_API_KEY=sua-chave-anthropic"
