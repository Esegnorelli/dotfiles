#!/bin/bash
# Script para iniciar Claude Code com z.ai

export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic"
export ANTHROPIC_AUTH_TOKEN="YOUR-ZAI-API-KEY"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"
export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.6"
export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-4.6"

echo "Iniciando Claude Code com z.ai..."
echo "Base URL: $ANTHROPIC_BASE_URL"
echo "Modelos configurados:"
echo "  - Haiku: $ANTHROPIC_DEFAULT_HAIKU_MODEL"
echo "  - Sonnet: $ANTHROPIC_DEFAULT_SONNET_MODEL"
echo "  - Opus: $ANTHROPIC_DEFAULT_OPUS_MODEL"
echo ""

claude "$@"
