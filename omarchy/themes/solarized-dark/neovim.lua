-- Solarized Dark for LazyVim on Omarchy.
--
-- solarized.nvim's variants remap Solarized's syntax roles and add tones the
-- palette does not have (base04 #002731 and the mix_* blends). on_colors folds
-- those tones into base02, and the highlights below restore the mapping of the
-- reference vim-colors-solarized (github.com/altercation/solarized). The editor
-- stays see-through as Omarchy's glass leaves it; floating windows get a solid
-- base02 so the command line and menus stay legible over the wallpaper.
local c = {
  base03 = "#002b36", base02 = "#073642", base01 = "#586e75", base00 = "#657b83",
  base0 = "#839496", base1 = "#93a1a1", base2 = "#eee8d5", base3 = "#fdf6e3",
  yellow = "#b58900", orange = "#cb4b16", red = "#dc322f", magenta = "#d33682",
  violet = "#6c71c4", blue = "#268bd2", cyan = "#2aa198", green = "#859900",
}

local highlights = {
  -- Syntax, as vim-colors-solarized maps it
  Comment = { fg = c.base01, italic = true },
  Constant = { fg = c.cyan },
  String = { link = "Constant" },
  Character = { link = "Constant" },
  Number = { link = "Constant" },
  Boolean = { link = "Constant" },
  Float = { link = "Constant" },
  Identifier = { fg = c.blue },
  Function = { link = "Identifier" },
  Property = { link = "Identifier" },
  Parameter = { link = "Identifier" },
  Statement = { fg = c.green },
  Conditional = { link = "Statement" },
  Repeat = { link = "Statement" },
  Label = { link = "Statement" },
  Operator = { link = "Statement" },
  Keyword = { link = "Statement" },
  Exception = { link = "Statement" },
  PreProc = { fg = c.orange },
  Include = { link = "PreProc" },
  Define = { link = "PreProc" },
  Macro = { link = "PreProc" },
  PreCondit = { link = "PreProc" },
  Type = { fg = c.yellow },
  StorageClass = { link = "Type" },
  Structure = { link = "Type" },
  Typedef = { link = "Type" },
  Special = { fg = c.red },
  SpecialChar = { link = "Special" },
  SpecialComment = { link = "Special" },
  Debug = { link = "Special" },
  -- Tree-sitter tags every bracket and comma as Delimiter, which Vim's own
  -- syntax files rarely did; Special red there would paint all punctuation.
  Delimiter = { fg = c.base0 },
  Tag = { fg = c.blue, bold = true }, -- htmlTagName
  TagAttribute = { fg = c.base00 }, -- htmlArg
  TagDelimiter = { fg = c.base01 }, -- htmlTag
  Underlined = { fg = c.violet },
  Ignore = {},
  Error = { fg = c.red, bold = true },
  Todo = { fg = c.magenta, bold = true },
  -- Tree-sitter captures solarized.nvim points at Keyword or Statement
  ["@type.builtin"] = { link = "Type" },
  ["@attribute"] = { link = "PreProc" },
  ["@keyword.directive"] = { link = "PreProc" },
  ["@keyword.directive.define"] = { link = "PreProc" },
  ["@punctuation.special"] = { link = "Special" },
  ["@string.escape"] = { link = "Special" },
  ["@character.printf"] = { link = "Special" },
  ["@string.documentation"] = { link = "String" },

  -- Interface, with vim-colors-solarized's reverse-video groups spelled out
  Title = { fg = c.orange, bold = true },
  Directory = { fg = c.blue },
  Visual = { fg = c.base03, bg = c.base01 },
  VisualNOS = { link = "Visual" },
  Search = { fg = c.base03, bg = c.yellow },
  IncSearch = { fg = c.base03, bg = c.orange },
  CurSearch = { link = "IncSearch" },
  Substitute = { link = "IncSearch" },
  MatchParen = { fg = c.red, bg = c.base01, bold = true },
  ErrorMsg = { fg = c.base03, bg = c.red },
  WarningMsg = { fg = c.red, bold = true },
  MoreMsg = { fg = c.blue },
  ModeMsg = { fg = c.blue },
  Question = { fg = c.cyan, bold = true },
  WildMenu = { fg = c.base02, bg = c.base2 },
  NonText = { fg = c.base00, bold = true },
  SpecialKey = { fg = c.base00, bg = c.base02, bold = true },
  Conceal = { fg = c.blue },
  LspInlayHint = { fg = c.base01 }, -- solarized.nvim shades cyan inline, off-palette
  SpellBad = { undercurl = true, sp = c.red },
  SpellCap = { undercurl = true, sp = c.violet },
  SpellRare = { undercurl = true, sp = c.cyan },
  SpellLocal = { undercurl = true, sp = c.yellow },
  DiffAdd = { fg = c.green, bg = c.base02, bold = true, sp = c.green },
  DiffChange = { fg = c.yellow, bg = c.base02, bold = true, sp = c.yellow },
  DiffDelete = { fg = c.red, bg = c.base02, bold = true },
  DiffText = { fg = c.blue, bg = c.base02, bold = true, sp = c.blue },
  WinSeparator = { fg = c.base00 },

  -- Floating windows: solid base02 over the see-through editor
  NormalFloat = { fg = c.base0, bg = c.base02 },
  FloatBorder = { fg = c.base01, bg = c.base02 },
  FloatTitle = { fg = c.orange, bg = c.base02, bold = true },
  WhichKeyFloat = { fg = c.base0, bg = c.base02 },
  Pmenu = { fg = c.base0, bg = c.base02 },
  PmenuSel = { fg = c.base2, bg = c.base01 },
  PmenuKind = { link = "Pmenu" },
  PmenuKindSel = { link = "PmenuSel" },
  PmenuExtra = { fg = c.base01, bg = c.base02 },
  PmenuExtraSel = { link = "PmenuSel" },
  PmenuSbar = { bg = c.base02 },
  PmenuThumb = { bg = c.base01 },
  BlinkCmpMenuBorder = { link = "FloatBorder" },
  BlinkCmpDocBorder = { link = "FloatBorder" },
  BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },
  NoiceCmdlinePopup = { link = "NormalFloat" },
  NoiceCmdlinePopupBorder = { link = "FloatBorder" },
  NoiceCmdlinePopupTitle = { link = "FloatTitle" },
  NoiceCmdlineIcon = { fg = c.blue, bg = c.base02 },
  NoiceCmdlinePopupBorderSearch = { fg = c.yellow, bg = c.base02 },
  NoiceCmdlineIconSearch = { fg = c.yellow, bg = c.base02 },
}

-- Whole-group replacement: solarized.nvim's on_highlights merges into existing
-- groups, which would keep attributes such as SpellBad's strikethrough.
local function apply()
  if vim.g.colors_name ~= "solarized" then
    return
  end
  for group, spec in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

return {
  {
    "maxmx03/solarized.nvim",
    name = "solarized.nvim",
    priority = 1000,
    opts = {
      on_colors = function(colors)
        local folded = { base04 = colors.base02 }
        for name in pairs(colors) do
          if name:match("^mix_") then
            folded[name] = colors.base02
          end
        end
        return folded
      end,
    },
    config = function(_, opts)
      vim.o.termguicolors = true
      vim.o.background = "dark"
      require("solarized").setup(opts)
      -- Omarchy's plugin/after/transparency.lua clears backgrounds after the
      -- colorscheme, at startup and on theme hot reload, which then fires
      -- ColorScheme and VimEnter again; scheduling puts these groups after it.
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        group = vim.api.nvim_create_augroup("SolarizedDarkCanonical", { clear = true }),
        callback = function()
          vim.schedule(apply)
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
    },
  },
  {
    -- noice's command_palette preset, on in LazyVim, draws the command-line
    -- completion list with the editor's Normal, which glass leaves see-through.
    "folke/noice.nvim",
    opts = {
      views = {
        cmdline_popupmenu = { win_options = { winhighlight = { Normal = "NoicePopupmenu" } } },
      },
    },
  },
  {
    -- Solid Solarized sections, as vim-airline's solarized theme draws the
    -- classic Powerline status line, instead of Omarchy's see-through middle
    -- sections, whose base01 text vanishes over the wallpaper. Only while this
    -- colorscheme is on; lualine calls the function again on every change.
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      local fallback = opts.options.theme
      local b = { fg = c.base2, bg = c.base00 }
      local mid = { fg = c.base1, bg = c.base02 }
      local function mode(color)
        return { a = { fg = c.base03, bg = color, gui = "bold" }, b = b, c = mid }
      end
      local solarized = {
        normal = mode(c.base1),
        insert = mode(c.yellow),
        visual = mode(c.magenta),
        replace = mode(c.red),
        command = mode(c.violet),
        inactive = { a = { fg = c.base02, bg = c.base00 }, b = { fg = c.base02, bg = c.base00 }, c = mid },
      }
      opts.options.theme = function()
        if vim.g.colors_name == "solarized" then
          return solarized
        end
        return type(fallback) == "function" and fallback() or fallback or "auto"
      end
    end,
  },
}
