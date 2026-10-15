local n, v, i, t = { "n" }, { "v" }, { "i" }, { "t" }
local ni, niv = { "n", "i" }, { "n", "i", "v" }

local keymaps = {
	{ "<A-l>", "<Right>", mode = i, desc = "Move cursor right in insert mode" },
	{ "<A-h>", "<Left>", mode = i, desc = "Move cursor left in insert mode" },
	{ "j", "gj", mode = n, desc = "Move down by display line (soft wrap)" },
	{ "k", "gk", mode = n, desc = "Move up by display line (soft wrap)" },
	{ "n", "nzzzv", mode = n, desc = "Center search result" },
	{ "<Esc>", "<Cmd>nohlsearch<CR>", mode = n, desc = "Clear search highlights" },
	{ "K", ":m '<-2<CR>gv=gv", mode = v, desc = "Move selected lines up" },
	{ "J", ":m '>+1<CR>gv=gv", mode = v, desc = "Move selected lines down" },
	{ "<Tab>", "za", mode = n, desc = "Toggle code fold" },
	{ "<C-i>", "<C-i>", mode = n, desc = "Jump to newer position in jump list" },
	{ "<C-a>", "<Cmd>normal! gg0vG$<CR>", mode = ni, desc = "Select entire buffer" },
	{ "<C-s>", "<Cmd>write<CR>", mode = ni, desc = "Save file" },
	{ "<Esc><Esc>", "<C-\\><C-n>", mode = t, desc = "Exit terminal mode" },

	-- Windows
	{ "<C-h>", "<C-w>h", mode = niv, desc = "Move to left window" },
	{ "<C-j>", "<C-w>j", mode = niv, desc = "Move to bottom window" },
	{ "<C-k>", "<C-w>k", mode = niv, desc = "Move to top window" },
	{ "<C-l>", "<C-w>l", mode = niv, desc = "Move to right window" },
	{ "<leader><S-Up>", "<Cmd>resize +5<CR>", mode = n, desc = "Increase window height" },
	{ "<leader><S-Down>", "<Cmd>resize -5<CR>", mode = n, desc = "Decrease window height" },
	{ "<leader><S-Left>", "<Cmd>vertical resize -5<CR>", mode = n, desc = "Decrease window width" },
	{ "<leader><S-Right>", "<Cmd>vertical resize +5<CR>", mode = n, desc = "Increase window width" },
	{ "zo", "<C-w>o", mode = n, desc = "Close all other windows" },
	{ "zs", "<C-w>s", mode = n, desc = "Split window horizontally" },
	{ "zc", "<C-w>c", mode = n, desc = "Close current window" },
	{ "zv", "<C-w>v", mode = n, desc = "Split window vertically" },

	-- Buffers
	{ "<S-h>", "<Cmd>bprevious<CR>", mode = n, desc = "Prev buffer" },
	{ "<S-l>", "<Cmd>bnext<CR>", mode = n, desc = "Next buffer" },
	{ "<leader>bd", "<Cmd>bdelete<CR>", mode = n, desc = "Delete current buffer" },

	-- Built-in tools
	{ "<leader>u", "<Cmd>packadd nvim.undotree | Undotree<CR>", mode = n, desc = "Undo tree" },
}

for _, map in ipairs(keymaps) do
	vim.keymap.set(map.mode, map[1], map[2], { silent = map.silent ~= false, desc = map.desc })
end
