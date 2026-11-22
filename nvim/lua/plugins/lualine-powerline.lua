-- Powerline look for the status line. Powerline's own Vim binding does not run
-- on Neovim 0.12 (it calls .decode() on the str pynvim returns), so lualine
-- draws the Powerline glyphs itself:     dividers,  branch,  line,
--  column and  read-only. Colours come from the Omarchy theme: the
-- Solarized Dark theme's neovim.lua sets solid airline-style sections.
return {
	"nvim-lualine/lualine.nvim",
	opts = function(_, opts)
		opts.options = opts.options or {}
		opts.options.section_separators = { left = "", right = "" }
		opts.options.component_separators = { left = "", right = "" }

		local sections = opts.sections
		sections.lualine_b = { { "branch", icon = "" } }

		-- LazyVim puts its file path right after the filetype icon.
		for i, component in ipairs(sections.lualine_c) do
			if component[1] == "filetype" then
				sections.lualine_c[i + 1] = { LazyVim.lualine.pretty_path({ readonly_icon = "  " }) }
				break
			end
		end

		sections.lualine_y = {
			"progress",
			{
				function()
					return " %l/%L  %v"
				end,
			},
		}
	end,
}
