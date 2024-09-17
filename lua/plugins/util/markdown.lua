return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle" },
  build = "cd app && yarn install",
  ft = { "markdown" },
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "markdownPreviewToggle" },
  },
  config = function()
    vim.g.mkdp_auto_start = 1
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_theme = "dark"
  end,
}
