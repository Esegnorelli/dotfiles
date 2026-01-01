#!/bin/bash
# Script para usar GLM API

cat > ~/.claude/settings.json << 'EOF'
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://open.bigmodel.cn/api/paas/v4",
    "ANTHROPIC_API_KEY": "d86b6e08aa434387a9c9393e816c74bd.gguR0XjQxXo5w2V8"
  }
}
EOF

echo "✅ Configurado para usar GLM API"
echo "Modelo: GLM-4.7 (compatível com Claude Code)"
