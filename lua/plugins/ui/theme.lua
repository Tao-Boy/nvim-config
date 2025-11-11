return {
	"ellisonleao/gruvbox.nvim",
	init = function()
		require("gruvbox").setup({
			transparent_mode = true,
		})
		vim.cmd("colorscheme gruvbox")
	end,
}
