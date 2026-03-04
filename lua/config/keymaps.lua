local mode_n, mode_v, mode_i, mode_o, mode_s, mode_t = { "n" }, { "v" }, { "i" }, { "o" }, { "s" }, { "t" }
local mode_nv, mode_ni, mode_nit, mode_nvo = { "n", "v" }, { "n", "i" }, { "n", "i", "v" }, { "n", "v", "o" }

local function add_textobject(mp)
	for lhs, obj in pairs(mp) do
		vim.keymap.set({ "x", "o" }, lhs, function()
			require("nvim-treesitter-textobjects.select").select_textobject(obj, "textobjects")
		end)
	end
end

local keymap = {
	{ "<A-l>", "<Right>", mode = mode_i, desc = "Move cursor right in insert mode" },
	{ "<A-h>", "<Left>", mode = mode_i, desc = "Move cursor left in insert mode" },
	{ "j", "gj", mode = mode_n, desc = "Move down by display line (soft wrap)" },
	{ "k", "gk", mode = mode_n, desc = "Move up by display line (soft wrap)" },
	{ "n", "nzzzv", mode = mode_n, desc = "Center search result" },
	{ "<Esc>", "<cmd>noh<CR>", mode = mode_n, desc = "Clear search highlights" },
	{ "K", ":m '<-2<cr>gv=gv", mode = mode_v, desc = "Move selected lines up" },
	{ "J", ":m '>+1<cr>gv=gv", mode = mode_v, desc = "Move selected lines down" },
	{ "<Tab>", "za", mode = mode_n, desc = "Toggle code fold" },
	{ "<C-a>", "<cmd>normal gg0vG$<CR>", mode = mode_ni, desc = "Select entire buffer" },
	{ "<C-h>", "<C-w>h", mode = mode_nit, desc = "Move to left window" },
	{ "<C-j>", "<C-w>j", mode = mode_nit, desc = "Move to bottom window" },
	{ "<C-k>", "<C-w>k", mode = mode_nit, desc = "Move to top window" },
	{ "<C-l>", "<C-w>l", mode = mode_nit, desc = "Move to right window" },
	{ "<leader><S-Up>", "<cmd>res +5<CR>", mode = mode_n, desc = "Increase window height" },
	{ "<leader><S-Down>", "<cmd>res -5<CR>", mode = mode_n, desc = "Decrease window height" },
	{ "<leader><S-Left>", "<cmd>vertical resize -5<CR>", mode = mode_n, desc = "Decrease window width" },
	{ "<leader><S-Right>", "<cmd>vertical resize +5<CR>", mode = mode_n, desc = "Increase window width" },
	{ "zo", "<C-w>o", mode = mode_n, desc = "Close all other windows" },
	{ "zs", "<C-w>s", mode = mode_n, desc = "Split window horizontally" },
	{ "zc", "<C-w>c", mode = mode_n, desc = "Close current window" },
	{ "zv", "<C-w>v", mode = mode_n, desc = "Split window vertically" },
	{ "<C-s>", "<cmd>write<CR>", mode = mode_ni, desc = "Save file" },
	{ "<Esc><Esc>", "<C-\\><C-N>", mode = mode_t, desc = "Exit terminal mode" },
	{ "<C-i>", "<C-i>", mode = mode_n, desc = "Jump to older position in jump list" },
}

for _, mapping in ipairs(keymap) do
	local opts = { noremap = true, silent = mapping.silent ~= false }
	if mapping.desc then
		opts.desc = mapping.desc
	end
	vim.keymap.set(mapping.mode, mapping[1], mapping[2], opts)
end

add_textobject({
	["aa"] = "@parameter.outer",
	["ia"] = "@parameter.inner",
	["af"] = "@function.outer",
	["if"] = "@function.inner",
	["ac"] = "@class.outer",
	["ic"] = "@class.inner",
	["ii"] = "@conditional.inner",
	["ai"] = "@conditional.outer",
	["ar"] = "@return.outer",
	["ir"] = "@return.inner",
	["al"] = "@loop.outer",
	["il"] = "@loop.inner",
})
