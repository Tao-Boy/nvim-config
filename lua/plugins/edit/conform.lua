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
		formatters_by_ft = {
			nix = { "nixfmt" },
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
			json = { "prettier" },
			jsonc = { "prettier" },
			tex = { "tex-fmt" },
		},
	},
}
