return {
	"kawre/neotab.nvim",
	event = "InsertEnter",
	opts = {
		tabkey = "<C-l>",
		act_as_tab = true,
		behavior = "nested",
		pairs = {
			{ open = "(", close = ")" },
			{ open = "[", close = "]" },
			{ open = "{", close = "}" },
			{ open = '"', close = '"' },
			{ open = "`", close = "`" },
			{ open = "<", close = ">" },
			{ open = "*", close = "*" },
		},
		exclude = {},
		smart_punctuators = {
			enabled = true,
			semicolon = {
				enabled = false,
				ft = { "cs", "c", "cpp", "java" },
			},
			escape = {
				enabled = false,
				triggers = {},
			},
		},
	},
}
