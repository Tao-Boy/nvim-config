return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "User AfterLoad" },
	keys = {
		{
			"-",
			function()
				if vim.bo.filetype ~= "minifiles" then
					require("oil").open_float()
				end
			end,
			desc = "Open parent directory",
		},
	},
	opts = {
		watch_for_changes = true,
		view_options = {
			show_hidden = true,
		},
		cleanup_delay_ms = false,
		float = {
			max_width = math.floor(vim.go.columns * 0.6),
			border = "rounded",
		},
		preview = {
			border = "single",
		},
		progress = {
			border = "single",
		},
		keymaps = {
			["<C-s>"] = false,
			["<C-h>"] = false,
			["<C-l>"] = false,
			["<C-p>"] = "actions.preview",
			["<CR>"] = "actions.select",
			["<BS>"] = "actions.parent",
			["-"] = "actions.close",
		},
	},
}
