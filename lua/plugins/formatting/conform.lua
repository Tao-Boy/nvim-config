return {
    "stevearc/conform.nvim",
    -- opts = function(_, opts)
    --     table.insert(opts.formatters_by_ft, { python = { "isort", "black" }, })
    -- end,
    opts = {
        formatters_by_ft = {
            python = { "black" },
            markdown = {"prettier"}
        },
    }
}
