local M = {}

M.servers = {
  lua_ls = {
    root_dir = require("lspconfig.util").root_pattern(".git", vim.fn.getcwd()),
  },
  clangd = {},
  tinymist = {
    single_file_support = true,
    settings = {
      exportPdf = "never",
      fontPaths = "$./fonts/"
    },
    formatterMode = "typstyle"
  },
}

return M
