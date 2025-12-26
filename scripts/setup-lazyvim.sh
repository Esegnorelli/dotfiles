#!/usr/bin/env bash

# ============================================================================
# SETUP LAZYVIM - CONFIGURAÇÃO MODERNA DO NEOVIM
# ============================================================================
# Configura LazyVim com todas as features e extras recomendados

set -e

RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'
BLUE='\e[34m'
CYAN='\e[36m'

print_header() { echo -e "\n${BLUE}=== $1 ===${RC}\n"; }
print_success() { echo -e "${GREEN}✓${RC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${RC} $1"; }
print_error() { echo -e "${RED}✗${RC} $1"; }
print_info() { echo -e "${CYAN}ℹ${RC} $1"; }

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NVIM_CONFIG="$DOTFILES_DIR/config/nvim"
NVIM_DEST="$HOME/.config/nvim"

print_header "Configurando LazyVim"

# Verificar versão do Neovim
if ! command -v nvim &> /dev/null; then
    print_error "Neovim não encontrado!"
    print_info "Execute primeiro: sudo ./scripts/update-neovim.sh"
    exit 1
fi

NVIM_VERSION=$(nvim --version | head -n1 | grep -oP 'v\K[0-9]+\.[0-9]+' | head -1)
REQUIRED_VER="0.10"

if [ "$(printf '%s\n' "$REQUIRED_VER" "$NVIM_VERSION" | sort -V | head -n1)" != "$REQUIRED_VER" ]; then
    print_error "Neovim $NVIM_VERSION é muito antigo!"
    print_info "LazyVim requer >= 0.10.0"
    print_info "Execute: sudo ./scripts/update-neovim.sh"
    exit 1
fi

print_success "Neovim $NVIM_VERSION OK"

# Limpar configurações antigas
print_info "Limpar configurações antigas do Neovim? [y/N]"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    print_warning "Removendo configurações antigas..."
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
    rm -rf ~/.cache/nvim
    print_success "Limpeza concluída"
fi

# Criar estrutura de diretórios
print_info "Criando estrutura de configuração..."
mkdir -p "$NVIM_CONFIG/lua/config"
mkdir -p "$NVIM_CONFIG/lua/plugins"

# Criar init.lua principal
cat > "$NVIM_CONFIG/init.lua" << 'EOF'
-- ============================================================================
-- LAZYVIM INIT.LUA
-- ============================================================================
-- Bootstrap do LazyVim - gerenciador de plugins moderno
-- Documentação: https://www.lazyvim.org

-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Import LazyVim and all extras
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Import custom plugins
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true,  -- automatically check for plugin updates
    notify = false,  -- don't notify about updates
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Load custom configs
require("config.options")
require("config.keymaps")
require("config.autocmds")
EOF

print_success "init.lua criado"

# Criar configurações básicas
cat > "$NVIM_CONFIG/lua/config/options.lua" << 'EOF'
-- ============================================================================
-- OPTIONS - CONFIGURAÇÕES DO NEOVIM
-- ============================================================================

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Undo
opt.undofile = true
opt.undodir = vim.fn.expand("~/.vim/undodir")

-- Update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Scroll
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Command line
opt.cmdheight = 1
opt.showmode = false

-- Completion
opt.completeopt = "menuone,noselect"

-- Mouse
opt.mouse = "a"
EOF

print_success "options.lua criado"

# Criar keymaps personalizados
cat > "$NVIM_CONFIG/lua/config/keymaps.lua" << 'EOF'
-- ============================================================================
-- KEYMAPS - ATALHOS DE TECLADO PERSONALIZADOS
-- ============================================================================

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", opts)

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Better paste
keymap.set("v", "p", '"_dP', opts)

-- Quick save
keymap.set("n", "<leader>w", ":w<CR>", opts)

-- Quick quit
keymap.set("n", "<leader>q", ":q<CR>", opts)
EOF

print_success "keymaps.lua criado"

# Criar autocmds
cat > "$NVIM_CONFIG/lua/config/autocmds.lua" << 'EOF'
-- ============================================================================
-- AUTOCMDS - COMANDOS AUTOMÁTICOS
-- ============================================================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("TrimWhitespace", { clear = true }),
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Auto format on save
autocmd("BufWritePre", {
  group = augroup("AutoFormat", { clear = true }),
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
EOF

print_success "autocmds.lua criado"

# Criar configuração de plugins LazyVim
cat > "$NVIM_CONFIG/lua/plugins/lazyvim.lua" << 'EOF'
-- ============================================================================
-- LAZYVIM EXTRAS - RECURSOS ADICIONAIS
-- ============================================================================

return {
  -- Colorscheme TokyoNight
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
    },
  },

  -- Configure LazyVim colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
EOF

print_success "lazyvim.lua criado"

# Criar plugins adicionais recomendados
cat > "$NVIM_CONFIG/lua/plugins/extras.lua" << 'EOF'
-- ============================================================================
-- PLUGINS EXTRAS - FERRAMENTAS ADICIONAIS
-- ============================================================================

return {
  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
  },

  -- Better notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },

  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
            { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
            { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
            { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
            { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
            { action = "qa", desc = " Quit", icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      return opts
    end,
  },

  -- Improved syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
}
EOF

print_success "extras.lua criado"

# Criar symlink se não existir
if [ ! -L "$NVIM_DEST" ]; then
    print_info "Criando symlink da configuração..."
    ln -sf "$NVIM_CONFIG" "$NVIM_DEST"
    print_success "Symlink criado: $NVIM_DEST -> $NVIM_CONFIG"
elif [ "$(readlink "$NVIM_DEST")" != "$NVIM_CONFIG" ]; then
    print_warning "Atualizando symlink existente..."
    rm -f "$NVIM_DEST"
    ln -sf "$NVIM_CONFIG" "$NVIM_DEST"
    print_success "Symlink atualizado"
else
    print_success "Symlink já existe e está correto"
fi

# Mensagem final
print_header "LazyVim configurado com sucesso!"
echo ""
print_info "Estrutura criada em: $NVIM_CONFIG"
echo ""
print_success "Arquivos criados:"
echo "  • init.lua               - Bootstrap do LazyVim"
echo "  • lua/config/options.lua - Configurações do Neovim"
echo "  • lua/config/keymaps.lua - Atalhos personalizados"
echo "  • lua/config/autocmds.lua- Comandos automáticos"
echo "  • lua/plugins/lazyvim.lua- Configuração LazyVim"
echo "  • lua/plugins/extras.lua - Plugins adicionais"
echo ""
print_header "Próximos passos"
echo ""
echo "  1. Abra o Neovim: ${GREEN}nvim${RC}"
echo "  2. Aguarde a instalação dos plugins (alguns minutos)"
echo "  3. Feche e abra novamente o Neovim"
echo "  4. Execute ${GREEN}:checkhealth${RC} para verificar"
echo ""
print_info "Atalhos úteis:"
echo "  • ${CYAN}<leader>${RC} = ${GREEN}Espaço${RC}"
echo "  • ${CYAN}<leader>ff${RC} - Buscar arquivos"
echo "  • ${CYAN}<leader>fg${RC} - Buscar texto (grep)"
echo "  • ${CYAN}<leader>e${RC}  - Explorador de arquivos"
echo "  • ${CYAN}<leader>l${RC}  - Abrir Lazy (gerenciador de plugins)"
echo "  • ${CYAN}:Mason${RC}     - Gerenciar LSPs/formatters/linters"
echo ""
print_warning "IMPORTANTE: Na primeira vez demora!"
print_info "O LazyVim vai baixar e instalar dezenas de plugins automaticamente"
