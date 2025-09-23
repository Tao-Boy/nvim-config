return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufNewFile", "BufRead" },
	cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
	build = ":TSUpdate",
	config = function()
		local parsers = require("nvim-treesitter.parsers").get_parser_configs()
		for _, p in pairs(parsers) do
			p.install_info.url = p.install_info.url:gsub("github.com", vim.g.gh_proxy .. "github.com")
		end
		require("nvim-treesitter.configs").setup({
			auto_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			ensure_installed = {
				"cpp",
				"lua",
				"rust",
				"vim",
				"regex",
				"bash",
				"markdown_inline",
				"markdown",
				"html",
				"typst",
				"python",
			},
		})
	end,
}
