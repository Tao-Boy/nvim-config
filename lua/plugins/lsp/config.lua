local custom = require("utils.custom")
local config = function()
	require("utils.lspstart").init()

	vim.diagnostic.config({
		update_in_insert = false,
		jump = { float = true },
		virtual_lines = false,
		virtual_text = {
			spacing = 8,
		},
		float = {
			border = "single",
			severity_sort = true,
			source = "if_many",
		},
		severity_sort = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = custom.icons.diagnostic.Error,
				[vim.diagnostic.severity.WARN] = custom.icons.diagnostic.Warning,
				[vim.diagnostic.severity.HINT] = custom.icons.diagnostic.Hint,
				[vim.diagnostic.severity.INFO] = custom.icons.diagnostic.Information,
			},
		},
	})
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	cmd = "LspInfo",
	config = config,
}
