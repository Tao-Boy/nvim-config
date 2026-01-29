return {
	"folke/flash.nvim",
	event = "User AfterLoad",
	keys = {
		{
			",",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
	},
	opts = {
		labels = "asdfghjklqwertyuiopzxcvbnm",
		remote = {
			remote_op = { restore = true, motion = true },
		},
		label = { uppercase = false },
		modes = {
			char = { enabled = false },
			treesitter = { highlight = { backdrop = true } },
		},
	},
}
