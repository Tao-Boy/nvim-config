local load = require("utils.load")
local map = vim.keymap.set

---------------------------------------------------------------------------
-- flash.nvim
---------------------------------------------------------------------------
load.on_file(function()
	require("flash").setup({
		labels = "asdfghjklqwertyuiopzxcvbnm",
		remote = { remote_op = { restore = true, motion = true } },
		label = { uppercase = false },
		modes = {
			char = { enabled = false },
			treesitter = { highlight = { backdrop = true } },
		},
	})
end)
map({ "n", "x", "o" }, ",", function()
	require("flash").jump()
end, { desc = "Flash" })

---------------------------------------------------------------------------
-- oil.nvim (replaces netrw)
---------------------------------------------------------------------------
require("oil").setup({
	watch_for_changes = true,
	view_options = { show_hidden = true },
	cleanup_delay_ms = false,
	float = { max_width = math.floor(vim.o.columns * 0.6) },
	preview = { border = "single" },
	progress = { border = "single" },
	keymaps = {
		["<C-s>"] = false,
		["<C-h>"] = false,
		["<C-l>"] = false,
		["<C-p>"] = "actions.preview",
		["<CR>"] = "actions.select",
		["<BS>"] = "actions.parent",
		["-"] = "actions.close",
	},
})
map("n", "-", function()
	require("oil").open_float()
end, { desc = "Open parent directory" })

---------------------------------------------------------------------------
-- outline.nvim
---------------------------------------------------------------------------
map("n", "<leader>o", function()
	if vim.fn.exists(":Outline") == 0 then
		require("outline").setup({ preview_window = { live = true } })
	end
	vim.cmd.Outline()
end, { desc = "Outline" })

---------------------------------------------------------------------------
-- toggleterm.nvim
---------------------------------------------------------------------------
load.later(function()
	require("toggleterm").setup({
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return math.floor(vim.o.columns * 0.4)
			end
		end,
		open_mapping = [[<C-\>]],
		direction = "float",
		float_opts = { border = "rounded", winblend = 20, title_pos = "center" },
	})
end)

---------------------------------------------------------------------------
-- nvim-autopairs
---------------------------------------------------------------------------
load.on({ "InsertEnter", "CmdlineEnter" }, function()
	require("nvim-autopairs").setup()
end)
