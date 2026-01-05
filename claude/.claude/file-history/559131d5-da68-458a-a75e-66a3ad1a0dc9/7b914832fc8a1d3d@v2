#!/bin/bash
# Script para resolver conflitos entre Claude Code e z.ai

echo "=== Diagnóstico de Conflito entre CLIs ==="
echo ""

# Verificar onde está o z.ai
echo "1. Procurando z.ai no sistema..."
ZAI_PATH=$(which zai z.ai 2>/dev/null | head -1)
if [ -n "$ZAI_PATH" ]; then
    echo "   z.ai encontrado em: $ZAI_PATH"
else
    echo "   z.ai não encontrado no PATH"
    echo "   Verificando instalações alternativas..."
    find ~ -name "*zai*" -type f -executable 2>/dev/null | grep -v node_modules | head -5
fi

echo ""
echo "2. Verificando arquivos de configuração..."
echo "   Claude Code:"
ls -la ~/.config/claude* ~/.anthropic* 2>/dev/null || echo "   Nenhum arquivo de config encontrado"

echo ""
echo "   z.ai:"
ls -la ~/.config/zai* ~/.config/z.ai* ~/.zai* 2>/dev/null || echo "   Nenhum arquivo de config encontrado"

echo ""
echo "3. Variáveis de ambiente de API:"
env | grep -E "ANTHROPIC|CLAUDE|ZAI|API.*KEY" | grep -v SUDO

echo ""
echo "4. Processos ativos:"
ps aux | grep -E "(claude|zai|z\.ai)" | grep -v grep

echo ""
echo "=== Solução Recomendada ==="
echo ""
echo "Para evitar conflitos, use um dos métodos abaixo:"
echo ""
echo "MÉTODO 1 - Aliases separados no shell:"
echo "  Adicione ao seu ~/.bashrc:"
echo "  alias claude-ai='claude'"
echo "  alias z-ai='ZAI_CONFIG_DIR=~/.config/zai zai'"
echo ""
echo "MÉTODO 2 - Scripts wrapper:"
echo "  Use scripts separados que definem suas próprias variáveis de ambiente"
echo ""
echo "MÉTODO 3 - Variáveis de ambiente por sessão:"
echo "  Terminal 1 (Claude): export ANTHROPIC_API_KEY=sua_chave_claude"
echo "  Terminal 2 (z.ai): export ZAI_API_KEY=sua_chave_zai"
echo ""
echo "Execute este script para ver o diagnóstico completo:"
echo "  bash ~/fix-cli-conflict.sh"
