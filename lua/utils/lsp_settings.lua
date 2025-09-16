local M = {}
local rime_ls = require("utils.rime")

local lsp_config = {
	lua_ls = {
		settings = {
			Lua = {
				hint = {
					enable = false,
					setType = true,
				},
				diagnostics = {
					disable = { "missing-fields", "incomplete-signature-doc" },
				},
			},
		},
	},
	texlab = {},
	tinymist = {
		settings = {
			formatterMode = "typstyle",
			exportPdf = "onSave",
			semanticTokens = "disable",
		},
	},
	pyright = {},
}

local config = vim.tbl_extend("force", lsp_config, rime_ls)

M.init = function()
	for k, v in pairs(config) do
		vim.lsp.config[k] = v
		vim.lsp.enable(k)
	end
end

return M
