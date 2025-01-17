return {
	"catppuccin/nvim",
	init = function()
		require("catppuccin").setup({
			flavour = "macchiato",
			term_colors = true,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
