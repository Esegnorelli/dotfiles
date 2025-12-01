# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/lang/pt-BR/).

## [1.0.0] - 2023-11-30

### ✨ Adicionado

#### Configuração Principal
- Arquivo `.zshrc` completo com configurações personalizadas
- Arquivo `.p10k.zsh` totalmente traduzido para PT-BR
- Script de instalação automatizada (`install.sh`)
- Suporte completo ao Pop!_OS e distribuições baseadas em Ubuntu/Debian

#### Fonte
- Instalação automática da fonte Meslo Nerd Font
- Suporte completo a ícones no terminal
- Quatro variantes da fonte (Regular, Bold, Italic, Bold Italic)

#### Plugins
- **zsh-autosuggestions** - Sugestões automáticas baseadas no histórico
- **zsh-syntax-highlighting** - Destaque de sintaxe em tempo real
- **zsh-completions** - Autocompletações adicionais
- **git** - Aliases e funções para Git
- **docker** - Autocompletar para Docker
- **docker-compose** - Autocompletar para Docker Compose
- **sudo** - Adicionar sudo pressionando ESC duas vezes
- **command-not-found** - Sugestão de pacotes
- **colored-man-pages** - Páginas man coloridas
- **extract** - Extração inteligente de arquivos
- **z** - Navegação rápida entre diretórios
- **history** - Aliases para histórico

#### Aliases em Português
- **Navegação**: `..`, `...`, `....`, `~`
- **Listagem**: `ll`, `la`, `l`
- **Git**: `gs`, `ga`, `gc`, `gp`, `gl`, `gd`, `gco`, `gb`
- **Apt**: `atualizar`, `instalar`, `remover`, `limpar`
- **Sistema**: `uso-disco`, `uso-memoria`, `portas`, `processos`
- **Docker**: `dps`, `dpsa`, `di`, `dex`, `dlogs`
- **Rede**: `meu-ip`, `ip-local`
- **Utilitários**: `c`, `h`, `j`

#### Funções Personalizadas
- `mkcd` - Criar diretório e entrar nele
- `extrair` - Extrair diversos formatos de arquivo
- `buscar` - Buscar arquivo por nome
- `proc` - Buscar processo
- `tamanho` - Ver tamanho de diretório
- `backup` - Criar backup de arquivo com timestamp
- `help` - Mostrar comandos úteis
- `aliases` - Listar todos os aliases disponíveis

#### Configurações do Powerlevel10k
- Prompt em duas linhas
- Ícones personalizados para cada elemento
- Cores configuradas para melhor visibilidade
- Status do Git com indicadores visuais
- Tempo de execução de comandos (≥3s)
- Indicador de jobs em background
- Suporte a Python, Node.js, Ruby, Go, etc.
- Suporte a Kubernetes, AWS, Terraform
- Relógio em formato 24h
- Todas as mensagens em PT-BR

#### Documentação
- README.md completo em português
- EXEMPLOS.md com casos de uso práticos
- CHANGELOG.md para rastrear versões
- Comentários explicativos em todos os arquivos

#### Recursos do Sistema
- Histórico compartilhado entre sessões
- Histórico de 10.000 comandos
- Remoção automática de duplicatas
- Locale configurado para pt_BR.UTF-8
- Confirmação para comandos destrutivos (rm, cp, mv)
- Autocompletação case-insensitive
- Menu de seleção para completação
- Cache de completação

### 🔧 Configurado

#### Terminal
- Shell padrão alterado para Zsh
- Oh My Zsh como framework de gerenciamento
- Powerlevel10k como tema padrão
- Fonte Meslo Nerd Font configurada

#### Git
- Aliases otimizados para workflow
- Log com gráfico visual
- Status e diff facilitados

#### Sistema
- PATH atualizado com `~/.local/bin` e `~/bin`
- Editor padrão configurado (nano)
- Variáveis de ambiente otimizadas

### 📝 Documentado

- Instruções de instalação (automática e manual)
- Guia de personalização
- Solução de problemas comuns
- Exemplos práticos de uso
- Referência de comandos e aliases
- Workflow de desenvolvimento
- Dicas e truques

### 🎨 Melhorias

- Interface moderna e responsiva
- Prompt rápido com instant prompt
- Sugestões inteligentes
- Destaque de sintaxe
- Mensagens de erro em PT-BR
- Feedback visual para status de comandos

## [Futuro] - Planejado

### A Adicionar
- [ ] Suporte a tmux
- [ ] Configuração de vim/neovim
- [ ] Aliases para Flatpak
- [ ] Integração com ferramentas de desenvolvimento (npm, cargo, etc)
- [ ] Scripts de backup automático
- [ ] Temas alternativos do Powerlevel10k
- [ ] Suporte a mais ferramentas de DevOps
- [ ] Configuração de SSH
- [ ] Aliases para systemctl
- [ ] Função de atualização automática dos dotfiles

### A Melhorar
- [ ] Otimização do tempo de carregamento
- [ ] Mais exemplos de uso
- [ ] Vídeos tutoriais
- [ ] Screenshots do terminal configurado
- [ ] Testes automatizados do script de instalação
- [ ] Suporte a mais distribuições Linux
- [ ] Configuração de cores personalizáveis
- [ ] Perfis diferentes (dev, admin, minimal)

---

## Legenda

- **Adicionado**: Novas funcionalidades
- **Alterado**: Mudanças em funcionalidades existentes
- **Descontinuado**: Funcionalidades que serão removidas
- **Removido**: Funcionalidades removidas
- **Corrigido**: Correções de bugs
- **Segurança**: Correções de vulnerabilidades
