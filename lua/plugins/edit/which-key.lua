local opts = {
	show_help = false,
	preset = "helix",
	icons = {
		mappings = vim.g.have_nerd_font,
	},
	win = { border = "rounded", title_pos = "center" },
}

return {
	"folke/which-key.nvim",
	event = "User AfterLoad",
	config = function()
		require("which-key").setup(opts)
		require("which-key").add({
			{ "<leader>b", group = "Buffer Operations" },
			{ "<leader>c", group = "Code Operations" },
			{ "<leader>f", group = "Find Operations" },
			{ "<leader>g", group = "Git Signs" },
			{ "<leader>l", group = "Latex" },
		})
	end,
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
