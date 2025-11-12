return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
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
		local parsers = require("nvim-treesitter.parsers").get_parser_configs()
		for _, p in pairs(parsers) do
			p.install_info.url = p.install_info.url:gsub("github.com", "gh-proxy.com/github.com")
		end
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = { "latex" },
			},
			auto_install = false,
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
			rainbow = {
				enable = true,
				query = "rainbow-parens",
			},
		})
	end,
}
