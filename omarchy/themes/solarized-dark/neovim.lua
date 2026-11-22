return {
  {
    "maxmx03/solarized.nvim",
    name = "solarized.nvim",
    priority = 1000,
    opts = {},
    config = function(_, opts)
      vim.o.termguicolors = true
      vim.o.background = "dark"
      require("solarized").setup(opts)
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
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
      local c = {
        base03 = "#002b36", base02 = "#073642", base00 = "#657b83", base1 = "#93a1a1",
        base2 = "#eee8d5", yellow = "#b58900", red = "#dc322f", magenta = "#d33682",
        violet = "#6c71c4",
      }
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
