local M = {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	cmd = "Neotree",
}

M.dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	"MunifTanjim/nui.nvim",
}

M.keys = {
	{
		"<leader>e",
		function()
			require("neo-tree.command").execute({ toggle = true })
		end,
		desc = "Explorer Neotree",
	},
}

M.opts = {}

return M
