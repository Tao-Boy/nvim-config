return {
  "folke/snacks.nvim",
  priority = 1000,
  opts = {
    animate = { duration = 20, easing = "linear", fps = 60 },
    scroll = {
      animate = {
        duration = { step = 15, total = 250 },
        easing = "linear",
      },
      spamming = 10,
    },
    dashboard = { enabled = true, example = "files" },
    statuscolumn = {
      left = { "mark", "sign" },
      right = { "fold", "git" },
      folds = {
        open = false,
        git_hl = false,
      },
      git = {
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50
    },
    bigfile = { enabled = true },
    indent = { enabled = true },
    notifier = { enabled = true },
    zen = { enabled = true }
  }
}
