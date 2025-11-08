return {
  {

    "windwp/nvim-autopairs",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {},
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require('rainbow-delimiters.setup').setup {
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end
  },
}
