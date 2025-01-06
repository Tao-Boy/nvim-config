local M = {}

M.lsps = {
  lua_ls = {},
  clangd = {},
  tinymist = {
    single_file_support = true,
    settings = {
      exportPdf = "onSave",
    },
  },
}

return M
