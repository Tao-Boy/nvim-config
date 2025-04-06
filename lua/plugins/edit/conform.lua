local base_path = vim.fn.stdpath("data") .. "/mason/bin/"
return {
	"stevearc/conform.nvim",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>F",
			function()
				require("conform").format({ lsp_format = "fallback" })
			end,
			desc = "Format Document",
			mode = { "n", "v" },
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				cpp = { "clang_format" },
				nix = { "alejandra" },
			},
			formatters = {
				stylua = {
					command = "stylua",
				},
				clang_format = {
					command = "clang-format",
				},
				alejandra = {
					command = base_path .. "alejandra",
				},
			},
		})
	end,
}
