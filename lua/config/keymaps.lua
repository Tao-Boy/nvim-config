local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-i>", "<C-i>", opts)

-- set key to leave insert mod
keymap("i", "<C-j>", "<Esc>", opts)

-- move to the beginning of line and the end of line
keymap({ "n", "o", "x" }, "H", "^", opts)
keymap({ "n", "o", "x" }, "L", "$", opts)

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("n", "n", "nzzzv", opts)


-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- repeat paste
keymap("x", "p", [["_dP]])