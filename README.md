# Dotfiles - Arch Linux + Plasma + Hyprland

Gerenciado com GNU Stow.

## Pacotes incluídos

- **zsh** - Shell e configurações
- **starship** - Prompt customizado (3 temas: gruvbox, catppuccin, tokyonight)
- **kitty** - Terminal emulator
- **nvim** - Neovim
- **fastfetch** - System info
- **atuin** - Shell history
- **thefuck** - Command corrector
- **micro** - Editor
- **hyprland** - Wayland compositor (template para configurar)

## Como usar

### Instalação completa
```bash
cd ~/dotfiles
stow */
```

### Instalar pacote específico
```bash
cd ~/dotfiles
stow zsh
stow kitty
stow hyprland
# etc...
```

### Remover pacote
```bash
cd ~/dotfiles
stow -D nome-do-pacote
```

## Adicionar novas configurações

1. Criar diretório: `mkdir -p ~/dotfiles/nome-app/.config`
2. Mover arquivos mantendo estrutura
3. Aplicar: `stow nome-app`
4. Commit: `git add . && git commit -m "Add nome-app config"`
5. Push: `git push`

## Temas Starship

Trocar tema:
```bash
cd ~/.config
ln -sf starship-base-gruvbox.toml starship.toml       # Gruvbox
ln -sf starship-base-catppuccin.toml starship.toml    # Catppuccin
ln -sf starship-base-tokyonight.toml starship.toml    # Tokyo Night
```
