return {
  "Saghen/blink.cmp",
  event = "User AfterLoad",
  version = "*",
  dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'normal'
    },
    snippets = {
      expand = function(snippet)
        require('luasnip').lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require('luasnip').jumpable(filter.direction)
        end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction)
        require('luasnip').jump(direction)
      end
    },
    completion = {
      menu = {
        border = 'rounded',
        draw = {
          treesitter = { "lsp" },
        }
      },
      documentation = {
        auto_show = true,
        window = {
          border = 'rounded',
          scrollbar = false,
        }
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded"
      }
    },
    sources = {
      default = { 'lsp', 'path', 'buffer', 'snippets', 'lazydev' },
      providers = {
        lazydev = {
          name = "Development",
          module = "lazydev.integrations.blink",
        }
      }
    },
    fuzzy = {
      prebuilt_binaries = {
        download = false,
      }
    }
  }
}
