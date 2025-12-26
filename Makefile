# ============================================================================
# DOTFILES MAKEFILE
# ============================================================================
# Comandos úteis para gerenciar dotfiles
# Uso: make <comando>

.PHONY: help install deploy backup clean health update sync test

# Cores
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[1;33m
NC := \033[0m

# Padrão: mostrar ajuda
help:
	@echo "$(BLUE)════════════════════════════════════════════════════════$(NC)"
	@echo "$(GREEN)  DOTFILES - Comandos Disponíveis$(NC)"
	@echo "$(BLUE)════════════════════════════════════════════════════════$(NC)"
	@echo ""
	@echo "  $(YELLOW)make install$(NC)  - Instalar todas as dependências"
	@echo "  $(YELLOW)make deploy$(NC)   - Aplicar configurações (com backup)"
	@echo "  $(YELLOW)make update$(NC)   - Atualizar do Git e aplicar"
	@echo "  $(YELLOW)make sync$(NC)     - Commit + push + deploy"
	@echo "  $(YELLOW)make backup$(NC)   - Criar backup manual"
	@echo "  $(YELLOW)make health$(NC)   - Verificar saúde do setup"
	@echo "  $(YELLOW)make clean$(NC)    - Limpar backups antigos"
	@echo "  $(YELLOW)make test$(NC)     - Testar configurações"
	@echo "  $(YELLOW)make nvim$(NC)     - Setup completo do Neovim (LazyVim)"
	@echo "  $(YELLOW)make optimize$(NC) - Otimizar Pop!_OS (ferramentas modernas)"
	@echo ""
	@echo "$(BLUE)════════════════════════════════════════════════════════$(NC)"

# Instalar dependências
install:
	@echo "$(GREEN)Instalando dependências...$(NC)"
	@chmod +x scripts/*.sh
	@./scripts/install-deps.sh

# Deploy das configurações
deploy:
	@echo "$(GREEN)Aplicando configurações...$(NC)"
	@./scripts/deploy.sh --backup

# Deploy forçado (sem backup)
deploy-force:
	@echo "$(YELLOW)Aplicando configurações (forçado)...$(NC)"
	@./scripts/deploy.sh --force

# Atualizar do Git e aplicar
update:
	@echo "$(GREEN)Atualizando dotfiles...$(NC)"
	@git pull
	@./scripts/deploy.sh --force
	@echo "$(GREEN)✓ Atualizado!$(NC)"

# Sincronizar: commit local + pull + deploy
sync:
	@echo "$(GREEN)Sincronizando dotfiles...$(NC)"
	@git add .
	@git status --short
	@read -p "Mensagem do commit: " msg; \
	git commit -m "$$msg" || true
	@git pull --rebase
	@git push
	@./scripts/deploy.sh --force
	@echo "$(GREEN)✓ Sincronizado!$(NC)"

# Criar backup manual
backup:
	@echo "$(GREEN)Criando backup...$(NC)"
	@backup_dir="$$HOME/.dotfiles-backup-$$(date +%Y%m%d-%H%M%S)"; \
	mkdir -p "$$backup_dir"; \
	[ -f ~/.zshrc ] && cp ~/.zshrc "$$backup_dir/"; \
	[ -f ~/.bashrc ] && cp ~/.bashrc "$$backup_dir/"; \
	[ -d ~/.config/kitty ] && cp -r ~/.config/kitty "$$backup_dir/"; \
	[ -d ~/.config/nvim ] && cp -r ~/.config/nvim "$$backup_dir/"; \
	echo "$(GREEN)✓ Backup criado em: $$backup_dir$(NC)"

# Verificar saúde
health:
	@echo "$(BLUE)Verificando saúde dos dotfiles...$(NC)"
	@echo ""
	@if [ -d ~/documentos/github/dotfiles ]; then \
		echo "$(GREEN)✓$(NC) Diretório de dotfiles encontrado"; \
	else \
		echo "$(YELLOW)✗$(NC) Diretório de dotfiles NÃO encontrado"; \
	fi
	@if [ -L ~/.config/kitty/kitty.conf ]; then \
		echo "$(GREEN)✓$(NC) kitty.conf está linkado"; \
	else \
		echo "$(YELLOW)✗$(NC) kitty.conf NÃO está linkado"; \
	fi
	@if [ -d .git ]; then \
		echo "$(GREEN)✓$(NC) Git configurado"; \
		echo "  Branch: $$(git branch --show-current)"; \
	else \
		echo "$(YELLOW)✗$(NC) Git NÃO inicializado"; \
	fi
	@echo ""
	@echo "$(BLUE)Ferramentas:$(NC)"
	@command -v kitty >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) Kitty instalado" || echo "$(YELLOW)✗$(NC) Kitty não instalado"
	@command -v nvim >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) Neovim instalado" || echo "$(YELLOW)✗$(NC) Neovim não instalado"
	@command -v fzf >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) FZF instalado" || echo "$(YELLOW)✗$(NC) FZF não instalado"
	@command -v rg >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) ripgrep instalado" || echo "$(YELLOW)✗$(NC) ripgrep não instalado"
	@fc-list | grep -qi JetBrains && echo "$(GREEN)✓$(NC) JetBrains Mono Nerd Font instalada" || echo "$(YELLOW)✗$(NC) Fonte não instalada"

# Limpar backups antigos (manter só os 3 mais recentes)
clean:
	@echo "$(YELLOW)Limpando backups antigos...$(NC)"
	@cd ~ && ls -dt .dotfiles-backup-* 2>/dev/null | tail -n +4 | xargs -r rm -rf
	@echo "$(GREEN)✓ Backups antigos removidos (mantidos os 3 mais recentes)$(NC)"

# Testar configurações
test:
	@echo "$(BLUE)Testando configurações...$(NC)"
	@echo ""
	@echo "$(YELLOW)Testando Kitty...$(NC)"
	@kitty --version || echo "$(YELLOW)Kitty não encontrado$(NC)"
	@echo ""
	@echo "$(YELLOW)Testando Neovim...$(NC)"
	@nvim --version | head -n1 || echo "$(YELLOW)Neovim não encontrado$(NC)"
	@echo ""
	@echo "$(YELLOW)Testando cores...$(NC)"
	@echo "TERM: $$TERM"
	@echo "COLORTERM: $$COLORTERM"
	@echo ""
	@echo "$(GREEN)✓ Testes concluídos$(NC)"

# Setup completo do Neovim (LazyVim)
nvim:
	@echo "$(GREEN)═══════════════════════════════════════════$(NC)"
	@echo "$(BLUE)  Setup do Neovim + LazyVim$(NC)"
	@echo "$(GREEN)═══════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)Este processo vai:$(NC)"
	@echo "  1. Atualizar Neovim para >= 0.10.0"
	@echo "  2. Instalar dependências (Node, Go, LSPs)"
	@echo "  3. Configurar LazyVim do zero"
	@echo ""
	@echo "$(YELLOW)Requer sudo para instalar pacotes.$(NC)"
	@echo ""
	@read -p "Continuar? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		echo "$(GREEN)Iniciando setup...$(NC)"; \
		sudo ./scripts/update-neovim.sh && \
		sudo ./scripts/install-dependencies.sh && \
		./scripts/setup-lazyvim.sh && \
		echo "" && \
		echo "$(GREEN)✓ Setup do Neovim concluído!$(NC)" && \
		echo "$(BLUE)Abra o Neovim e aguarde a instalação dos plugins: nvim$(NC)"; \
	else \
		echo "$(YELLOW)Setup cancelado.$(NC)"; \
	fi

# Otimizar Pop!_OS
optimize:
	@echo "$(GREEN)═══════════════════════════════════════════$(NC)"
	@echo "$(BLUE)  Otimização do Pop!_OS$(NC)"
	@echo "$(GREEN)═══════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)Este processo vai instalar:$(NC)"
	@echo "  • bat       - Cat moderno"
	@echo "  • eza       - Ls com ícones"
	@echo "  • zoxide    - CD inteligente"
	@echo "  • starship  - Prompt moderno"
	@echo "  • delta     - Git diff melhorado"
	@echo "  • htop, ncdu, tldr, jq, stow, e mais..."
	@echo ""
	@echo "$(YELLOW)Também vai:$(NC)"
	@echo "  • Configurar aliases úteis"
	@echo "  • Otimizar swappiness e file watchers"
	@echo "  • Configurar Git com delta"
	@echo "  • Instalar Starship prompt"
	@echo ""
	@echo "$(YELLOW)Requer sudo.$(NC)"
	@echo ""
	@read -p "Continuar? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		sudo ./scripts/optimize-popos.sh; \
	else \
		echo "$(YELLOW)Otimização cancelada.$(NC)"; \
	fi

# Inicializar Git (se ainda não foi)
git-init:
	@if [ ! -d .git ]; then \
		echo "$(GREEN)Inicializando Git...$(NC)"; \
		git init; \
		git add .; \
		git commit -m "Initial commit: Dotfiles profissionais"; \
		echo "$(GREEN)✓ Git inicializado$(NC)"; \
		echo "$(BLUE)Próximo passo: Adicione o remote$(NC)"; \
		echo "  git remote add origin git@github.com:SEU-USUARIO/dotfiles.git"; \
		echo "  git push -u origin main"; \
	else \
		echo "$(YELLOW)Git já está inicializado$(NC)"; \
	fi

# Quick commit (commit rápido com mensagem padrão)
quick-commit:
	@git add .
	@git commit -m "chore: Quick update $$(date +%Y-%m-%d\ %H:%M)"
	@git push
	@echo "$(GREEN)✓ Commit rápido concluído!$(NC)"

# Listar estrutura
list:
	@echo "$(BLUE)Estrutura dos dotfiles:$(NC)"
	@tree -L 2 -I '.git' || ls -lah

# Recarregar shell atual
reload:
	@echo "$(GREEN)Recarregando shell...$(NC)"
	@if [ -n "$$ZSH_VERSION" ]; then \
		zsh -c 'source ~/.zshrc' && echo "$(GREEN)✓ ZSH recarregado$(NC)"; \
	elif [ -n "$$BASH_VERSION" ]; then \
		bash -c 'source ~/.bashrc' && echo "$(GREEN)✓ Bash recarregado$(NC)"; \
	else \
		echo "$(YELLOW)Shell não reconhecido$(NC)"; \
	fi
