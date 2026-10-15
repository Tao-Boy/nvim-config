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
-- oil.nvim (replaces netrw): set up at startup only when a directory is being opened
-- (`nvim .`), otherwise on first use (`-` or entering a directory buffer).
---------------------------------------------------------------------------
local oil_ready = false
local function setup_oil()
	if oil_ready then
		return
	end
	oil_ready = true
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
end

local function is_dir(name)
	return name ~= "" and not name:find("^%w+://") and vim.fn.isdirectory(name) == 1
end
local opens_dir = false
for _, arg in ipairs(vim.fn.argv()) do
	opens_dir = opens_dir or is_dir(arg)
end
if opens_dir then
	setup_oil()
else
	-- `:e some/dir` later on: oil's setup hijacks the current directory buffer
	load.on("BufEnter", setup_oil, nil, function(ev)
		return is_dir(ev.file)
	end)
end
map("n", "-", function()
	setup_oil()
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
-- Loaded on first use: <C-\>, :ToggleTerm or :TermExec (setup replaces these stubs).
local term_ready = false
local function setup_term()
	if term_ready then
		return
	end
	term_ready = true
	pcall(vim.api.nvim_del_user_command, "ToggleTerm")
	pcall(vim.api.nvim_del_user_command, "TermExec")
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
end
for _, name in ipairs({ "ToggleTerm", "TermExec" }) do
	vim.api.nvim_create_user_command(name, function(opts)
		setup_term()
		vim.cmd((opts.count > 0 and opts.count or "") .. name .. (opts.bang and "! " or " ") .. opts.args)
	end, { nargs = "*", count = true, bang = true })
end
map({ "n", "i", "t" }, [[<C-\>]], function()
	setup_term()
	vim.cmd((vim.v.count > 0 and vim.v.count or "") .. "ToggleTerm")
end, { desc = "Toggle Terminal" })

---------------------------------------------------------------------------
-- nvim-autopairs
---------------------------------------------------------------------------
load.on({ "InsertEnter", "CmdlineEnter" }, function()
	require("nvim-autopairs").setup()
end)
