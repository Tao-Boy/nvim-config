local M = {
	"altermo/ultimate-autopair.nvim",
	event = { "InsertEnter", "CmdlineEnter" },
}

M.opts = {
	tabout = {
		enable = true,
		map = "<C-k>",
		hopout = true,
	},
}

return M
