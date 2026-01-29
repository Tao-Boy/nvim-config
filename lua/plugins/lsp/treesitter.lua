return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
			config = function()
				require("nvim-treesitter-textobjects").setup({
					select = {
						lookahead = true,
						include_surrounding_whitespace = false,
					},
				})
			end,
		},
	},
	branch = "main",
	event = "User AfterLoad",
	cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
	build = ":TSUpdate",
	opts = {
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
			"vimdoc",
			"typst",
		},
	},
	config = function(_, opts)
		local function apply_gh_proxy()
			local prefix = vim.g.gh_proxy .. "github.com"
			local parsers = require("nvim-treesitter.parsers")
			for _, p in pairs(parsers) do
				if p.install_info then
					p.install_info.url = p.install_info.url:gsub("github.com", prefix)
				end
			end
		end

		vim.api.nvim_create_autocmd("User", {
			pattern = "TSUpdate",
			callback = apply_gh_proxy,
		})
		require("nvim-treesitter").install(opts.ensure_installed)
	end,
}
