return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-emoji",
    },
    opts = function(_, opts)
        local luasnip = require("luasnip")
        local cmp = require("cmp")

        opts.mapping = vim.tbl_extend("force", opts.mapping, {
            ["<Tab>"] = cmp.mapping(function(fallback)
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, { "i", "s", "c" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s", "c" }),
        })
    end
}
