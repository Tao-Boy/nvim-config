return {
	"liubianshi/cmp-lsp-rimels",
	keys = { { "<leader>f", mode = "n" } },
	branch = "blink.cmp",
	config = function()
		require("rimels").setup({
			cmd = "rime_ls",
      rime_user_dir = "~/.local/share/rime-ls/",
		})
	end,
}
