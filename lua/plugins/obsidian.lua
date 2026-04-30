return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- use latest release, remove to use latest commit
	opts = {
		legacy_commands = false, -- this will be removed in 4.0.0
		ui = { enable = false },
		workspaces = {
			{
				name = "rust",
				path = "~/obsidian/rust",
			},
		},
	},
}
