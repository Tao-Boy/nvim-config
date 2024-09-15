local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end
map({ "i" }, "<C-j>", "<Esc>")
map({ "n", "v", "o" }, "H", "^", { desc = "Use 'H' as '^'" })
map({ "n", "v", "o" }, "L", "$", { desc = "Use 'L' as '$'" })

map("n", "<", "v<g")
map("n", ">", "v>g")

map({ "n", "i" }, "<A-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map({ "n", "i" }, "<A-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

map("n", "<leader>h", "a<C-g>u<Esc>[s1z=`]a<C-g>u<Esc>", { desc = "Check spell" })

local del = vim.keymap.del
del("n", "[b")
del("n", "]b")
del("n", "<leader>bb")
del("n", "<leader>`")
del("n", "<leader>ur")
del("n", "<leader>K")
del("n", "gco")
del("n", "gcO")
del("n", "<leader>xl")
del("n", "<leader>xq")
del("n", "[q")
del("n", "]q")
del("n", "<leader>uf")
del("n", "<leader>uF")
del("n", "<leader>us")
del("n", "<leader>uw")
del("n", "<leader>uL")
del("n", "<leader>ud")
del("n", "<leader>ul")
del("n", "<leader>uT")
del("n", "<leader>ub")
del("n", "<leader>uh")
del("n", "<leader>ui")
del("n", "<leader>uI")
del("n", "<c-/>")
del({ "n", "t" }, "<c-_>")
del("t", "<Esc><Esc>")
del("t", "<C-/>")
del("n", "<leader><tab>l")
del("n", "<leader><tab>o")
del("n", "<leader><tab>f")
del("n", "<leader><tab><tab>")
del("n", "<leader><tab>]")
del("n", "<leader><tab>d")
del("n", "<leader><tab>[")
