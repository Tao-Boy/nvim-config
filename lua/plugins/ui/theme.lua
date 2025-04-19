return {
	"catppuccin/nvim",
	init = function()
		require("catppuccin").setup({
			flavour = "macchiato",
			term_colors = true,
			transparent_background = true,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
