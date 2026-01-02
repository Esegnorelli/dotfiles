# 🐧 Dotfiles - Arch Linux + KDE Plasma + Hyprland

> Ambiente Arch Linux altamente customizado gerenciado com GNU Stow

![Made with Arch Linux](https://img.shields.io/badge/Made%20for-Arch%20Linux-1793d1?style=for-the-badge&logo=arch-linux)
![Shell](https://img.shields.io/badge/Shell-Zsh-ffffff?style=for-the-badge&logo=gnu-bash)
![Terminal](https://img.shields.io/badge/Terminal-Kitty-1793d1?style=for-the-badge&logo=kitty)

---

## 📦 Pacotes Incluídos

### Core
- **zsh** + **zinit** - Shell com plugin manager
- **starship** - Prompt ultra customizado (3 temas disponíveis)
- **kitty** - Terminal emulator GPU-accelerated

### Ferramentas Modernas de CLI
| Ferramenta | Substitui | Descrição |
|-----------|-----------|-----------|
| `eza` | `ls` | Listagem moderna com ícones |
| `bat` | `cat` | Cat com syntax highlighting |
| `ripgrep` | `grep` | Grep ultra-rápido |
| `fd` | `find` | Find alternativo |
| `procs` | `ps` | PS moderno |
| `btop` | `htop` | Monitor de recursos |
| `lazygit` | `git` | UI para Git |
| `zoxide` | `cd` | Smart directory jumper |
| `atuin` | - | Shell history sync |
| `thefuck` | - | Corretor de comandos |

### Editores
- **nvim** - Neovim
- **helix** - Helix editor
- **micro** - Micro editor

### Eye Candy
- **fastfetch** - System info
- **cmatrix** - Matrix effect
- **pipes.sh** - Pipes animation
- **cbonsai** - Bonsai tree
- **tty-clock** - Terminal clock
- **onefetch** - Git repo info

---

## 🚀 Instalação Automatizada

### Nova máquina (Arch Linux limpo)

```bash
# Clone e execute
git clone https://github.com/Eseignorelli/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh

# Faça logout e login
```

O script **install.sh** faz tudo automaticamente:
- ✅ Instala Yay (AUR helper)
- ✅ Instala todos os pacotes necessários (pacman + AUR)
- ✅ Configura Zinit e plugins do Zsh
- ✅ Aplica todos os dotfiles com GNU Stow
- ✅ Muda shell padrão para Zsh
- ✅ Instala Nerd Fonts

---

## 🔧 Manual (GNU Stow)

### Instalar todos os pacotes
```bash
cd ~/dotfiles
stow */
```

### Instalar pacote específico
```bash
cd ~/dotfiles
stow zsh          # Shell e configurações
stow starship     # Prompt
stow kitty        # Terminal
stow nvim         # Neovim
stow git          # Git configs
# etc...
```

### Remover pacote
```bash
cd ~/dotfiles
stow -D nome-do-pacote
```

---

## ⌨️ Aliases Disponíveis

### Arquivos e Diretórios
```bash
ls      # eza --icons --group-directories-first
ll      # eza -alF --icons --group-directories-first
la      # eza -a --icons --group-directories-first
tree    # eza --tree --icons
cat     # bat (com highlighting)
less    # bat
grep    # rg (ripgrep)
find    # fd
ps      # procs
top     # btop
```

### Git
```bash
g       = git
lg      = lazygit
diff    = delta (git diff melhorado)
gitinfo = onfetch (info do repo git)
```

### Editores
```bash
v       = nvim
nano    = micro
hx      = helix
```

### Sistema Arch
```bash
update  = yay -Syu           # Atualizar sistema
ins     = yay -S             # Instalar pacote
rem     = yay -Rns           # Remover pacote
clean   = yay -Sc            # Limpar cache
```

### Utilitários
```bash
help    = tldr               # Help simplificado
ping    = gping              # Ping gráfico
rm      = trash              # Lixeira segura
c       = clear              # Limpar tela
cd      = z (zoxide)         # Smart cd
```

### Eye Candy
```bash
ff      = fastfetch          # Info do sistema
matrix  = cmatrix            # Efeito Matrix
pipes   = pipes.sh           # Animação pipes
bonsai  = cbonsai -l         # Bonsai interativo
clock   = tty-clock -c -C 3  # Relógio
```

---

## 🎨 Temas Disponíveis

### Starship Prompt
```bash
cd ~/.config
ln -sf ~/dotfiles/starship/.config/starship-base-gruvbox.toml starship.toml
ln -sf ~/dotfiles/starship/.config/starship-base-catppuccin.toml starship.toml
ln -sf ~/dotfiles/starship/.config/starship-base-tokyonight.toml starship.toml
```

### Kitty Terminal
```bash
cd ~/.config/kitty
ln -sf theme-gruvbox.conf current-theme.conf
ln -sf theme-catppuccin.conf current-theme.conf
ln -sf theme-tokyonight.conf current-theme.conf
```

---

## 📁 Estrutura de Diretórios

```
~/dotfiles/
├── .stow-local-ignore.conf
├── install.sh
├── README.md
├── MIGRATION_GUIDE.md         # Guia completo de migração
├── dotfiles-structure.md      # Estrutura detalhada
│
├── zsh/
│   └── .zshrc
├── starship/
│   └── .config/starship.toml
├── kitty/
│   └── .config/kitty/
├── nvim/
│   └── .config/nvim/
├── git/
│   └── .gitconfig
└── ... (outros pacotes)
```

---

## 🔧 Adicionar Novas Configurações

1. **Criar diretório mantendo estrutura**
   ```bash
   mkdir -p ~/dotfiles/nova-app/.config
   ```

2. **Mover arquivos**
   ```bash
   mv ~/.config/nova-app/config.toml ~/dotfiles/nova-app/.config/
   ```

3. **Aplicar com Stow**
   ```bash
   cd ~/dotfiles
   stow nova-app
   ```

4. **Commit e push**
   ```bash
   git add .
   git commit -m "Add nova-app config"
   git push
   ```

---

## 📚 Documentação Adicional

- **MIGRATION_GUIDE.md** - Guia completo de migração passo a passo
- **dotfiles-structure.md** - Lista completa de dependências e estrutura
- **RESUMO.md** - Quick reference

---

## ⚠️ Arquivos Sensíveis

Este repositório **NÃO** deve conter:
- Tokens ou senhas
- Chaves privadas SSH
- Arquivos `.private`
- Históricos com dados sensíveis

Use arquivos separados para configs sensíveis:
```bash
# ~/.zshrc.private (não versionado)
export ANTHROPIC_AUTH_TOKEN="seu-token"
export GITHUB_TOKEN="seu-token"

# No .zshrc (versionado)
[ -f ~/.zshrc.private ] && source ~/.zshrc.private
```

---

## 🖥️ Compatibilidade

- **Distro:** Arch Linux (ou derivadas)
- **DE/WM:** KDE Plasma / Hyprland
- **Display Server:** Wayland (X11 compatível)
- **Terminal:** Kitty (configurado para Wayland)

---

## 📝 Licença

MIT License - Sinta-se livre para usar e modificar!

---

**Autor:** Esegnorelli
**Última atualização:** 2025-01-02
