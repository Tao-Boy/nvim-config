return {
	{
		"zbirenbaum/copilot.lua",
    enabled = false,
		event = { "InsertEnter", "User AfterLoad" },
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			copilot_node_command = {
				"node",
				"--max-old-space-size=1024",
			},
			panel = { enabled = false },
			logger = {
				level = "warn",
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				keymap = {
					accept = "<C-y>",
					next = "<C-'>",
					prev = "<C-;>",
					dismiss = "<C-BS>",
				},
			},
		},
		config = function(_, opts)
			require("copilot").setup(opts)
			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuOpen",
				callback = function()
					vim.b.copilot_suggestion_hidden = true
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuClose",
				callback = function()
					vim.b.copilot_suggestion_hidden = false
				end,
			})
		end,
	},
}
