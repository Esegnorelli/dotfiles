# 🚀 Dotfiles

Configurações completas do meu ambiente de desenvolvimento, gerenciadas com GNU Stow.

## 📦 O que está incluído

- **Neovim**: Configuração completa com LazyVim, plugins de IA (Codeium), formatação (Conform)
- **Tmux**: Tmux multiplexer com plugins (floax, sessionx, catppuccin)
- **Zsh**: Shell Zsh com Oh My Zsh, Powerlevel10k, fuzzy search (fzf)
- **Bash**: Shell Bash configurado
- **Git**: Configuração global do Git
- **Scripts**: Scripts utilitários para automação

## ⚡ Instalação Rápida

### No PC do trabalho (primeira vez):

```bash
# Baixar e executar script automático
git clone git@github.com:SEU_USUARIO/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup-work.sh
```

O script vai:
1. Instalar todas as dependências
2. Configurar Git e SSH
3. Clonar seus dotfiles
4. Restaurar todas as configurações
5. Instalar plugins do Neovim
6. Mudar shell padrão para Zsh

## 📂 Estrutura

```
~/dotfiles/
├── nvim/              # Neovim configs
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
├── scripts/           # Scripts úteis
├── setup.sh           # Script para inicializar (PC casa)
├── setup-work.sh      # Script para configurar (PC trabalho)
├── restore.sh         # Script para restaurar configs
└── sync.sh            # Script para sincronizar mudanças
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
cd ~/dotfiles/nvim
mkdir -p .config/nvim/lua/plugins
# ... editar arquivo ...

# Sincronizar
cd ~/dotfiles
./sync.sh
```

## 🔧 Scripts Disponíveis

### setup.sh
Usado no PC de casa para:
- Gerar chave SSH
- Configurar Git
- Inicializar repositório
- Fazer primeiro push

### setup-work.sh
Usado no PC do trabalho para:
- Instalar todas as dependências
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
- AI plugins desabilitados por padrão (requer Node.js)

### Tmux
- Prefixo: `Ctrl+a`
- Plugins: floax, sessionx, catppuccin
- Split horizontal: `Prefix + -`
- Split vertical: `Prefix + |`

### Zsh
- Framework: Oh My Zsh
- Tema: Powerlevel10k
- Plugins: fzf (fuzzy search)

### Git
- Branch padrão: `main`
- Editor configurado

## 🚨 Problemas Comuns

### Erro ao fazer push
Verifique sua chave SSH:
```bash
cat ~/.ssh/id_ed25519.pub
# Adicione em: https://github.com/settings/keys
```

### Stow conflita com arquivos existentes
Remova arquivos existentes:
```bash
cd ~/dotfiles
./restore.sh
# O script faz backup automático
```

### Plugins do nvim não funcionam
Abra nvim e execute:
```vim
:Lazy sync
:TSUpdate
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
```vim
:Lazy update
```

### Atualizar sistema (Arch)
```bash
sudo pacman -Syu
```

## 🔐 Segurança

- Nunca commite arquivos com senhas
- Use variáveis de ambiente para secrets
- `.gitignore` configurado para ignorar caches

## 📚 Recursos

- [GNU Stow](https://www.gnu.org/software/stow/)
- [LazyVim](https://www.lazyvim.org/)
- [Tmux](https://github.com/tmux/tmux)
- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)

## 🤝 Contribuindo

Sinta-se livre para usar e modificar estas configurações conforme suas necessidades!

---

**Nota**: Seu PC do trabalho terá o mesmo ambiente de desenvolvimento do PC de casa após executar `setup-work.sh`.
