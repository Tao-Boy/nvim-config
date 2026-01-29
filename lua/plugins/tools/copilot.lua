return {
	{
		"zbirenbaum/copilot.lua",
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
	},
}
