# 🚀 Dotfiles - Setup de Desenvolvimento

Configurações prontas para produtividade máxima. Neovim moderno + Terminal poderoso + Shell configurado.

## 📦 O que tem aqui?

- **Neovim** - LazyVim configurado com LSP, Treesitter, Telescope
- **Kitty** - Terminal rápido com transparência e tema Catppuccin
- **Zsh** - Shell configurado (adicione seu framework preferido)
- **Helix** - Editor alternativo (opcional)

## ⚡ Instalação Rápida

### 1. Neovim (Recomendado começar por aqui)

```bash
# Atualizar Neovim para versão moderna (>= 0.10.0)
sudo ./scripts/update-neovim.sh

# Instalar todas as dependências (Node, Go, LSPs, etc)
sudo ./scripts/install-dependencies.sh

# Configurar LazyVim completo
./scripts/setup-lazyvim.sh

# Abrir e aguardar instalação dos plugins (demora na primeira vez!)
nvim
```

**Primeira vez no Neovim?**
- Aguarde alguns minutos - plugins estão instalando
- Depois feche e abra novamente
- Execute `:checkhealth` para verificar

### 2. Kitty Terminal (Opcional)

```bash
# Instalar Kitty e fonte
sudo apt install kitty fonts-jetbrains-mono

# Linkar configuração
ln -sf ~/documentos/github/dotfiles/config/kitty ~/.config/kitty

# Abrir
kitty
```

### 3. Outras ferramentas

```bash
# Helix editor
sudo apt install helix
ln -sf ~/documentos/github/dotfiles/config/helix ~/.config/helix
```

## 🗂️ Estrutura

```
dotfiles/
├── config/
│   ├── nvim/           # LazyVim - Editor principal
│   ├── kitty/          # Terminal emulator
│   ├── zsh/            # Shell
│   └── helix/          # Editor alternativo
├── scripts/
│   ├── update-neovim.sh         # Atualiza Neovim via PPA
│   ├── install-dependencies.sh  # Instala tudo (Node, Go, LSPs)
│   ├── setup-lazyvim.sh         # Configura LazyVim do zero
│   └── setup-neovim.sh          # Script antigo (usar os 3 acima)
└── themes/             # Temas extras do Kitty
```

## ⌨️ Atalhos Essenciais

### Neovim (LazyVim)

**Leader = `Space`**

| Atalho | Ação |
|--------|------|
| `<leader>ff` | Buscar arquivos (Telescope) |
| `<leader>fg` | Buscar texto (grep) |
| `<leader>e` | Explorador de arquivos |
| `<leader>l` | Lazy (gerenciar plugins) |
| `:Mason` | Gerenciar LSPs/formatters |
| `:checkhealth` | Verificar saúde do Neovim |

**Navegação**
- `Ctrl+h/j/k/l` - Navegar entre splits
- `Shift+h/l` - Buffer anterior/próximo
- `gcc` - Comentar linha
- `gd` - Go to definition
- `K` - Hover documentation

### Kitty Terminal

| Atalho | Ação |
|--------|------|
| `Ctrl+Shift+T` | Nova tab |
| `Ctrl+Shift+Enter` | Nova janela (split) |
| `Ctrl+H/J/K/L` | Navegar splits (vim-like) |
| `Ctrl+Shift+\` | Split vertical |
| `Ctrl+Shift+-` | Split horizontal |
| `Ctrl+Shift+F5` | Recarregar config |

## 🔧 Dependências

### Essenciais para Neovim

```bash
# Instaladas automaticamente pelo install-dependencies.sh
- neovim >= 0.10.0
- git
- ripgrep (rg)
- fd-find
- fzf
- nodejs + npm
- python3 + pip
- go
- shellcheck
```

### Fontes

```bash
# Ubuntu/Pop!_OS
sudo apt install fonts-jetbrains-mono

# Ou Nerd Font completa:
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv
```

## 🎨 Temas

### Neovim
- **Padrão**: TokyoNight Night
- Mudar em: `config/nvim/lua/plugins/lazyvim.lua`

### Kitty
- **Padrão**: Catppuccin Mocha
- **Alternativos**: `themes/tokyo-night-kitty.conf`, `themes/dracula-kitty.conf`
- Mudar em: `config/kitty/kitty.conf` → linha `include theme.conf`

## 🐛 Troubleshooting

### Neovim não abre / erro de plugins
```bash
# Limpar e reinstalar
rm -rf ~/.local/share/nvim ~/.cache/nvim
nvim  # Aguarde reinstalação
```

### Versão antiga do Neovim
```bash
# Verificar versão
nvim --version

# Se < 0.10.0, rodar:
sudo ./scripts/update-neovim.sh
```

### LSP não funciona
```bash
# Abrir Neovim e instalar LSPs
nvim
:Mason
# Instalar: typescript-language-server, lua-language-server, etc
```

### Kitty - transparência não funciona
```bash
# Ativar compositor (Pop!_OS já vem com)
# Se não funcionar, verificar se está usando Wayland
echo $XDG_SESSION_TYPE
```

## 📚 Documentação

- **LazyVim**: https://www.lazyvim.org
- **Kitty**: https://sw.kovidgoyal.net/kitty/
- **Neovim**: https://neovim.io/doc/

## 🚀 Próximos Passos

1. **Customize o Neovim**: Adicione plugins em `config/nvim/lua/plugins/`
2. **Configure LSPs**: Abra `:Mason` e instale language servers
3. **Explore extras**: LazyVim tem vários extras (`:LazyExtras`)
4. **Tema**: Experimente outros temas (`:Telescope colorscheme`)

## 📝 Notas

- Configuração otimizada para **Pop!_OS 22.04** (funciona em Ubuntu/Debian)
- Neovim usa **LazyVim** (gerenciador Lazy.nvim)
- Estrutura segue padrão **XDG** (~/.config/)
- Scripts são **idempotentes** (pode rodar várias vezes)

## 📄 Licença

MIT - Use à vontade!

---

**Dica**: Execute `:checkhealth` no Neovim regularmente para verificar se está tudo OK!
