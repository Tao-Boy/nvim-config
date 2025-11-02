return {
	{

		"windwp/nvim-autopairs",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {},
	},
	{
		"saghen/blink.pairs",
		event = "User AfterLoad",
		build = "nix run .#build-plugin",
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
