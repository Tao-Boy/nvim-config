return {
	"kdheepak/lazygit.nvim",
  enabled = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	keys = {
		{ "<leader>go", "<Cmd>LazyGit<CR>", desc = "LazyGit" },
	},
}
