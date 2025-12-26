# Integração com .zshrc e .bashrc

Como integrar os dotfiles com seus shells.

## Método 1: Source direto (recomendado)

### Para ZSH

Adicione ao final do seu `~/.zshrc`:

```bash
# Dotfiles integration
if [ -f ~/documentos/github/dotfiles/config/zsh/dotfiles-integration.zsh ]; then
    source ~/documentos/github/dotfiles/config/zsh/dotfiles-integration.zsh
fi
```

### Para Bash

Adicione ao final do seu `~/.bashrc`:

```bash
# Dotfiles integration
if [ -f ~/documentos/github/dotfiles/config/bash/dotfiles-integration.bash ]; then
    source ~/documentos/github/dotfiles/config/bash/dotfiles-integration.bash
fi
```

## Método 2: Copiar .zshrc completo para o repo

Se você quiser versionar seu .zshrc completo:

```bash
# Copiar .zshrc para o repo
cp ~/.zshrc ~/documentos/github/dotfiles/config/zsh/.zshrc

# Adicionar integração
echo 'source ~/documentos/github/dotfiles/config/zsh/dotfiles-integration.zsh' >> ~/documentos/github/dotfiles/config/zsh/.zshrc

# Criar symlink
ln -sf ~/documentos/github/dotfiles/config/zsh/.zshrc ~/.zshrc

# Recarregar
source ~/.zshrc
```

## Comandos disponíveis após integração

### Gerenciamento de dotfiles

```bash
dotfiles              # Ir para diretório de dotfiles
dotfiles-list         # Listar todos os dotfiles
dotfiles-health       # Verificar saúde dos dotfiles
dotfiles-backup       # Criar backup
dotfiles-deploy       # Aplicar configurações
dotfiles-update       # Atualizar do GitHub e aplicar
dotfiles-sync         # Commit local + pull + deploy
```

### Edição rápida

```bash
kittyconf             # Editar config do Kitty
zshconf               # Editar .zshrc
bashconf              # Editar .bashrc
nvimconf              # Editar config do Neovim
```

### Reload

```bash
reload-zsh            # Recarregar ZSH
reload-bash           # Recarregar Bash
reload-kitty          # Recarregar Kitty
```

### Temas

```bash
kitty-theme           # Listar temas disponíveis
kitty-theme tokyo-night    # Mudar para Tokyo Night
kitty-theme dracula        # Mudar para Dracula
kitty-theme catppuccin     # Voltar para Catppuccin (padrão)
```

### Setup de ferramentas

```bash
setup-nvim            # Configurar Neovim automaticamente
```

## Exemplo de .zshrc modular

Se você quiser uma estrutura completamente modular:

```bash
# ~/.zshrc

# 1. Exports e PATH
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# 2. History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# 3. Oh My Zsh ou Powerlevel10k (se usar)
# ... suas configs ...

# 4. Dotfiles integration
source ~/documentos/github/dotfiles/config/zsh/dotfiles-integration.zsh

# 5. Configs locais (não versionadas)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
```

## Configurações locais (não versionadas)

Para configs específicas de cada máquina:

### Casa (~/.zshrc.local)
```bash
# Configs específicas de casa
export PROJECTS_DIR=~/projetos
alias projetos='cd $PROJECTS_DIR'
```

### Trabalho (~/.zshrc.local)
```bash
# Configs específicas do trabalho
export WORK_DIR=~/work
export PROXY=http://proxy.empresa.com:8080
alias work='cd $WORK_DIR'
```

Esses arquivos `.local` não são versionados (já estão no .gitignore).

## Workflow completo

### 1. Setup inicial (casa)

```bash
cd ~/documentos/github/dotfiles
echo 'source ~/documentos/github/dotfiles/config/zsh/dotfiles-integration.zsh' >> ~/.zshrc
source ~/.zshrc
dotfiles-health  # Verificar se tudo OK
```

### 2. Fazer mudanças

```bash
kittyconf  # Editar configuração
# ... fazer mudanças ...
reload-kitty  # Testar
```

### 3. Commitar

```bash
dotfiles-sync  # Ou manualmente:
cd ~/documentos/github/dotfiles
git add .
git commit -m "feat: Adicionar atalho XYZ"
git push
```

### 4. Replicar no trabalho

```bash
# No trabalho
git clone git@github.com:SEU-USUARIO/dotfiles.git ~/documentos/github/dotfiles
cd ~/documentos/github/dotfiles
./scripts/install-deps.sh
./scripts/deploy.sh --backup
echo 'source ~/documentos/github/dotfiles/config/zsh/dotfiles-integration.zsh' >> ~/.zshrc
source ~/.zshrc
```

## Dicas

### Auto-update semanal

Adicione ao crontab:

```bash
crontab -e

# Adicionar:
0 9 * * 1 cd ~/documentos/github/dotfiles && git pull && bash scripts/deploy.sh --force
```

### Sincronização automática

Se você faz mudanças frequentes:

```bash
# Criar alias para commit rápido
alias dotfiles-save='cd ~/documentos/github/dotfiles && git add . && git commit -m "chore: Auto-save $(date +%Y-%m-%d)" && git push'
```

### Verificação de saúde ao iniciar shell

Adicione ao .zshrc (depois da integração):

```bash
# Verificar dotfiles uma vez por dia
if [ ! -f ~/.dotfiles-check ] || [ $(find ~/.dotfiles-check -mtime +1 2>/dev/null | wc -l) -gt 0 ]; then
    dotfiles-health
    touch ~/.dotfiles-check
fi
```

## Troubleshooting

### "command not found: dotfiles-*"

Verifique se sourced corretamente:

```bash
grep -n "dotfiles-integration" ~/.zshrc
```

Deve mostrar a linha. Se não, adicione novamente.

### Mudanças não aplicam

```bash
# Forçar reload
dotfiles-deploy
reload-zsh  # ou reload-bash
```

### Conflitos de merge

```bash
cd ~/documentos/github/dotfiles
git status
# Resolver conflitos manualmente
git add .
git commit
```

---

**Pronto!** Agora você tem um sistema completo de dotfiles integrado.
