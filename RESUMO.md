# 🚀 RESUMO RÁPIDO - Dotfiles Arch Linux

## 📦 O que foi criado

### 1. Estrutura de Pastas (GNU Stow)
```
~/dotfiles/
├── .stow-local-ignore.conf
├── install.sh
├── README.md
│
├── zsh/              # Shell configs
├── starship/         # Prompt configs
├── kitty/            # Terminal configs
├── git/              # Git configs
├── nvim/             # Neovim configs
├── helix/            # Helix configs
├── lazygit/          # Lazygit configs
├── btop/             # Btop configs
├── atuin/            # Atuin configs
├── direnv/           # Direnv configs
└── fastfetch/        # Fastfetch configs
```

### 2. Script de Instalação Automatizada
- **install.sh**: Instala todas as dependências e configura o ambiente

### 3. Dependências Identificadas

#### Pacotes Oficiais (pacman)
```bash
zsh git curl eza bat ripgrep fd procs btop tldr gping lazygit git-delta trash-cli wl-clipboard neovim micro helix fzf zoxide atuin direnv starship fastfetch cmatrix pipes.sh cbonsai tty-clock onefetch thefuck kitty
```

#### Pacotes AUR (yay)
```bash
meslolgs-nf jetbrains-mono-nerd-font
```

---

## 🔧 COMO USAR

### Na MÁQUINA ATUAL (preparação)

```bash
# 1. Criar estrutura
mkdir -p ~/dotfiles
cd ~/dotfiles

# 2. Mover arquivos para estrutura Stow
mkdir -p zsh && cp ~/.zshrc zsh/
mkdir -p starship/.config && cp ~/.config/starship.toml starship/.config/
mkdir -p kitty/.config/kitty && cp -r ~/.config/kitty/* kitty/.config/kitty/
# ... (repita para outros pacotes)

# 3. Testar symlinks
cd ~/dotfiles
stow zsh      # Testa com ZSH primeiro
ls -la ~/.zshrc  # Deve mostrar: ~/.zshrc -> ~/dotfiles/zsh/.zshrc

# 4. Se funcionou, faça stow dos outros
stow starship kitty git nvim helix lazygit btop atuin direnv fastfetch

# 5. Publicar no GitHub
git init
git add .
git commit -m "Initial commit: Arch Linux dotfiles"
git remote add origin https://github.com/SEU_USUARIO/dotfiles.git
git push -u origin main
```

### Na MÁQUINA NOVA (instalação limpa)

```bash
# 1. Baixar e executar script
git clone https://github.com/SEU_USUARIO/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh

# 2. Fazer logout e login (para carregar Zsh)

# 3. Pronto! Seu ambiente está replicado
```

---

## ⚠️ IMPORTANTE

### Antes de fazer stow na máquina ATUAL:

```bash
# FAÇA BACKUP DOS SEUS ARQUIVOS!
mkdir ~/backup-dotfiles
cp ~/.zshrc ~/backup-dotfiles/
cp ~/.config/starship.toml ~/backup-dotfiles/
cp -r ~/.config/kitty ~/backup-dotfiles/
# ... etc
```

### Arquivos SENSÍVEIS - NUNCA COMMITAR:

```bash
# Tokens, senhas, etc
ANTHROPIC_AUTH_TOKEN
GITHUB_TOKEN
SSH keys
*.private files
```

**Solução:** Use arquivos `.private` separados:
```bash
# No final do .zshrc:
[ -f ~/.zshrc.private ] && source ~/.zshrc.private

# No ~/.zshrc.private:
export ANTHROPIC_AUTH_TOKEN="seu-token"
```

---

## 🔍 COMANDS ÚTEIS

```bash
# Ver symlinks ativos
ls -la ~ | grep ^l

# Simular stow (dry-run)
cd ~/dotfiles
stow -n zsh

# Remover symlinks
stow -D zsh

# Re-fazer stow
stow -R zsh
```

---

## 📋 CHECKLIST FINAL

### Máquina Atual:
- [ ] Criar estrutura ~/dotfiles/
- [ ] Mover arquivos para pastas por pacote
- [ ] Testar stow com um pacote
- [ ] Fazer backup dos arquivos originais
- [ ] Fazer stow de todos os pacotes
- [ ] Criar repositório no GitHub
- [ ] Push do dotfiles
- [ ] Verificar se não há dados sensíveis

### Máquina Nova:
- [ ] Instalar Arch Linux base
- [ ] Baixar install.sh
- [ ] Executar install.sh
- [ ] Fazer logout/login
- [ ] Verificar se tudo funciona
- [ ] Configurar Atuin (se necessário)
- [ ] Configurar Git user.name/user.email
- [ ] Testar aliases principais (ls, cat, lg, etc)

---

## 📚 ARQUIVOS CRIADOS

1. **dotfiles-structure.md** - Estrutura detalhada de pastas
2. **install.sh** - Script de instalação automatizada
3. **MIGRATION_GUIDE.md** - Guia completo de migração
4. **.gitignore-template** - Template para .gitignore
5. **RESUMO.md** - Este arquivo resumido

---

## 🎯 PRÓXIMOS PASSOS

1. **Execute o passo 1** (mover arquivos para estrutura Stow)
2. **Teste os symlinks** na sua máquina atual
3. **Ajuste o script install.sh** (altere a URL do repositório)
4. **Crie o repositório no GitHub**
5. **Faça o push**
6. **Teste em uma VM** (opcional, mas recomendado)

---

**Dúvidas?** Consulte o MIGRATION_GUIDE.md para instruções detalhadas.
