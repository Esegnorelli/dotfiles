# Como Usar Claude Code e z.ai Simultaneamente

## ✅ Configuração Completa!

Agora você pode usar ambos sem conflitos. Veja como:

---

## 📌 Comandos Disponíveis

### 1. Claude Code Oficial (Anthropic)
```bash
claude-normal
```
- Usa autenticação OAuth da Anthropic
- Modelos oficiais: Claude Sonnet 4.5, Opus 4.5, Haiku
- Sem limite de tokens (depende da sua assinatura)

### 2. Claude Code com z.ai
```bash
claude-zai
```
- Usa z.ai API
- Modelos GLM:
  - Haiku → glm-4.5-air
  - Sonnet → glm-4.6
  - Opus → glm-4.6
- API Key configurada automaticamente

---

## 🔧 Uso Simultâneo

### Terminal 1:
```bash
claude-normal
```

### Terminal 2 (ao mesmo tempo):
```bash
claude-zai
```

**Sem conflitos!** Cada comando usa suas próprias configurações isoladas.

---

## 📂 Arquivos de Configuração

- **Claude Normal**: `~/.claude/settings.local.json`
- **Claude + z.ai**: `~/.claude/config-zai.json`

### config-zai.json atual:
```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.z.ai/api/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "e81d209ce9ff493daaeb6f747de0b44b.u6QnO4jSwaZGaQ6S",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "glm-4.5-air",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "glm-4.6",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "glm-4.6"
  }
}
```

---

## 🎯 Aliases Opcionais (Adicione ao ~/.bashrc)

```bash
# Atalhos para Claude
alias cc='claude-normal'           # Claude normal
alias cz='claude-zai'              # Claude + z.ai
alias cchat='claude-normal chat'    # Chat mode normal
alias czhat='claude-zai chat'      # Chat mode z.ai
```

Depois execute:
```bash
source ~/.bashrc
```

---

## 🔍 Verificar Qual Está Rodando

```bash
# Ver processos Claude ativos
ps aux | grep claude

# Ver configurações carregadas
claude-zai --help  # Mostra info do z.ai
claude-normal --help  # Mostra info do oficial
```

---

## ❗ Solução de Problemas

### Erro 401 "token expired or incorrect"
- Seu token z.ai pode ter expirado
- Gere um novo em: https://z.ai
- Atualize em: `~/.claude/config-zai.json`

### Ambos usando a mesma API
- Use `claude-normal` e `claude-zai` em vez de apenas `claude`
- O comando `claude` sozinho pode herdar variáveis de ambiente

### Token não reconhecido
- Verifique se o arquivo `config-zai.json` está correto
- Execute: `cat ~/.claude/config-zai.json`

---

## 📊 Comparação Rápida

| Recurso | claude-normal | claude-zai |
|---------|---------------|------------|
| API | Anthropic oficial | z.ai (GLM) |
| Autenticação | OAuth/Web | API Key |
| Modelos | Claude Sonnet 4.5, Opus 4.5 | GLM-4.6, GLM-4.5-air |
| Custo | Assinatura Anthropic | Créditos z.ai |
| Limite | Baseado em plano | Baseado em créditos |

---

## 🎉 Pronto!

Agora você pode usar ambos simultaneamente sem conflitos!

Para ajuda:
- Claude normal: `claude-normal --help`
- Claude z.ai: `claude-zai --help`
