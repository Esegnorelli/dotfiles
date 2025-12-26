# Como versionar seus dotfiles no Git

## Passo 1: Inicializar repositório

```bash
cd ~/documentos/github/dotfiles

# Inicializar git
git init

# Adicionar todos os arquivos
git add .

# Primeiro commit
git commit -m "Initial commit: Configurações profissionais do Kitty"
```

## Passo 2: Criar repositório no GitHub

1. Acesse https://github.com/new
2. Nome do repositório: `dotfiles`
3. Descrição: "Configurações profissionais para desenvolvimento"
4. Visibilidade:
   - **Privado** (recomendado) - Apenas você
   - Público - Qualquer um pode ver

5. NÃO marque "Add README" (já temos um)
6. Clique em "Create repository"

## Passo 3: Conectar com GitHub

O GitHub vai mostrar instruções. Use estas:

```bash
# Adicionar remote
git remote add origin git@github.com:SEU-USUARIO/dotfiles.git

# OU se não tiver SSH configurado:
git remote add origin https://github.com/SEU-USUARIO/dotfiles.git

# Enviar para GitHub
git branch -M main
git push -u origin main
```

## Passo 4: Configurar SSH (opcional mas recomendado)

Se você usar SSH, não precisa digitar senha toda vez:

```bash
# Gerar chave SSH (se ainda não tem)
ssh-keygen -t ed25519 -C "seu-email@exemplo.com"

# Copiar chave pública
cat ~/.ssh/id_ed25519.pub

# Adicionar no GitHub:
# 1. GitHub → Settings → SSH and GPG keys → New SSH key
# 2. Cole a chave
# 3. Salve
```

Teste:
```bash
ssh -T git@github.com
```

Deve mostrar: "Hi SEU-USUARIO! You've successfully authenticated..."

## Workflow diário

### Fazer alterações

```bash
# Editar configs
vim ~/documentos/github/dotfiles/config/kitty/kitty.conf

# Ver o que mudou
git status
git diff

# Adicionar mudanças
git add config/kitty/kitty.conf

# Commitar
git commit -m "feat: Adicionar atalho para split diagonal"

# Enviar para GitHub
git push
```

### Puxar mudanças (em outra máquina)

```bash
cd ~/documentos/github/dotfiles
git pull
./scripts/deploy.sh --force
```

## Commits semânticos (recomendado)

Use prefixos para organizar:

- `feat:` - Nova feature
  ```
  git commit -m "feat: Adicionar tema Nord"
  ```

- `fix:` - Correção
  ```
  git commit -m "fix: Corrigir transparência no i3"
  ```

- `docs:` - Documentação
  ```
  git commit -m "docs: Atualizar README com troubleshooting"
  ```

- `refactor:` - Refatoração
  ```
  git commit -m "refactor: Modularizar configuração do zsh"
  ```

- `chore:` - Manutenção
  ```
  git commit -m "chore: Atualizar .gitignore"
  ```

## Comandos úteis

```bash
# Ver histórico
git log --oneline

# Desfazer última commit (mantém mudanças)
git reset --soft HEAD~1

# Desfazer mudanças não commitadas
git checkout -- arquivo.conf

# Ver diferenças com remote
git fetch
git diff origin/main

# Criar branch para testar algo
git checkout -b experimento
# ... fazer mudanças ...
git checkout main
git merge experimento

# Sincronizar com trabalho
git pull --rebase
```

## Estrutura sugerida de branches

```
main         - Configuração estável e testada
├── work     - Customizações específicas do trabalho
└── home     - Customizações específicas de casa
```

Exemplo:
```bash
# No trabalho
git checkout -b work
# ... customizar para trabalho ...
git commit -m "feat: Adicionar proxy corporativo"

# Em casa
git checkout main
git checkout -b home
# ... customizar para casa ...
git commit -m "feat: Adicionar servidor Plex ao startup"
```

## .gitignore importante

Já está configurado, mas certifique-se que tem:

```gitignore
# Secrets
.env
.env.local
*.key
*.pem

# Pessoal
.gitconfig.local
.zshrc.local

# Caches
.cache/
.zinit/
```

## Backup automático (opcional)

Adicione ao crontab para backup automático:

```bash
# Abrir crontab
crontab -e

# Adicionar (backup diário às 18h)
0 18 * * * cd ~/documentos/github/dotfiles && git add -A && git commit -m "chore: Backup automático $(date +\%Y-\%m-\%d)" && git push
```

## Exemplo de .gitconfig (opcional)

Crie `~/documentos/github/dotfiles/.gitconfig`:

```gitconfig
[user]
    name = Seu Nome
    email = seu-email@exemplo.com

[core]
    editor = vim
    autocrlf = input

[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    lg = log --oneline --graph --all

[pull]
    rebase = true

[push]
    default = current
```

Depois linke:
```bash
ln -sf ~/documentos/github/dotfiles/.gitconfig ~/.gitconfig
```

## Primeiros passos AGORA

```bash
cd ~/documentos/github/dotfiles
git init
git add .
git commit -m "Initial commit: Setup profissional com Kitty"

# Depois crie o repo no GitHub e:
git remote add origin git@github.com:SEU-USUARIO/dotfiles.git
git push -u origin main
```

Pronto! Agora você pode replicar esse setup em qualquer máquina com um simples `git clone`!

---

**Dica:** Adicione o link do seu repositório no README.md depois de criar no GitHub!
