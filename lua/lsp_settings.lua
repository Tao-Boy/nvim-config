local M = {}

M.lsps = {
	lua_ls = {},
	clangd = {},
	tinymist = {
		single_file_support = true,
		settings = {
			exportPdf = "never",
			formatterMode = "typstyle",
		},
	},
}

return M
