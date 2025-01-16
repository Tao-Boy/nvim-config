return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufNewFile", "BufRead" },
    cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            auto_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            ensure_installed = {
                "cpp",
                "lua",
                "rust",
                "vim",
                "regex",
                "bash",
                "markdown_inline",
                "markdown",
                "html",
                "typst",
            },
        }
    end,
}
