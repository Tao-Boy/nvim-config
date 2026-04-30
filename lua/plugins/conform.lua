return {
	"stevearc/conform.nvim",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>F",
			function()
				require("conform").format()
			end,
			desc = "Format Document",
			mode = { "n", "v" },
		},
	},
	opts = {
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			yaml = { "yamlfmt" },
			nix = { "alejandra" },
			lua = { "stylua" },
			rust = { "rustfmt" },
			python = { "ruff", "format" },
			cpp = { "clang_format" },
			css = { "dprint" },
			markdown = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			html = { "prettier" },
			json = { "jq" },
			jsonc = { "prettier" },
			tex = { "tex-fmt" },
			cls = { "tex-fmt" },
		},
		formatters = {
			["tex-fmt"] = {
				prepend_args = { "--nowrap" },
			},
		},
	},
}
