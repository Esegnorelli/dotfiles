# ⚡ QUICKSTART - Comece Aqui!

Guia rápido para configurar seu ambiente de desenvolvimento em **5 minutos**.

## 🎯 Caminho Recomendado (Pop!_OS/Ubuntu)

### Opção 1: Setup Completo Automatizado (Recomendado)

```bash
cd ~/documentos/github/dotfiles

# 1. Setup do Neovim + LazyVim (tudo automatizado)
make nvim

# 2. Otimizar Pop!_OS (ferramentas modernas CLI)
make optimize

# 3. Verificar se está tudo OK
make health
```

### Opção 2: Passo a Passo Manual

```bash
cd ~/documentos/github/dotfiles

# 1. Atualizar Neovim para versão moderna (>= 0.10.0)
sudo ./scripts/update-neovim.sh

# 2. Instalar todas as dependências (Node, Go, ripgrep, fzf, etc)
sudo ./scripts/install-dependencies.sh

# 3. Configurar LazyVim completo
./scripts/setup-lazyvim.sh

# 4. Abrir Neovim (vai instalar plugins na primeira vez - demora!)
nvim
# Aguarde 2-3 minutos na primeira vez, depois feche e abra novamente

# 5. (Opcional) Otimizar sistema com ferramentas modernas
sudo ./scripts/optimize-popos.sh
```

## 🚀 Primeira Vez no Neovim?

Após rodar os scripts acima:

1. **Abra o Neovim**: `nvim`
2. **Aguarde** - Plugins estão instalando (2-3 minutos)
3. **Feche e abra novamente** - `Ctrl+C` depois `nvim`
4. **Verifique saúde**: Digite `:checkhealth`
5. **Instale LSPs**: Digite `:Mason` e instale language servers

## ⌨️ Atalhos Essenciais do Neovim

**Leader = Espaço**

```
Space + ff  → Buscar arquivos (Telescope)
Space + fg  → Buscar texto (grep)
Space + e   → Explorador de arquivos
Space + l   → Lazy (gerenciar plugins)
:Mason      → Gerenciar LSPs/formatters
:checkhealth → Verificar saúde
```

## 🛠️ O que cada script faz?

| Script | Descrição | Requer sudo? |
|--------|-----------|--------------|
| `update-neovim.sh` | Atualiza Neovim via PPA (>= 0.10.0) | ✓ Sim |
| `install-dependencies.sh` | Instala Node, Go, ripgrep, fzf, etc | ✓ Sim |
| `setup-lazyvim.sh` | Configura LazyVim do zero | ✗ Não |
| `optimize-popos.sh` | Ferramentas modernas CLI + otimizações | ✓ Sim |

## 📋 Checklist de Setup

- [ ] Neovim >= 0.10.0 instalado
- [ ] Dependências instaladas (rg, fd, fzf, node, go)
- [ ] LazyVim configurado
- [ ] Plugins instalados (abriu nvim e aguardou)
- [ ] `:checkhealth` sem erros críticos
- [ ] LSPs instalados via `:Mason`
- [ ] (Opcional) Sistema otimizado com `optimize-popos.sh`

## 🔧 Comandos Make Úteis

```bash
make help      # Ver todos os comandos disponíveis
make nvim      # Setup completo do Neovim (interativo)
make optimize  # Otimizar Pop!_OS (interativo)
make health    # Verificar saúde do setup
make backup    # Criar backup das configs
make test      # Testar configurações
```

## 🐛 Problemas Comuns

### Neovim muito antigo

```bash
nvim --version  # Verificar versão
# Se < 0.10.0:
sudo ./scripts/update-neovim.sh
```

### Plugins não carregam

```bash
# Limpar tudo e reinstalar
rm -rf ~/.local/share/nvim ~/.cache/nvim
nvim  # Aguardar reinstalação
```

### LSP não funciona

```bash
nvim
:Mason
# Instalar manualmente: typescript-language-server, lua-language-server, etc
```

## 🎨 Configuração Extra (Opcional)

### Kitty Terminal

```bash
sudo apt install kitty fonts-jetbrains-mono
ln -sf ~/documentos/github/dotfiles/config/kitty ~/.config/kitty
kitty
```

### Helix Editor (Alternativa ao Neovim)

```bash
sudo apt install helix
ln -sf ~/documentos/github/dotfiles/config/helix ~/.config/helix
hx
```

## 📚 Próximos Passos

Depois do setup básico:

1. **Explore LazyVim Extras**: Digite `:LazyExtras` no Neovim
2. **Configure Git**:
   ```bash
   git config --global user.name "Seu Nome"
   git config --global user.email "seu@email.com"
   ```
3. **Customize**: Adicione plugins em `config/nvim/lua/plugins/`
4. **Aprenda Vim**: Execute `vimtutor` no terminal

## 💡 Dicas

- **Starship Prompt**: Instalado via `optimize-popos.sh` - reinicie o terminal
- **Zoxide**: CD inteligente - use `z <dir>` após navegar algumas vezes
- **Aliases**: Veja `~/.bash_aliases` para atalhos úteis
- **Bat**: Use `cat` para syntax highlighting automático
- **Eza**: Use `ll` ou `la` para listar com ícones

## 🆘 Precisa de Ajuda?

- **LazyVim**: https://www.lazyvim.org/
- **Neovim**: `:help` dentro do Neovim
- **Verificar saúde**: `:checkhealth`
- **Este repo**: Veja o README.md completo

---

**TL;DR**: Execute `make nvim` e depois `make optimize`. Pronto! 🎉
