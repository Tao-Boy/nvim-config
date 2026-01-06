return {
	"luozhiya/fittencode.nvim",
	enabled = false,
	event = "User AfterLoad",
	opts = {
		keymaps = {
			inline = {
				["<C-y>"] = "accept_all_suggestions",
			},
		},
	},
}
