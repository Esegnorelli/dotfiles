# 🚀 Guia Completo - OpenCode

**OpenCode** é um AI coding agent para terminal que pode ajudar a escrever código, resolver problemas e automatizar tarefas de desenvolvimento.

---

## ✅ Instalação Completa!

OpenCode **v1.1.1** instalado com sucesso!

---

## 📋 Comandos Básicos

### Iniciar OpenCode (TUI - Interface de Terminal)
```bash
opencode
```

### Iniciar em um diretório específico
```bash
opencode /caminho/do/projeto
```

### Executar com uma mensagem direta
```bash
opencode run "criar um script python que calcula fibonacci"
```

### Continuar última sessão
```bash
opencode --continue
# ou
opencode -c
```

---

## 🎯 Modelos Disponíveis (Gratuitos)

OpenCode oferece vários modelos gratuitos:

1. **opencode/big-pickle**
2. **opencode/glm-4.7-free** ⭐ (Recomendado - GLM-4.7)
3. **opencode/gpt-5-nano**
4. **opencode/grok-code**
5. **opencode/minimax-m2.1-free**

### Usar um modelo específico:
```bash
opencode -m opencode/glm-4.7-free
```

---

## 🔐 Autenticação

OpenCode suporta vários provedores de IA:

### Ver provedores configurados:
```bash
opencode auth list
```

### Login em um provedor:
```bash
opencode auth login
# Ou especificar provedor:
opencode auth login anthropic
opencode auth login openai
```

### Logout:
```bash
opencode auth logout
```

### Arquivo de credenciais:
```
~/.local/share/opencode/auth.json
```

---

## 🌐 Modo Servidor (Headless)

### Iniciar servidor OpenCode:
```bash
opencode serve
# ou
opencode web
```

### Conectar a um servidor remoto:
```bash
opencode attach http://servidor:porta
```

---

## 💡 Recursos Avançados

### 1. **Gerenciar Agentes**
```bash
opencode agent
```

### 2. **Estatísticas de Uso**
```bash
opencode stats
```

### 3. **Exportar/Importar Sessões**
```bash
# Exportar
opencode export [sessionID]

# Importar
opencode import arquivo.json
```

### 4. **Integração com GitHub**
```bash
# Gerenciar GitHub agent
opencode github

# Trabalhar em um PR específico
opencode pr 123
```

### 5. **Gerenciar Sessões**
```bash
opencode session
```

---

## ⚙️ Configuração Personalizada

### Arquivo de configuração:
```bash
~/.local/share/opencode/
```

### Opções de linha de comando:

```bash
opencode \
  --model opencode/glm-4.7-free \
  --agent custom-agent \
  --prompt "meu prompt personalizado" \
  --log-level DEBUG \
  /caminho/projeto
```

---

## 🎨 Exemplos de Uso

### 1. Criar um script Python:
```bash
opencode run "criar um script que lê CSV e gera gráficos"
```

### 2. Debugar código:
```bash
opencode run "encontrar e corrigir bugs no arquivo main.py"
```

### 3. Refatorar código:
```bash
opencode run "refatorar este código para usar async/await"
```

### 4. Escrever testes:
```bash
opencode run "escrever testes unitários para todas as funções"
```

### 5. Documentação:
```bash
opencode run "adicionar docstrings em todas as funções"
```

---

## 🔧 Completions para Shell

### Bash:
```bash
opencode completion bash >> ~/.bashrc
source ~/.bashrc
```

### Zsh:
```bash
opencode completion zsh >> ~/.zshrc
source ~/.zshrc
```

### Fish:
```bash
opencode completion fish > ~/.config/fish/completions/opencode.fish
```

---

## 🆚 OpenCode vs Claude Code

| Recurso | OpenCode | Claude Code |
|---------|----------|-------------|
| **Interface** | TUI + CLI | CLI + Web |
| **Modelos Grátis** | ✅ Vários | ❌ Requer assinatura |
| **GitHub Integration** | ✅ Built-in | Via MCP |
| **ACP Server** | ✅ Sim | ❌ Não |
| **Multi-provider** | ✅ Sim | ❌ Só Anthropic |
| **Modo Web** | ✅ Sim | ❌ Não |

---

## 📊 Modo de Desenvolvimento

### Ver logs detalhados:
```bash
opencode --print-logs --log-level DEBUG
```

### Porta personalizada:
```bash
opencode --port 8080
```

### Permitir acesso externo:
```bash
opencode --hostname 0.0.0.0 --port 8080
```

### Habilitar mDNS:
```bash
opencode --mdns
```

---

## 🚀 Início Rápido

### Para começar agora:

1. **Modo interativo (recomendado para iniciantes):**
   ```bash
   opencode
   ```

2. **Com modelo GLM-4.7 (grátis):**
   ```bash
   opencode -m opencode/glm-4.7-free
   ```

3. **Executar tarefa direta:**
   ```bash
   opencode run "sua tarefa aqui"
   ```

---

## 📚 Comandos de Ajuda

```bash
opencode --help              # Ajuda geral
opencode auth --help         # Ajuda de autenticação
opencode run --help          # Ajuda do comando run
opencode models --help       # Ajuda de modelos
```

---

## 🎯 Dicas Úteis

1. **Use modelos gratuitos** para testar sem custos
2. **Continue sessões** com `-c` para manter contexto
3. **Export/import** sessões para compartilhar ou backup
4. **GitHub integration** para trabalhar direto em PRs
5. **Servidor mode** para acessar remotamente

---

## 📝 Aliases Úteis (Opcional)

Adicione ao `~/.bashrc`:

```bash
# OpenCode shortcuts
alias oc='opencode'
alias ocrun='opencode run'
alias ocfree='opencode -m opencode/glm-4.7-free'
alias ocglm='opencode -m opencode/glm-4.7-free'
alias occ='opencode --continue'
```

Depois:
```bash
source ~/.bashrc
```

---

## 🔄 Atualização

```bash
opencode upgrade         # Última versão
opencode upgrade 1.2.0   # Versão específica
```

---

## 🗑️ Desinstalação

```bash
# Remover OpenCode e todos os arquivos
opencode uninstall

# Ou via pacman:
sudo pacman -Rns opencode-bin
```

---

## 🎉 Pronto para Usar!

Experimente agora:
```bash
opencode -m opencode/glm-4.7-free
```

Divirta-se codificando com IA! 🚀
