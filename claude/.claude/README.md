# Claude Code - Configuração Multi-Provider

## Configuração Atual: GLM (Zhipu AI)

Você está usando o **GLM Coding Lite** com modelo GLM-4.7, compatível com Claude Code.

## Como trocar entre providers

### Opção 1: Usando scripts (recomendado)
```bash
use-glm      # Usar GLM API (Zhipu AI)
use-claude   # Usar Claude API oficial (Anthropic)
```

### Opção 2: Manual (editando ~/.zshrc)
Comente/descomente as linhas na seção "CLAUDE API PROVIDERS":

```bash
# Para GLM:
export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/paas/v4"
export ANTHROPIC_API_KEY="sua-chave-glm"

# Para Claude oficial:
# export ANTHROPIC_BASE_URL=""  # vazio ou remover
# export ANTHROPIC_API_KEY="sua-chave-anthropic"
```

## Verificar configuração atual

```bash
echo "URL: $ANTHROPIC_BASE_URL"
echo "Key: ${ANTHROPIC_API_KEY:0:20}..."
```

## Testar conexão

```bash
claude -p "teste de conexão"
```

## Informações do Plano GLM

- **Plano:** GLM Coding Lite (Monthly)
- **Uso:** 3× do Claude Pro
- **Modelo:** GLM-4.7
- **Compatível com:** Claude Code, Cursor, Cline, Kilo Code, etc.

## Segurança

⚠️ **NUNCA** compartilhe suas API keys publicamente!
⚠️ Se expor uma key acidentalmente, regenere imediatamente em: https://open.bigmodel.cn
