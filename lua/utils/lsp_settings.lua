local M = {}
local rime_ls = require("utils.rime")
local base_path = vim.fn.stdpath("data") .. "/mason/bin:"
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
	clangd = {},
	tinymist = {
		settings = {
			formatterMode = "typstyle",
			exportPdf = "never",
			semanticTokens = "disable",
		},
	},
	pylsp = {},
	rust_analyzer = {},
}

local config = vim.tbl_extend("force", lsp_config, rime_ls)

M.init = function()
	vim.env.PATH = base_path .. vim.env.PATH
	for k, v in pairs(config) do
		vim.lsp.config[k] = v
		vim.lsp.enable(k)
	end
end

return M
