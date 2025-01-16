local M = {
	"folke/flash.nvim",
	event = "User AfterLoad",
}
M.opts = {
	labels = "asdfghjklqwertyuiopzxcvbnm",
	remote = {
		remote_op = { restore = true, motion = true },
	},
	label = { uppercase = false },
	modes = {
		char = { enabled = false },
		treesitter = { highlight = { backdrop = true } },
	},
}

M.keys = {
	{
		",",
		mode = { "n", "x", "o" },
		function()
			require("flash").jump()
		end,
		desc = "Flash",
	},
}

return M
