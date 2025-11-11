return {
	{

		"windwp/nvim-autopairs",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("rainbow-delimiters.setup").setup({
				strategy = {
					[""] = "rainbow-delimiters.strategy.global",
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			})
		end,
	},
}
