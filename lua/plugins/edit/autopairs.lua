return {
	{

		"windwp/nvim-autopairs",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {},
	},
	{
		"saghen/blink.pairs",
		event = "User AfterLoad",
		build = function(plugin)
			require("utils.download").blink_pairs(plugin)
		end,
		version = "*",
		opts = {
			mappings = { enabled = false },
			highlights = {
				groups = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			},
		},
	},
}
