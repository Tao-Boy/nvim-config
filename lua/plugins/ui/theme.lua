return {
	"catppuccin/nvim",
	lazy = false,
	config = function()
		require("catppuccin").setup({
			flavour = "frappe",
			transparent_background = true,
			float = {
				transparent = true,
			},
		})
	end,
}
