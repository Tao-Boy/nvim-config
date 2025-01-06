return {
  "akinsho/toggleterm.nvim",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 16
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    shade_terminals = false,
    float_opts = {
      border = "rounded",
    },
  },
  keys = {
    {
      "`",
      function()
        vim.cmd "ToggleTerm"
        if vim.fn.mode() == "n" then
          vim.cmd "startinsert"
        end
      end,
      mode = {"n","t"},
      desc = "Terminal",
    },
  }
}
