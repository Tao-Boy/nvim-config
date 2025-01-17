return {
	"altermo/ultimate-autopair.nvim",
	event = { "InsertEnter", "CmdlineEnter" },
	opts = {
		tabout = {
			enable = true,
			map = "<C-k>",
			hopout = true,
		},
	},
}
