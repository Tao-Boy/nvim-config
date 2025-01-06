local M = {
  "folke/which-key.nvim",
  event = "User AfterLoad",
}

M.keys = {
  {
    "<leader>?",
    function()
      require("which-key").show({ global = false })
    end,
    desc = "Buffer Local Keymaps (which-key)",
  },
}

M.opts = {
  preset = "helix",
  icons = {
    mappings = vim.g.have_nerd_font,
  },
  win = { border = "rounded", title_pos = "center" }
}

return M
