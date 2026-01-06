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
		default_format_opts = {
			stop_after_first = true,
			lsp_format = "fallback",
		},
		format_on_save = { timeout_ms = 500 },
		formatters_by_ft = {
			nix = { "alejandra" },
			lua = { "stylua" },
			rust = { "rustfmt" },
			python = { "black" },
			cpp = { "clang_format" },
			css = { "dprint" },
			markdown = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			html = { "prettier" },
			yaml = { "prettier" },
			json = { "jq" },
			jsonc = { "prettier" },
			tex = { "tex-fmt" },
		},
		formatters = {
			["tex-fmt"] = {
				prepend_args = { "--nowrap" },
			},
		},
	},
}
