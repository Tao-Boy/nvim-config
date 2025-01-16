return {
	"akinsho/bufferline.nvim",
	event = "User AfterLoad",
	keys = {
		{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Toggle Pin" },
		{ "<c-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<c-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
	},
	opts = {
		highlights = {
			indicator_selected = {
				fg = "#9B30FF",
			},
		},
	},
}
