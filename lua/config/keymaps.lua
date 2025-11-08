local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Space>", "", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "<C-i>", "<C-i>", opts)
keymap("n", "<Esc>", "<cmd>nohl<CR>", opts)
keymap("n", "<C-x>", "<cmd>lua require('snacks.bufdelete').delete()<CR>", opts)
keymap("n", "<Esc>", "<cmd>nohl<CR>", opts)
keymap("n", "<leader>p", "<cmd>Lazy<CR>", opts)
keymap("n", "<leader>bd", "<cmd>bd<CR>", opts)
keymap("n", "<leader>h", "a<C-g>u<Esc>[s1z=`]a<C-g>u<Esc>", opts)

keymap("i", "<C-j>", "<Esc>", opts)
keymap("i", "<A-h>", "<Left>", opts)
keymap("i", "<A-l>", "<Right>", opts)
keymap("i", "<A-j>", "<Down>", opts)
keymap("i", "<A-k>", "<Up>", opts)

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "J", ":m '>+1<cr>gv=gv", opts)
keymap("v", "K", ":m '<-2<cr>gv=gv", opts)

keymap("x", "p", [["_dP]])

keymap({ "n", "i" }, "<C-s>", "<cmd>write<CR>", opts)
keymap({ "n", "i" }, "<C-a>", "<cmd>normal gg0vG$<CR>", opts)

keymap({ "n", "o", "x" }, "H", "^", opts)
keymap({ "n", "o", "x" }, "L", "$", opts)
