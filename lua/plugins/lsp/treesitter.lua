return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
	cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
	build = ":TSUpdate",
	config = function()
		local parsers = require("nvim-treesitter.parsers")
		for _, p in ipairs(parsers) do
			p.install_info.url = p.install_info.url:gsub("github.com", "gh-proxy.com/github.com")
		end
		require("nvim-treesitter.config").setup({
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			auto_install = true,
			ensure_installed = {
				"cpp",
				"lua",
				"rust",
				"python",
				"vim",
				"regex",
				"bash",
				"markdown_inline",
				"comment",
				"yaml",
				"markdown",
				"html",
				"css",
				"nix",
				"typst",
				"vimdoc",
			},
		})
	end,
}
