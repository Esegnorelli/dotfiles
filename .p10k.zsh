# ============================================================================
# Configuração do Powerlevel10k - Traduzido para PT-BR
# Gerado por `p10k configure` e customizado
# ============================================================================

# Instant prompt não deve ser modificado. Vá para o final do arquivo para customização.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  # Descomente esta linha para usar instant prompt
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

  # ============================================================================
  # Estilo do Prompt
  # ============================================================================

  # Estilo: rainbow, lean, classic ou pure
  typeset -g POWERLEVEL9K_MODE=nerdfont-complete

  # ============================================================================
  # Elementos do Prompt
  # ============================================================================

  # Prompt esquerdo
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon                 # Ícone do sistema operacional
    dir                     # Diretório atual
    vcs                     # Controle de versão (git, svn, etc)
    prompt_char            # Caractere do prompt
  )

  # Prompt direito
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status                  # Status do último comando
    command_execution_time  # Tempo de execução do comando
    background_jobs         # Jobs em background
    virtualenv             # Python virtualenv
    anaconda               # Conda environment
    pyenv                  # Pyenv
    goenv                  # Go version
    nodenv                 # Node.js version
    nvm                    # Node version manager
    nodeenv                # Node.js environment
    rbenv                  # Ruby version
    rvm                    # Ruby version manager
    kubecontext            # Kubernetes context
    terraform              # Terraform workspace
    aws                    # AWS profile
    time                   # Hora atual
  )

  # ============================================================================
  # Configurações de Cores
  # ============================================================================

  # Esquema de cores: rainbow ou flat
  typeset -g POWERLEVEL9K_COLOR_SCHEME=dark

  # ============================================================================
  # Ícone do OS
  # ============================================================================

  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=white
  typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=black

  # ============================================================================
  # Caractere do Prompt
  # ============================================================================

  # Símbolo quando o último comando foi bem-sucedido
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=green
  # Símbolo quando o último comando falhou
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=red

  # Símbolos do prompt
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'

  # ============================================================================
  # Diretório Atual
  # ============================================================================

  # Cores do diretório
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=blue
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=black

  # Encurtar diretórios longos
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

  # Mostrar âncora do diretório (home, /, etc)
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true

  # Substituir $HOME por ~
  typeset -g POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=false

  # Cores especiais para diretórios específicos
  typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=red
  typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=black

  # ============================================================================
  # Git (VCS)
  # ============================================================================

  # Mostrar branch
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=''

  # Cores para estado limpo (sem modificações)
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=green
  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=black

  # Cores para modificações não commitadas
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=yellow
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=black

  # Cores para modificações
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=yellow
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=black

  # Ícones de estado do Git
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
  typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='!'
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON='+'
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='⇣'
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='⇡'
  typeset -g POWERLEVEL9K_VCS_STASH_ICON='*'
  typeset -g POWERLEVEL9K_VCS_TAG_ICON='🏷️ '

  # Commits à frente/atrás do remote
  typeset -g POWERLEVEL9K_VCS_COMMITS_AHEAD_MAX_NUM=10
  typeset -g POWERLEVEL9K_VCS_COMMITS_BEHIND_MAX_NUM=10

  # ============================================================================
  # Status do Comando
  # ============================================================================

  # Mostrar status apenas quando o comando falhou
  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_ERROR=true

  # Cores
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=red
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=black

  # Formato: apenas ícone ou código de erro
  typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'

  # ============================================================================
  # Tempo de Execução do Comando
  # ============================================================================

  # Mostrar tempo de execução apenas se >= 3 segundos
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3

  # Cores
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=yellow
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=black

  # Precisão
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2

  # Formato: 1d 2h 3m 4s
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'

  # Ícone
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION='⏱️ '

  # ============================================================================
  # Jobs em Background
  # ============================================================================

  # Cores
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=cyan
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=black

  # Ícone
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION='⚙'

  # ============================================================================
  # Python Virtual Environment
  # ============================================================================

  # Cores
  typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=blue
  typeset -g POWERLEVEL9K_VIRTUALENV_BACKGROUND=black

  # Mostrar apenas o nome do environment
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false

  # Ícone
  typeset -g POWERLEVEL9K_VIRTUALENV_VISUAL_IDENTIFIER_EXPANSION='🐍 '

  # ============================================================================
  # Anaconda
  # ============================================================================

  typeset -g POWERLEVEL9K_ANACONDA_FOREGROUND=blue
  typeset -g POWERLEVEL9K_ANACONDA_BACKGROUND=black
  typeset -g POWERLEVEL9K_ANACONDA_VISUAL_IDENTIFIER_EXPANSION='🅒 '

  # ============================================================================
  # Node.js
  # ============================================================================

  typeset -g POWERLEVEL9K_NVM_FOREGROUND=green
  typeset -g POWERLEVEL9K_NVM_BACKGROUND=black
  typeset -g POWERLEVEL9K_NVM_VISUAL_IDENTIFIER_EXPANSION='⬢ '

  # ============================================================================
  # Ruby
  # ============================================================================

  typeset -g POWERLEVEL9K_RBENV_FOREGROUND=red
  typeset -g POWERLEVEL9K_RBENV_BACKGROUND=black
  typeset -g POWERLEVEL9K_RBENV_VISUAL_IDENTIFIER_EXPANSION='💎 '

  # ============================================================================
  # Kubernetes
  # ============================================================================

  typeset -g POWERLEVEL9K_KUBECONTEXT_FOREGROUND=cyan
  typeset -g POWERLEVEL9K_KUBECONTEXT_BACKGROUND=black
  typeset -g POWERLEVEL9K_KUBECONTEXT_VISUAL_IDENTIFIER_EXPANSION='☸️ '

  # Mostrar namespace
  typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_DEFAULT_NAMESPACE=true

  # ============================================================================
  # AWS
  # ============================================================================

  typeset -g POWERLEVEL9K_AWS_FOREGROUND=yellow
  typeset -g POWERLEVEL9K_AWS_BACKGROUND=black
  typeset -g POWERLEVEL9K_AWS_VISUAL_IDENTIFIER_EXPANSION='☁️ '

  # ============================================================================
  # Terraform
  # ============================================================================

  typeset -g POWERLEVEL9K_TERRAFORM_FOREGROUND=magenta
  typeset -g POWERLEVEL9K_TERRAFORM_BACKGROUND=black
  typeset -g POWERLEVEL9K_TERRAFORM_VISUAL_IDENTIFIER_EXPANSION='💠 '

  # ============================================================================
  # Hora
  # ============================================================================

  # Formato: 24h ou 12h
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'

  # Cores
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=white
  typeset -g POWERLEVEL9K_TIME_BACKGROUND=black

  # Ícone
  typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION='🕐 '

  # Atualizar a cada segundo
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false

  # ============================================================================
  # Configurações Gerais
  # ============================================================================

  # Espaçamento entre elementos do prompt
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=' '

  # Ícone de conexão entre prompts esquerdo e direito
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=' '
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND=

  # Cor de fundo do prompt vazio
  typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_FIRST_SEGMENT_END_SYMBOL='%{%}'
  typeset -g POWERLEVEL9K_EMPTY_LINE_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='%{%}'

  # Estilo do prompt em várias linhas
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=''
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=''

  # Sufixo do prompt esquerdo
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=' '

  # Prefixo do prompt direito
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=' '

  # Desabilitar espaço extra no final do prompt direito
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=''

  # Adicionar uma linha vazia antes de cada prompt
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  # Transient prompt: limpar prompts anteriores
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off

  # Instant prompt mode
  #   - off:     Desabilitado
  #   - quiet:   Habilitado, sem avisos
  #   - verbose: Habilitado, com avisos (padrão)
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

  # Hot reload: permite recarregar a configuração sem reiniciar o shell
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=false

  # ============================================================================
  # Customizações Adicionais
  # ============================================================================

  # Se você quiser adicionar elementos customizados, adicione-os aqui
  # Exemplo: custom_element
  # typeset -g POWERLEVEL9K_CUSTOM_ELEMENT_FOREGROUND=white
  # typeset -g POWERLEVEL9K_CUSTOM_ELEMENT_BACKGROUND=black

  # ============================================================================
  # Fim da Configuração
  # ============================================================================

  # Aplicar configurações
  (( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
  'builtin' 'unset' 'p10k_config_opts'
}
