return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<esc>", "<c-c>", ft = "fzf", mode = "t", nowait = true },
    { "<leader>fc", "<cmd>FzfLua files cwd=~/.config/nvim<CR>", desc = "find files" },
    -- { "" }
  },
  opts = {
  }
}
