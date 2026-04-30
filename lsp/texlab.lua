return {
  cmd = { "texlab" },
  filetypes = { "tex", "bib" },
  root_markers = { ".git" },
  settings = {
    texlab = {
      chktex = {
        onOpenAndSave = true,
        onEdit = false,
      },
    },
  },
}
