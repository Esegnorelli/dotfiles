# Setup Rápido - Trabalho

Guia para replicar este setup em qualquer máquina nova.

## Passo 1: Clone o repositório

```bash
# SSH (recomendado se você configurou chaves SSH)
git clone git@github.com:SEU-USUARIO/dotfiles.git ~/documentos/github/dotfiles

# OU HTTPS
git clone https://github.com/SEU-USUARIO/dotfiles.git ~/documentos/github/dotfiles
```

## Passo 2: Instalar dependências

```bash
cd ~/documentos/github/dotfiles
./scripts/install-deps.sh
```

Este script vai instalar:
- ZSH
- Kitty Terminal
- JetBrains Mono Nerd Font
- Fastfetch
- FZF
- (Opcional) ripgrep, bat, eza, zoxide

## Passo 3: Deploy das configurações

```bash
./scripts/deploy.sh --backup
```

Isso vai:
- Criar symlinks dos dotfiles
- Fazer backup dos arquivos existentes
- Configurar Kitty automaticamente

## Passo 4: Configurar ZSH (se ainda não for padrão)

```bash
chsh -s $(which zsh)
```

**Importante:** Faça logout e login novamente após isso.

## Passo 5: Reiniciar terminal

- Feche todos os terminais
- Abra o Kitty
- Aproveite! ✨

## Verificação rápida

Teste se tudo funcionou:

```bash
# Ver versão do kitty
kitty --version

# Ver versão do zsh
zsh --version

# Ver se a fonte está instalada
fc-list | grep JetBrains

# Testar fastfetch
fastfetch

# Testar fzf
fzf --version
```

## Customizações rápidas

### Mudar tema do Kitty

Edite `~/.config/kitty/kitty.conf` e mude:

```conf
# De:
include theme.conf

# Para um desses:
include themes/tokyo-night.conf
include themes/dracula.conf
```

Depois: `Ctrl+Shift+F5` para recarregar.

### Ajustar transparência

No Kitty, use:
- `Ctrl+Shift+A M` - Mais opaco
- `Ctrl+Shift+A L` - Mais transparente

Ou edite em `~/.config/kitty/kitty.conf`:

```conf
background_opacity 0.92  # Mude para o valor desejado (0.0-1.0)
```

## Troubleshooting

### Kitty não inicia?

```bash
# Reinstalar
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

### Transparência não funciona?

Instale um compositor:

```bash
sudo apt install picom
picom &
```

### Cores estranhas?

Verifique:

```bash
echo $TERM      # Deve ser: xterm-256color
echo $COLORTERM # Deve ser: truecolor
```

### Fastfetch mostra erro?

```bash
# Reinstalar
sudo snap install fastfetch
# OU
sudo apt install fastfetch
```

## Dicas de produtividade

### Atalhos essenciais do Kitty

- `Ctrl+Shift+T` - Nova tab
- `Ctrl+Shift+\` - Split vertical
- `Ctrl+Shift+-` - Split horizontal
- `Ctrl+H/J/K/L` - Navegar splits (vim-like)
- `Ctrl+Shift+F5` - Reload config
- `Ctrl+Shift+/` - Buscar no histórico (fzf)

### Aliases úteis (se estiver usando oh-my-zsh)

```bash
# Git
gst   # git status
ga    # git add
gcmsg # git commit -m
gp    # git push

# Navegação
..   # cd ..
...  # cd ../..
....  # cd ../../..
```

## Manutenção

### Atualizar dotfiles

```bash
cd ~/documentos/github/dotfiles
git pull
./scripts/deploy.sh --force  # Força atualização
```

### Adicionar novos dotfiles

```bash
# Exemplo: adicionar .gitconfig
cp ~/.gitconfig ~/documentos/github/dotfiles/.gitconfig
cd ~/documentos/github/dotfiles
git add .gitconfig
git commit -m "Add gitconfig"
git push

# Na próxima máquina, o deploy.sh vai linkar automaticamente
```

## Tempo estimado total

- Clone: 1 minuto
- Instalação de dependências: 5-10 minutos
- Deploy: 1 minuto
- **Total: ~15 minutos para setup completo**

## Compatibilidade

Testado em:
- ✅ Ubuntu 22.04 LTS
- ✅ Ubuntu 24.04 LTS
- ✅ Pop!_OS 22.04
- ✅ Debian 12
- ⚠️ Outras distros: pode precisar adaptar install-deps.sh

---

**Dica:** Salve este arquivo nos favoritos do navegador ou imprima para referência rápida!
