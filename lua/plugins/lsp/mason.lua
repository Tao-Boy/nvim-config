return {
	"mason-org/mason.nvim",
	cmd = "Mason",
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
		github = {
			download_url_template = "https://" .. vim.g.gh_proxy .. "github.com/%s/releases/download/%s/%s",
		},
	},
}
