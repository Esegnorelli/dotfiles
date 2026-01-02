# 🏗️ Estrutura de Dotfiles - GNU Stow

## 📁 Estrutura de Diretórios Proposta

```
~/dotfiles/
├── .stow-local-ignore.conf       # Arquivos ignorados pelo Stow
├── install.sh                     # Script de instalação automatizado
├── README.md                      # Este arquivo
│
├── zsh/                           # Configurações do Zsh
│   ├── .zshrc                     # Configuração principal
│   ├── .zshenv                    # Variáveis de ambiente
│   └── .p10k.zsh                  # Se usar Powerlevel10k (opcional)
│
├── starship/                      # Prompt Starship
│   └── .config/starship.toml
│
├── kitty/                         # Terminal Emulator
│   └── .config/kitty/
│       ├── kitty.conf
│       ├── theme-gruvbox.conf
│       ├── theme-catppuccin.conf
│       └── theme-tokyonight.conf
│
├── git/                           # Configurações do Git
│   ├── .gitconfig
│   └── .gitignore_global
│
├── nvim/                          # Neovim
│   └── .config/nvim/
│       ├── init.lua
│       └── lua/
│
├── helix/                         # Helix Editor
│   └── .config/helix/
│
├── lazygit/                       # Lazygit
│   └── .config/lazygit/config.yml
│
├── btop/                          # Btop
│   └── .config/btop/
│
├── atuin/                         # Atuin
│   └── .config/atuin/
│
├── direnv/                        # Direnv
│   └── .config/direnv/
│
├── fastfetch/                     # Fastfetch
│   └── .config/fastfetch/
│
└── fonts/                         # Fontes (opcional - se quiser versionar)
    └── .local/share/fonts/
```

## 📦 Análise de Dependências do .zshrc

### Pacotes Oficiais (pacman)
```bash
# Shell & Plugin Manager
zsh
git
curl

# Ferramentas Modernas de CLI
eza                          # ls, ll, la, tree
bat                          # cat, less
ripgrep                      # grep (rg)
fd                           # find
procs                        # ps
btop                         # top
tldr                         # help
gping                        # ping
lazygit                      # lg
git-delta                    # diff
trash-cli                    # rm
wl-clipboard                 # wl-copy (Wayland)
neovim                       # v
micro                        # nano
helix                        # hx

# Fzf e Zoxide
fzf                          # fuzzy finder
zoxide                       # cd inteligente

# Histórico e Ambiente
atuin                        # histórico sincronizado
direnv                       # ambiente por diretório

# Prompt
starship                     # prompt

# "Eye Candy"
fastfetch                    # ff (informações do sistema)
cmatrix                      # matrix
pipes.sh                     # pipes
cbonsai                      # bonsai
tty-clock                    # clock
onefetch                     # gitinfo

# Correção de Comandos
thefuck                      # thefuck

# Terminal Emulator
kitty                        # terminal emulator
```

### Pacotes AUR (yay)
```bash
# Nerd Fonts (para ícones no Starship/Eza/Kitty)
meslolgs-nf                  # MesloLGS Nerd Font
jetbrains-mono-nerd-font     # JetBrains Mono Nerd Font
```

### Fontes Necessárias (Nerd Fonts)
Recomendadas para Starship/Fastfetch/Kitty:
- **MesloLGS NF** (recomendada pelo Starship)
- **JetBrains Mono Nerd Font** (usada no Kitty)
- **FiraCode Nerd Font**

Instalação via AUR:
```bash
yay -S meslolgs-nf jetbrains-mono-nerd-font firacode-nerd-font
```

## 🔍 Mapeamento Alias → Pacote

| Alias no .zshrc | Comando Real | Pacote |
|----------------|--------------|--------|
| `ls`, `ll`, `la`, `tree` | `eza` | `eza` |
| `cat`, `less` | `bat` | `bat` |
| `grep` | `rg` | `ripgrep` |
| `find` | `fd` | `fd` |
| `ps` | `procs` | `procs` |
| `top` | `btop` | `btop` |
| `help` | `tldr` | `tldr` |
| `ping` | `gping` | `gping` |
| `lg` | `lazygit` | `lazygit` |
| `diff` | `delta` | `git-delta` |
| `rm` | `trash` | `trash-cli` |
| `clipboard` | `wl-copy` | `wl-clipboard` |
| `v` | `nvim` | `neovim` |
| `nano` | `micro` | `micro` |
| `hx` | `helix` | `helix` |
| `ff` | `fastfetch` | `fastfetch` |
| `matrix` | `cmatrix` | `cmatrix` |
| `pipes` | `pipes.sh` | `pipes.sh` |
| `bonsai` | `cbonsai` | `cbonsai` |
| `clock` | `tty-clock` | `tty-clock` |
| `gitinfo` | `onefetch` | `onefetch` |

## 🔗 Como o GNU Stow Funciona

O GNU Stow cria symlinks reversos:
```bash
cd ~/dotfiles
stow zsh          # Cria symlink: ~/.zshrc -> ~/dotfiles/zsh/.zshrc
stow starship     # Cria symlink: ~/.config/starship.toml -> ~/dotfiles/starship/.config/starship.toml
stow kitty        # Cria symlink: ~/.config/kitty -> ~/dotfiles/kitty/.config/kitty
stow git          # Cria symlink: ~/.gitconfig -> ~/dotfiles/git/.gitconfig
```

Para remover symlinks:
```bash
cd ~/dotfiles
stow -D zsh       # Remove symlinks do pacote zsh
```

## ⚠️ Arquivos Ignorados (.stow-local-ignore.conf)

```bash
# Ignora arquivos que não devem ser linkados
README.md
install.sh
.git/
.DS_Store
*.swp
*~
```

## 🐱 Configuração do Kitty

O Kitty já está configurado no seu ambiente atual em:
```
~/dotfiles/kitty/.config/kitty/
├── kitty.conf              # Configuração principal
├── theme-gruvbox.conf      # Tema Gruvbox (padrão)
├── theme-catppuccin.conf   # Tema Catppuccin
├── theme-tokyonight.conf   # Tema Tokyo Night
└── current-theme.conf      # Symlink para o tema atual
```

### Fonte Configurada
- **Fonte Principal:** JetBrainsMono Nerd Font
- **Tamanho:** 12.0
- **Ligaduras:** Habilitadas (ex: `=>` vira `⇒`)

### Temas Disponíveis
Altere o tema editando `kitty.conf` ou o symlink `current-theme.conf`:
```bash
cd ~/.config/kitty
ln -sf theme-gruvbox.conf current-theme.conf      # Gruvbox
ln -sf theme-catppuccin.conf current-theme.conf   # Catppuccin
ln -sf theme-tokyonight.conf current-theme.conf   # Tokyo Night
```
