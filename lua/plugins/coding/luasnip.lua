return {
  "L3MON4D3/LuaSnip",
  -- build = "make install_jsregexp",
  event = "VeryLazy",
  config = function()
    require("luasnip").config.setup({ enable_autosnippets = true })
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
  end,
  keys = function()
    return {
      {
        "<C-h>",
        "<Plug>luasnip-next-choice",
        mode = { "i", "s" },
      },
      {
        "<C-p>",
        "<Plug>luasnip-prev-choice",
        mode = { "i", "s" },
      },
    }
  end,
}
