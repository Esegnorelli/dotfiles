-- Powerline look for the status line. Powerline's own Vim binding does not run
-- on Neovim 0.12 (it calls .decode() on the str pynvim returns), so lualine
-- draws the same Nerd Font arrows. Colours come from the Omarchy theme: the
-- Solarized Dark theme's neovim.lua sets solid airline-style sections.
return {
	"nvim-lualine/lualine.nvim",
	opts = function(_, opts)
		opts.options = opts.options or {}
		opts.options.section_separators = { left = "", right = "" }
		opts.options.component_separators = { left = "", right = "" }
	end,
}
