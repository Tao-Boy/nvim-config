return {
	"zbirenbaum/copilot.lua",
	-- enabled = false,
	event = { "InsertEnter", "User AfterLoad" },
	cmd = "Copilot",
	build = ":Copilot auth",
	opts = {
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
		panel = { enabled = false },
	},
}
