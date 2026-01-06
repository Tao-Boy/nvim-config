local M = {}
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
	pyright = {},
	julials = {},
	clangd = {},
	tinymist = {
		init_options = {
			formatterMode = "typstyle",
			exportPdf = "never",
			semanticTokens = "disable",
		},
	},
	rust_analyzer = {},
}

M.init = function()
	vim.env.PATH = base_path .. vim.env.PATH
	for k, v in pairs(lsp_config) do
		vim.lsp.config[k] = v
		vim.lsp.enable(k)
	end
end

return M
