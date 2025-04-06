return {
	"lewis6991/gitsigns.nvim",
	event = "User AfterLoad",
	dependencies = "nvim-lua/plenary.nvim",
	keys = {
		{ "<leader>gb", "<Cmd>Gitsigns blame_line<CR>", desc = "gitsigns blame" },
		{ "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>", desc = "gitsigns hunk preview" },
	},
	opts = {
		current_line_blame = true,
		signcolumn = true,
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "-" },
		},
	},
}
