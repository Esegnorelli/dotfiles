# 🚀 Dotfiles para Pop!_OS

Configuração completa de ambiente de desenvolvimento para Pop!_OS com terminal moderno, ferramentas de produtividade e CLIs essenciais.

## ✨ Características

### 🎨 Terminal Moderno
- **Zsh** como shell padrão
- **Oh My Zsh** para gerenciamento de configurações
- **Powerlevel10k** - tema moderno e rápido com ícones
- **Fontes Nerd Font**:
  - Meslo Nerd Font (recomendado)
  - JetBrains Mono Nerd Font
  - Fira Code Nerd Font
- **Plugins úteis**:
  - `zsh-autosuggestions` - sugestões baseadas no histórico
  - `zsh-syntax-highlighting` - destaque de sintaxe
  - `zsh-completions` - autocompletar melhorado
  - Git, Docker, e muito mais!

### ⚡ Ferramentas Modernas de Terminal
- **bat** - `cat` com syntax highlighting
- **exa** - `ls` moderno com ícones
- **fzf** - Fuzzy finder para busca rápida
- **ripgrep** - `grep` ultra rápido
- **fd** - `find` moderno e intuitivo
- **neovim** - Editor de texto moderno
- **tmux** - Multiplexador de terminal
- **htop** - Monitor de sistema interativo
- **neofetch** - Informações do sistema

### 🛠️ Ambiente de Desenvolvimento
- **Node.js** via NVM (Node Version Manager)
- **Python** via pyenv (Python Version Manager)
- **Docker** + Docker Compose
- **GitHub CLI** (gh) - Gerenciar GitHub pela linha de comando
- **Claude Code CLI** - IA para desenvolvimento

### 🌍 Configurações em PT-BR
- **Aliases personalizados** em português
- **Funções úteis** para o dia a dia
- **Configuração do Powerlevel10k** totalmente traduzida
- **Mensagens e documentação** em português

## 📋 Pré-requisitos

- Pop!_OS (ou Ubuntu/Debian)
- Conexão com a internet
- Git instalado

## 🔧 Instalação

### Opção 1: Instalação Automática (Recomendado)

```bash
# Clone este repositório
git clone https://github.com/seu-usuario/dotfiles.git ~/Documentos/dotfiles

# Entre no diretório
cd ~/Documentos/dotfiles

# Torne o script executável
chmod +x install.sh

# Execute o script de instalação
./install.sh
```

### Opção 2: Instalação Manual

1. **Instalar dependências:**
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl wget zsh fonts-powerline
```

2. **Instalar Oh My Zsh:**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

3. **Instalar Powerlevel10k:**
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

4. **Instalar plugins:**
```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-completions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

5. **Instalar fonte Meslo Nerd Font:**
```bash
mkdir -p ~/.local/share/fonts
cd /tmp
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
mv MesloLGS*.ttf ~/.local/share/fonts/
fc-cache -f -v
```

6. **Copiar arquivos de configuração:**
```bash
cp ~/Documentos/dotfiles/.zshrc ~/.zshrc
cp ~/Documentos/dotfiles/.p10k.zsh ~/.p10k.zsh
```

7. **Mudar shell padrão:**
```bash
chsh -s $(which zsh)
```

## ⚙️ Pós-instalação

1. **Configurar fonte no terminal:**
   - Abra as configurações do seu terminal (GNOME Terminal, Tilix, etc)
   - Vá em Perfil → Texto
   - Selecione a fonte **MesloLGS NF Regular**

2. **Reiniciar sessão:**
   - Faça logout e login novamente
   - Ou simplesmente feche e abra o terminal

3. **Primeira execução:**
   - Na primeira vez, o Powerlevel10k pode pedir para configurar
   - Se preferir usar a configuração deste repositório, pressione `q` para pular

## 🎨 Personalização

### Reconfigurar Powerlevel10k

```bash
p10k configure
```

### Editar configurações do Zsh

```bash
nano ~/.zshrc
# ou
editar-zsh
```

Após editar, recarregue as configurações:

```bash
source ~/.zshrc
# ou
recarregar-zsh
```

### Editar configurações do Powerlevel10k

```bash
nano ~/.p10k.zsh
```

## 📚 Comandos e Aliases Úteis

### Sistema
```bash
atualizar          # Atualiza o sistema
instalar <pacote>  # Instala um pacote
remover <pacote>   # Remove um pacote
limpar             # Remove pacotes desnecessários
```

### Navegação
```bash
..      # Volta um diretório
...     # Volta dois diretórios
....    # Volta três diretórios
mkcd    # Cria e entra em um diretório
```

### Git
```bash
gs      # git status
ga      # git add
gc      # git commit
gp      # git push
gl      # git log (versão bonita)
gd      # git diff
gco     # git checkout
gb      # git branch
```

### Docker
```bash
dps     # docker ps
dpsa    # docker ps -a
di      # docker images
dex     # docker exec -it
dlogs   # docker logs -f
```

### Utilitários
```bash
meu-ip           # Mostra seu IP público
ip-local         # Mostra seu IP local
uso-disco        # Mostra uso do disco
uso-memoria      # Mostra uso da memória
backup <arquivo> # Faz backup de um arquivo
buscar <nome>    # Busca arquivo por nome
extrair <arquivo> # Extrai arquivos compactados
```

### Funções Personalizadas
```bash
help      # Mostra comandos úteis
aliases   # Lista todos os aliases disponíveis
```

## 🚀 Ferramentas Instaladas

### Ferramentas Modernas de Terminal

#### bat - cat aprimorado
```bash
cat arquivo.txt    # Usa bat automaticamente com syntax highlighting
catp arquivo.txt   # bat com paginação
```

#### exa - ls moderno
```bash
ls       # Lista arquivos com ícones
ll       # Lista detalhada com ícones e info do git
tree     # Visualiza estrutura de diretórios em árvore
```

#### fzf - Fuzzy Finder
```bash
Ctrl+R   # Busca no histórico de comandos
Ctrl+T   # Busca arquivos no diretório atual
Alt+C    # Navega para um diretório
```

#### ripgrep e fd
```bash
grep "texto"      # Busca rápida com ripgrep (alias para rg)
find "arquivo"    # Busca de arquivos com fd
```

#### neovim
```bash
nvim arquivo.txt  # Editor de texto moderno
vim arquivo.txt   # Alias para nvim
vi arquivo.txt    # Alias para nvim
```

### Gerenciadores de Versão

#### NVM - Node.js
```bash
nvm install 20       # Instala Node.js versão 20
nvm use 20           # Usa Node.js versão 20
nvm list             # Lista versões instaladas
node --version       # Verifica versão atual
npm --version        # Verifica versão do npm
```

#### pyenv - Python
```bash
pyenv install 3.12.0  # Instala Python 3.12.0
pyenv global 3.12.0   # Define versão global
pyenv local 3.11.0    # Define versão local (por projeto)
pyenv versions        # Lista versões instaladas
python --version      # Verifica versão atual
```

### Docker

```bash
docker ps            # Lista containers em execução
docker-compose up -d # Inicia containers em background
```

**Nota:** Após a instalação, faça logout/login para usar Docker sem sudo.

### CLIs de Desenvolvimento

#### GitHub CLI
```bash
gh auth login        # Fazer login no GitHub
gh repo create       # Criar repositório
gh pr create         # Criar pull request
gh issue list        # Listar issues
```

#### Claude Code
```bash
claude auth login    # Fazer login no Claude Code
claude               # Iniciar sessão interativa
```

## 🔄 Atualização

Para atualizar os dotfiles:

```bash
cd ~/Documentos/dotfiles
git pull
./install.sh
```

Ou simplesmente:

```bash
atualizar-dotfiles
```

## 🎯 Estrutura do Repositório

```
dotfiles/
├── .zshrc              # Configuração principal do Zsh
├── .p10k.zsh           # Configuração do Powerlevel10k (PT-BR)
├── install.sh          # Script de instalação automatizada
└── README.md           # Este arquivo
```

## 🐛 Solução de Problemas

### Ícones não aparecem corretamente

1. Verifique se a fonte Meslo Nerd Font está instalada:
```bash
fc-list | grep -i meslo
```

2. Configure a fonte no terminal para **MesloLGS NF**

### Prompt não aparece corretamente

1. Recarregue as configurações:
```bash
source ~/.zshrc
```

2. Reconfigure o Powerlevel10k:
```bash
p10k configure
```

### Plugins não funcionam

1. Verifique se os plugins estão instalados:
```bash
ls ~/.oh-my-zsh/custom/plugins/
```

2. Reinstale os plugins seguindo as instruções de instalação manual

### Comando não encontrado após instalação

1. Certifique-se de que o Zsh é o shell padrão:
```bash
echo $SHELL
```

2. Se não for `/usr/bin/zsh`, execute:
```bash
chsh -s $(which zsh)
```

3. Faça logout e login novamente

## 📝 Notas

- O arquivo `.zshrc` contém comentários explicativos em português
- A configuração do Powerlevel10k está totalmente traduzida para PT-BR
- Todos os aliases e funções estão em português para facilitar o uso
- O histórico é compartilhado entre todas as sessões do Zsh

## 🤝 Contribuindo

Sinta-se à vontade para:
- Reportar bugs
- Sugerir melhorias
- Adicionar novos aliases ou funções
- Melhorar a documentação

## 📄 Licença

Este projeto está sob licença MIT. Sinta-se livre para usar e modificar como desejar.

## ✨ Créditos

### Terminal e Shell
- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-completions](https://github.com/zsh-users/zsh-completions)

### Ferramentas Modernas
- [bat](https://github.com/sharkdp/bat)
- [exa](https://github.com/ogham/exa)
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [neovim](https://neovim.io/)

### Gerenciadores e CLIs
- [NVM](https://github.com/nvm-sh/nvm)
- [pyenv](https://github.com/pyenv/pyenv)
- [Docker](https://www.docker.com/)
- [GitHub CLI](https://cli.github.com/)
- [Claude Code](https://claude.com/claude-code)

## 📧 Contato

Para dúvidas ou sugestões, abra uma issue no GitHub.

---

**Aproveite seu novo terminal! 🎉**
