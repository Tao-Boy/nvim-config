return {
  "catppuccin/nvim",
  priority = 100;
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato",
      term_colors = true,
    })
    vim.cmd.colorscheme("catppuccin")
  end
}
