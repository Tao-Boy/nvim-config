return {
	{
		"williamboman/mason.nvim",
		keys = {
			{ "<leader>m", "<cmd>Mason<CR>", desc = "open Mason" },
		},
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonUpdate",
		},
		opts = {
			github = {
				download_url_template = "https://gh.hitaoboy.top/https://github.com/%s/releases/download/%s/%s",
			},
			ui = {
				border = "rounded",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		cmd = {
			"MasonToolsInstall",
			"MasonToolsInstallSync",
			"MasonToolsUpdate",
			"MasonToolsUpdateSync",
			"MasonToolsClean",
		},
		opts = {
			ensure_installed = {
				"lua-language-server",
				"tinymist",
				"clangd",
				"stylua",
				"clang-format",
			},
		},
	},
}
