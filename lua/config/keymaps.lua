local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "<Space>", "", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "<C-i>", "<C-i>", opts)
keymap("n", "<Esc>", "<cmd>nohl<CR>", opts)
keymap("n", "<C-x>", "<cmd>lua require('snacks.bufdelete').delete()<CR>", opts)
keymap("n", "<Esc>", "<cmd>nohl<CR>", opts)
keymap("n", "<leader>p", "<cmd>Lazy<CR>", opts)
keymap("n", "<leader>bd", "<cmd>bd<CR>", opts)
-- keymap("n", "<leader>h", "a<C-g>u<Esc>[s1z=`]a<C-g>u<Esc>", opts)

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

vim.keymap.set("n", "<leader>sf", function() -- 助记: [S]pell [F]ix
	local save_view = vim.fn.winsaveview()
	local count = 0

	-- 2. 跳转到文件最开始，准备遍历
	vim.cmd("normal! gg0")

	while true do
		local before_pos = vim.fn.getcurpos()

		vim.cmd("normal! ]s")

		local after_pos = vim.fn.getcurpos()

		if after_pos[2] < before_pos[2] or (after_pos[2] == before_pos[2] and after_pos[3] <= before_pos[3]) then
			break
		end

		local status, _ = pcall(function()
			vim.cmd("normal! 1z=")
		end)

		if status then
			count = count + 1
		end
	end

	vim.fn.winrestview(save_view)

	vim.notify("已自动修复 " .. count .. " 个拼写错误。")
end, { desc = "Auto fix all spelling errors in buffer" })
