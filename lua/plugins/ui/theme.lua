return {
  "folke/tokyonight.nvim",
  init = function()
    require("tokyonight").setup({
      transparent = true,
    })
    vim.cmd("colorscheme tokyonight")
  end,
}
