return {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  root_markers = { ".git" },
  init_options = {
    formatterMode = "typstyle",
    exportPdf = "never",
    semanticTokens = "disable",
    lint = { enabled = true },
    typstExtraArgs = { "--no-pdf-tags" },
  },
}
