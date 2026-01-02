# 🚀 Guia de Migração - Dotfiles Arch Linux

## 📋 Índice
1. [Preparação na Máquina Atual](#1-preparação-na-máquina-atual)
2. [Estrutura do Repositório](#2-estrutura-do-repositório)
3. [Publicando no GitHub](#3-publicando-no-github)
4. [Instalação na Nova Máquina](#4-instalação-na-nova-máquina)
5. [Solução de Problemas](#5-solução-de-problemas)

---

## 1. PREPARAÇÃO NA MÁQUINA ATUAL

### Passo 1: Criar estrutura de diretórios

```bash
# Crie o diretório principal dos dotfiles
mkdir -p ~/dotfiles

cd ~/dotfiles
```

### Passo 2: Mover arquivos para estrutura GNU Stow

```bash
# === ZSH ===
mkdir -p zsh
cp ~/.zshrc zsh/.zshrc
# Se tiver .zshenv, .p10k.zsh, etc:
# cp ~/.zshenv zsh/.zshenv
# cp ~/.p10k.zsh zsh/.p10k.zsh

# === STARSHIP ===
mkdir -p starship/.config
cp ~/.config/starship.toml starship/.config/

# === GIT ===
mkdir -p git
cp ~/.gitconfig git/.gitconfig 2>/dev/null || echo "Sem .gitconfig"
cp ~/.gitignore_global git/.gitignore_global 2>/dev/null || echo "Sem .gitignore_global"

# === KITTY ===
mkdir -p kitty/.config/kitty
cp -r ~/.config/kitty/* kitty/.config/kitty/

# === NEOVIM ===
mkdir -p nvim/.config
cp -r ~/.config/nvim nvim/.config/

# === HELIX ===
mkdir -p helix/.config
cp -r ~/.config/helix helix/.config/

# === LAZYGIT ===
mkdir -p lazygit/.config/lazygit
cp -r ~/.config/lazygit/* lazygit/.config/lazygit/ 2>/dev/null || echo "Sem lazygit config"

# === BTOP ===
mkdir -p btop/.config/btop
cp -r ~/.config/btop/* btop/.config/btop/ 2>/dev/null || echo "Sem btop config"

# === ATUIN ===
mkdir -p atuin/.config/atuin
cp -r ~/.config/atuin/* atuin/.config/atuin/ 2>/dev/null || echo "Sem atuin config"

# === DIRENV ===
mkdir -p direnv/.config/direnv
cp -r ~/.config/direnv/* direnv/.config/direnv/ 2>/dev/null || echo "Sem direnv config"

# === FASTFETCH ===
mkdir -p fastfetch/.config/fastfetch
cp -r ~/.config/fastfetch/* fastfetch/.config/fastfetch/ 2>/dev/null || echo "Sem fastfetch config"
```

### Passo 3: Criar .stow-local-ignore.conf

```bash
cat > ~/dotfiles/.stow-local-ignore.conf << 'EOF'
# Arquivos ignorados pelo GNU Stow
README.md
install.sh
.git/
.gitignore
.DS_Store
*.swp
*~
EOF
```

### Passo 4: Testar symlinks com GNU Stow

**IMPORTANTE:** Primeiro faça backup dos arquivos originais!

```bash
# Backup dos arquivos atuais
mkdir -p ~/dotfiles-backup
cp ~/.zshrc ~/dotfiles-backup/ 2>/dev/null || true
cp ~/.config/starship.toml ~/dotfiles-backup/ 2>/dev/null || true
cp -r ~/.config/kitty ~/dotfiles-backup/ 2>/dev/null || true
# ... faça backup de outros arquivos importantes

# Agora teste o stow
cd ~/dotfiles

# Teste com um pacote primeiro (ex: zsh)
stow zsh

# Verifique se o symlink foi criado
ls -la ~/.zshrc
# Deve mostrar: ~/.zshrc -> ~/dotfiles/zsh/.zshrc

# Se funcionou, faça stow dos outros pacotes
stow starship
stow kitty
stow git
stow nvim
# ... etc
```

### Passo 5: Remover symlinks se precisar reorganizar

```bash
cd ~/dotfiles
stow -D zsh       # Remove symlinks do zsh
stow -D starship  # Remove symlinks do starship
# etc...
```

---

## 2. ESTRUTURA DO REPOSITÓRIO

Após mover os arquivos, sua estrutura deve estar assim:

```
~/dotfiles/
├── .stow-local-ignore.conf
├── install.sh
├── README.md
│
├── zsh/
│   └── .zshrc
│
├── starship/
│   └── .config/
│       └── starship.toml
│
├── kitty/
│   └── .config/
│       └── kitty/
│           ├── kitty.conf
│           ├── theme-gruvbox.conf
│           ├── theme-catppuccin.conf
│           └── theme-tokyonight.conf
│
├── git/
│   ├── .gitconfig
│   └── .gitignore_global
│
├── nvim/
│   └── .config/
│       └── nvim/
│           └── (seus arquivos nvim)
│
└── ... (outros pacotes)
```

---

## 3. PUBLICANDO NO GITHUB

### Passo 1: Criar repositório no GitHub

1. Acesse https://github.com/new
2. Crie um repositório chamado `dotfiles`
3. **NÃO** adicione README, .gitignore ou license
4. Clique em "Create repository"

### Passo 2: Inicializar git e fazer push

```bash
cd ~/dotfiles

# Inicializa o repositório
git init

# Cria .gitignore
cat > .gitignore << 'EOF'
# Arquivos sensíveis (nunca commite estes!)
*.private
.env
.env.local

# Arquivos de sistema
.DS_Store
Thumbs.db

# Editores
*.swp
*.swo
*~
.*.sw[a-z]

# Backups
*.bak
*~
EOF

# Adiciona arquivos
git add .

# Primeiro commit
git commit -m "Initial commit: Arch Linux dotfiles"

# Adiciona remote (SUBSTITUA PELO SEU USUÁRIO)
git remote add origin https://github.com/SEU_USUARIO/dotfiles.git

# Faz push
git branch -M main
git push -u origin main
```

### Passo 3: Tornar privado (RECOMENDADO)

```bash
# Se contiver informações sensíveis (tokens, etc), torne privado
# Vá em Settings → Danger Zone → Change visibility
```

---

## 4. INSTALAÇÃO NA NOVA MÁQUINA

### Passo 1: Instalação base do Arch Linux

Assuma que você já tem o Arch instalado com:
- Interface gráfica (KDE/GNOME/etc)
- Usuario comum criado
- Internet funcionando
- `sudo` configurado

### Passo 2: Baixar e executar o script

```bash
# Baixar o install.sh do seu repositório
curl -LO https://raw.githubusercontent.com/SEU_USUARIO/dotfiles/main/install.sh

# Ou clone o repositório completo
git clone https://github.com/SEU_USUARIO/dotfiles.git
cd dotfiles

# Tornar executável
chmod +x install.sh

# EXECUTAR
./install.sh
```

### Passo 3: Pós-instalação

```bash
# 1. Faça logout e login (para carregar Zsh)

# 2. Configure o Atuin (primeira vez)
atuin init zsh

# 3. Configure o Git (se necessário)
git config --global user.email "seu@email.com"
git config --global user.name "Seu Nome"

# 4. Se usar ofuck, configure:
thefuck --alias

# 5. Teste os aliases:
ls          # deve usar eza
cat         # deve usar bat
lg          # deve abrir lazygit
```

---

## 5. SOLUÇÃO DE PROBLEMAS

### Problema: "stow: target already exists"

**Causa:** Arquivo já existe em ~/

**Solução:**
```bash
# Remova ou mova o arquivo existente
mv ~/.zshrc ~/backup-zshrc.old
cd ~/dotfiles
stow zsh
```

### Problema: "Zinit plugins não carregam"

**Causa:** Primeira execução do Zsh

**Solução:**
```bash
# Abra um novo terminal
# Zinit instalará os plugins automaticamente
# Ou execute manualmente:
zsh
```

### Problema: "Fontes quebradas no terminal"

**Causa:** Nerd Fonts não instaladas

**Solução:**
```bash
# Instale as fontes
yay -S meslolgs-nf jetbrains-mono-nerd-font

# Configure o Kitty para usar a fonte
# Edite ~/.config/kitty/kitty.conf
# font_family JetBrainsMono Nerd Font
```

### Problema: "Atuin não funciona"

**Solução:**
```bash
# Configure o Atuin
atuin init zsh

# Se precisar de sync na nuvem:
atuin register -u SEU_USUARIO -e SEU_EMAIL
atuin sync
```

### Problema: "Starship com erro"

**Solução:**
```bash
# Verifique se o arquivo existe
ls ~/.config/starship.toml

# Se não existir:
cd ~/dotfiles
stow starship
```

---

## 📝 MANUTENÇÃO

### Adicionar novos arquivos ao dotfiles

```bash
# 1. Mova/copie o arquivo para a estrutura correta
cp ~/novo-arquivo ~/dotfiles/pacote/.caminho/do/arquivo

# 2. Faça stow novamente
cd ~/dotfiles
stow pacote

# 3. Commit e push
git add .
git commit -m "Adiciona novo arquivo"
git push
```

### Atualizar dotfiles em outra máquina

```bash
cd ~/dotfiles
git pull origin main
```

### Ver symlinks ativos

```bash
# Lista todos os symlinks em ~/
ls -la ~ | grep ^l

# Ver symlinks de um pacote específico
stow -n zsh  # Simula, não executa (dry-run)
```

---

## 🔒 SEGURANÇA

### Arquivos para NUNCA commitar

```bash
# Tokens, senhas, chaves privadas
*.private
.env
*.pem
*.key
id_rsa
id_ed25519

# Históricos com dados sensíveis
.zsh_history
.bash_history

# Caches
.cache/
*.log
```

### Usar arquivos separados para configs sensíveis

Exemplo: `.zshrc.private`

```bash
# No final do seu .zshrc, adicione:
[ -f ~/.zshrc.private ] && source ~/.zshrc.private

# No ~/.zshrc.private, coloque:
export ANTHROPIC_AUTH_TOKEN="seu-token-aqui"
export GITHUB_TOKEN="seu-token-aqui"
```

---

## 📚 REFERÊNCIAS

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/)
- [Arch Wiki - Zsh](https://wiki.archlinux.org/title/Zsh)
- [Starship Prompt](https://starship.rs/)
- [Kitty Terminal](https://sw.kovidgoyal.net/kitty/)

---

**Autor:** Seu Nome
**Licença:** MIT (ou outra que preferir)
**Última atualização:** $(date +%Y-%m-%d)
