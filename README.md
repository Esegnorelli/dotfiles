# 🚀 Dotfiles - Ambiente de Desenvolvimento Completo

Configurações completas do ambiente de desenvolvimento, gerenciadas com GNU Stow. Inclui ferramentas de IA (Claude, Z.AI, OpenCode), Neovim, Tmux, Zsh, e mais.

## 📦 O que está incluído

### 🎨 Editores e Terminais
- **Neovim**: LazyVim com plugins de IA (Codeium, Copilot), formatação (Conform), e LSP completo
- **Tmux**: Multiplexer com plugins (floax, sessionx, catppuccin, vim-navigator, tmux-yank)
- **Zsh**: Shell com Oh My Zsh, Powerlevel10k, autosuggestions, syntax highlighting, fzf
- **Bash**: Shell configurado com aliases úteis
- **Kitty**: Terminal moderno e rápido

### 🤖 Ferramentas de IA
- **Claude (Z.AI)**: Interface CLI via Z.AI com modelos GLM-4.5-Air e GLM-4.6
- **Claude (Oficial)**: Interface CLI oficial da Anthropic com modelos Claude 3.5, Sonnet 4.5, Opus 4.5
- **OpenCode**: AI coding assistant com modelo GLM-4.7-Free (grátis!)
- **Codeium**: Autocomplete de IA no Neovim

### 🛠️ Ferramentas de Desenvolvimento
- **Git**: Configuração completa
- **SSH**: Chaves configuradas
- **Starship**: Prompt moderno e customizável
- **FZF**: Fuzzy finder para navegação
- **Ripgrep**: Busca rápida de texto
- **FD**: Alternativa rápida ao find
- **BAT**: Cat com syntax highlighting
- **EZA**: Alternativa moderna ao ls
- **Zoxide**: Smart cd com histórico
- **Direnv**: Gerenciamento de variáveis de ambiente por diretório

### 📝 Scripts Úteis
- Scripts para transcrição de áudio
- Scripts para lançar Claude e Z.AI
- Guias de uso de OpenCode, Claude e Z.AI

## ⚡ Instalação Rápida

### No PC do trabalho (primeira vez - Arch Linux limpo):

```bash
# 1. Clone o repositório
git clone git@github.com:SEU_USUARIO/dotfiles.git ~/dotfiles

# 2. Execute o script de instalação
cd ~/dotfiles
chmod +x setup-work.sh
./setup-work.sh
```

O script `setup-work.sh` vai:
1. ✅ Atualizar o sistema
2. ✅ Instalar todas as dependências via pacman
3. ✅ Instalar ferramentas do AUR manualmente (fd, eza, zoxide, direnv)
4. ✅ Instalar Node.js (necessário para plugins IA do nvim)
5. ✅ Instalar Oh My Zsh, Powerlevel10k, e plugins
6. ✅ Instalar TPM (Tmux Plugin Manager) e plugins
7. ✅ Configurar Git e gerar chave SSH
8. ✅ Clonar seus dotfiles do GitHub
9. ✅ Restaurar todas as configurações com Stow
10. ✅ Instalar plugins do Neovim (LazyVim + IA)
11. ✅ Mudar shell padrão para Zsh

### Configuração Manual (se o script falhar):

```bash
# 1. Instalar dependências do pacman
sudo pacman -S --needed git stow openssh neovim tmux zsh fzf ripgrep nodejs npm python python-pip go curl wget bat kitty starship unzip base-devel cmake gcc xclip xsel

# 2. Instalar fd
sudo pacman -S fd || \
  curl -sSLO https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-gnu.tar.gz && \
  tar xzf fd-v10.2.0-x86_64-unknown-linux-gnu.tar.gz && \
  sudo cp fd-v10.2.0-x86_64-unknown-linux-gnu/fd /usr/local/bin/

# 3. Instalar eza
sudo pacman -S eza || \
  curl -sSLO https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz && \
  tar xzf eza_x86_64-unknown-linux-gnu.tar.gz && \
  sudo cp eza /usr/local/bin/

# 4. Instalar zoxide
sudo pacman -S zoxide || \
  curl -sfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# 5. Instalar direnv
sudo pacman -S direnv || \
  curl -sfL https://direnv.net/install.sh | bash

# 6. Instalar Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# 7. Instalar Zsh Plugins
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# 8. Instalar TPM (Tmux Plugin Manager)
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# 9. Configurar Git e SSH
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
mkdir -p ~/.ssh
ssh-keygen -t ed25519 -C "seu@email.com" -f ~/.ssh/id_ed25519 -N ""

# 10. Adicionar chave SSH ao GitHub (https://github.com/settings/keys)

# 11. Clonar e restaurar dotfiles
git clone git@github.com:SEU_USUARIO/dotfiles.git ~/dotfiles
cd ~/dotfiles
./restore.sh

# 12. Instalar plugins do tmux
~/.tmux/plugins/tpm/bin/install_plugins

# 13. Instalar plugins do Neovim
nvim --headless "+Lazy! sync" +qa

# 14. Mudar shell para Zsh
sudo chsh -s $(which zsh) $USER
```

## 📂 Estrutura

```
~/dotfiles/
├── nvim/              # Neovim configs (LazyVim)
│   └── .config/nvim/
├── tmux/              # Tmux configs
│   ├── .tmux.conf
│   └── .tmux/
├── zsh/               # Zsh configs
│   ├── .zshrc
│   ├── .p10k.zsh
│   └── .fzf.zsh
├── bash/              # Bash configs
│   ├── .bashrc
│   └── .bash_profile
├── git/               # Git configs
│   └── .gitconfig
├── kitty/             # Kitty configs
│   └── .config/kitty/
├── starship/          # Starship configs
│   └── .config/starship.toml
├── opencode/          # OpenCode configs
│   └── .config/opencode/
├── claude/            # Claude configs
│   └── .claude/
├── antigravity/       # Antigravity (VS Code)
│   └── .antigravity/
├── scripts/           # Scripts úteis
│   ├── GUIA-OPENCODE.md
│   ├── COMO-USAR-CLAUDE-E-ZAI.md
│   └── ...
├── setup-work.sh      # Script para configurar (PC trabalho)
├── restore.sh         # Script para restaurar configs
├── sync.sh            # Script para sincronizar mudanças
└── README.md          # Este arquivo
```

## 🔄 Uso Diário

### Sincronizar mudanças

Depois de fazer alterações nas configurações:

```bash
cd ~/dotfiles
./sync.sh
```

Isso vai:
1. Adicionar todas as mudanças
2. Pedir uma mensagem de commit
3. Fazer commit
4. Push para o GitHub

### Adicionar nova configuração

```bash
# Exemplo: adicionar nova config para nvim
cd ~/dotfiles/nvim/.config/nvim/lua/plugins
nvim meu-novo-plugin.lua

# Sincronizar
cd ~/dotfiles
./sync.sh
```

### Restaurar configurações

Se algo quebrar ou quiser restaurar tudo:

```bash
cd ~/dotfiles
./restore.sh
```

### Atualizar dotfiles do GitHub

```bash
cd ~/dotfiles
git pull
./restore.sh
```

## 🤖 Como Usar Ferramentas de IA

### Z.AI (Claude via Z.AI)

```bash
# No terminal
z.ai "explique o que está errado neste código"

# Ou usando o alias
z.ai "crie uma função para validar email"
```

Configurado para usar:
- Base URL: https://api.z.ai/api/anthropic
- Modelos: GLM-4.5-Air (Haiku), GLM-4.6 (Sonnet/Opus)

### Claude Oficial

```bash
# No terminal
claude "ajude-me a debugar este código"

# Ou usando a função
claude "refatore esta função para ser mais performática"
```

Configurado para usar:
- Modelos: Claude 3.5 Haiku, Claude Sonnet 4.5, Claude Opus 4.5

### OpenCode

```bash
# No terminal
oc "como faço para criar um componente React?"

# Usando modelo gratuito
ocfree "explique hooks do React"

# Continuar conversa anterior
occ

# Ajuda
ochelp
```

Configurado para usar:
- Modelo: GLM-4.7-Free (grátis!)
- Outros modelos disponíveis

### Neovim com IA

No Neovim, você tem:
- **Codeium**: Autocomplete de IA (Ctrl+Enter)
- **Copilot**: Autocomplete do GitHub (requer configuração)
- **Outros plugins**: Windsurf, OpenCode

## 🔧 Scripts Disponíveis

### setup-work.sh
Usado no PC do trabalho para:
- Instalar todas as dependências
- Configurar Git e SSH
- Clonar dotfiles
- Restaurar configurações
- Instalar plugins

### restore.sh
Restaura configurações com GNU Stow:
```bash
cd ~/dotfiles
./restore.sh
```

### sync.sh
Sincroniza mudanças para GitHub:
```bash
cd ~/dotfiles
./sync.sh
```

### Scripts Úteis

- `~/dotfiles/scripts/GUIA-OPENCODE.md`: Guia completo de OpenCode
- `~/dotfiles/scripts/COMO-USAR-CLAUDE-E-ZAI.md`: Guia de Claude e Z.AI
- `~/dotfiles/scripts/transcrever_audios.py`: Script de transcrição
- `~/dotfiles/scripts/launch-claude-zai.sh`: Lançador de Claude/Z.AI

## 💡 Como funciona GNU Stow

GNU Stow cria links simbólicos dos arquivos em `~/dotfiles/` para seu home:

```
~/dotfiles/nvim/.config/nvim → ~/.config/nvim
~/dotfiles/tmux/.tmux.conf → ~/.tmux.conf
~/dotfiles/zsh/.zshrc → ~/.zshrc
```

Quando você edita `~/.config/nvim/init.lua`, está editando `~/dotfiles/nvim/.config/nvim/init.lua`.

## 📝 Configurações Importantes

### Neovim
- Editor: LazyVim
- Tema: Tokyo Night
- Plugins: Codeium (IA), Conform (formatador), nvim-treesitter
- IA plugins habilitados por padrão
- Prefixo do líder: `<Space>`

### Tmux
- Prefixo: `Ctrl+Space`
- Plugins: floax, sessionx, catppuccin, vim-navigator, tmux-yank
- Split horizontal: `Prefix + -`
- Split vertical: `Prefix + |`
- Instalar plugins: `Prefix + I`

### Zsh
- Framework: Oh My Zsh
- Tema: Powerlevel10k
- Plugins: autosuggestions, syntax highlighting, fzf, zoxide
- Vi mode habilitado

### Git
- Branch padrão: `main`
- Editor: nvim
- Configurado para usar SSH

## 🚨 Problemas Comuns

### Erro ao fazer push

Verifique sua chave SSH:
```bash
cat ~/.ssh/id_ed25519.pub
# Adicione em: https://github.com/settings/keys
```

Se precisar de force push (depois de merge):
```bash
cd ~/dotfiles
git push --force
```

### Stow conflita com arquivos existentes

Remova arquivos existentes:
```bash
cd ~/dotfiles
./restore.sh
# O script faz backup automático em ~/.dotfiles-backup-*
```

### Plugins do nvim não funcionam

Abra nvim e execute:
```vim
:Lazy sync
:TSUpdate
```

### Plugins do tmux não funcionam

Execute:
```bash
~/.tmux/plugins/tpm/bin/install_plugins
```

Ou dentro do tmux: `Prefix + I`

### Shell ainda é bash depois da instalação

Reinicie o terminal ou execute:
```bash
zsh
```

Se ainda não funcionar, execute manualmente:
```bash
sudo chsh -s $(which zsh) $USER
```

## 🎯 Personalização

### Adicionar plugin nvim

1. Crie arquivo: `~/dotfiles/nvim/.config/nvim/lua/plugins/meuplugin.lua`
2. Adicione configuração
3. Execute: `cd ~/dotfiles && ./sync.sh`

### Adicionar atalho tmux

1. Edite: `~/dotfiles/tmux/.tmux.conf`
2. Execute: `cd ~/dotfiles && ./sync.sh`
3. Recarregue tmux: `Prefix + :source-file ~/.tmux.conf`

### Adicionar alias zsh

1. Edite: `~/dotfiles/zsh/.zshrc`
2. Execute: `cd ~/dotfiles && ./sync.sh`
3. Recarregue: `source ~/.zshrc`

## 📱 Atualizações

### Atualizar dotfiles do GitHub

```bash
cd ~/dotfiles
git pull
./restore.sh
```

### Atualizar plugins nvim

Abra nvim e execute:
```vim
:Lazy update
```

### Atualizar plugins tmux

```bash
~/.tmux/plugins/tpm/bin/update_plugins
```

### Atualizar sistema (Arch)

```bash
sudo pacman -Syu
```

## 🔐 Segurança

- Nunca commite arquivos com senhas
- Use variáveis de ambiente para secrets
- `.gitignore` configurado para ignorar caches e secrets
- Chaves SSH nunca são commitadas

## 📚 Recursos

- [GNU Stow](https://www.gnu.org/software/stow/)
- [LazyVim](https://www.lazyvim.org/)
- [Tmux](https://github.com/tmux/tmux)
- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Starship](https://starship.rs/)
- [OpenCode](https://opencode.ai)
- [Claude AI](https://claude.ai)

## 🤝 Contribuindo

Sinta-se livre para usar e modificar estas configurações conforme suas necessidades!

---

**Nota**: Seu PC do trabalho terá o mesmo ambiente de desenvolvimento do PC de casa após executar `setup-work.sh`.

**Suporte a IA**: Todas as configurações de IA (Claude, Z.AI, OpenCode) estão incluídas e funcionarão após configurar os tokens/instalar as ferramentas necessárias.
