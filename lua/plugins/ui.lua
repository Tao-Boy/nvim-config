local load = require("utils.load")
local icons = require("utils.custom").icons

---------------------------------------------------------------------------
-- snacks.nvim: dashboard, picker, notifier, indent guides, ... (needed at startup)
---------------------------------------------------------------------------
local startup_ms ---@type number?
local function startup_section()
	if not startup_ms then
		local now = vim.uv.clock_gettime("realtime")
		startup_ms = (now.sec * 1e9 + now.nsec - vim.v.starttime) / 1e6
	end
	local plugins = vim.iter(vim.pack.get(nil, { info = false }))
		:filter(function(p)
			return p.active and not (type(p.spec.data) == "table" and p.spec.data.grammar)
		end)
		:totable()
	return {
		align = "center",
		text = {
			{ "⚡ Neovim loaded ", hl = "footer" },
			{ tostring(#plugins), hl = "special" },
			{ " plugins in ", hl = "footer" },
			{ ("%.2fms"):format(startup_ms), hl = "special" },
		},
	}
end

require("snacks").setup({
	bigfile = { enabled = true },
	quickfile = { enabled = true },
	notifier = { enabled = true },
	input = { enabled = true },
	toggle = { enabled = true },
	picker = {
		layout = { cycle = true, preset = "default" },
	},
	indent = {
		scope = {
			char = "┃",
			hl = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			},
		},
	},
	dashboard = {
		preset = {
			header = [[
⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷
⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇
⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽
⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕
⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕
⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕
⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄
⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕
⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿
⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟
⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠
⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙
⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣
      ]],
		},
		sections = {
			{ section = "header" },
			{ section = "keys", padding = 1 },
			{ section = "recent_files", title = "Recent Files", limit = 5, padding = 1, indent = 2 },
			startup_section, -- snacks' own "startup" section needs lazy.nvim
		},
	},
})

local function pick(name, opts)
	return function()
		Snacks.picker[name](opts)
	end
end
local map = vim.keymap.set
map("n", "<leader>ff", pick("files"), { desc = "Find Files" })
map("n", "<leader>fg", pick("grep"), { desc = "Grep" })
map("n", "<leader>fb", pick("buffers"), { desc = "Buffers" })
map("n", "<leader>fr", pick("recent"), { desc = "Recent" })
map("n", "<leader>fd", pick("diagnostics"), { desc = "Diagnostics" })
map("n", "<leader>fc", pick("files", { cwd = vim.fn.stdpath("config") }), { desc = "Find Config File" })
map({ "n", "x" }, "<leader>fw", pick("grep_word", { live = true }), { desc = "Visual selection or word" })

load.on_file(function()
	require("persistence").setup()
end)

---------------------------------------------------------------------------
-- noice.nvim: cmdline / messages / LSP docs UI
---------------------------------------------------------------------------
load.later(function()
	require("noice").setup({
		lsp = {
			progress = { enabled = true, view = "mini" }, -- fidget-style LSP progress
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
			-- Native progress messages (nvim_echo kind="progress") are summarised in the
			-- statusline (vim.ui.progress_status) and the terminal's progress bar; noice does
			-- not understand their message ids yet, so keep them out of its views.
			{ filter = { event = "msg_show", kind = "progress" }, opts = { skip = true } },
		},
	})
end)

---------------------------------------------------------------------------
-- which-key.nvim
---------------------------------------------------------------------------
load.on_file(function()
	local wk = require("which-key")
	wk.setup({
		show_help = false,
		preset = "helix",
		icons = { mappings = vim.g.have_nerd_font },
		win = { title_pos = "center" },
	})
	wk.add({
		{ "<leader>b", group = "Buffer Operations" },
		{ "<leader>c", group = "Code Operations" },
		{ "<leader>f", group = "Find Operations" },
		{ "<leader>l", group = "Latex" },
	})
end)
map("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

---------------------------------------------------------------------------
-- lualine.nvim
---------------------------------------------------------------------------
local function lsp_clients()
	local names = vim.tbl_map(function(client)
		return client.name
	end, vim.lsp.get_clients({ bufnr = 0 }))
	return #names > 0 and ("[%s]"):format(table.concat(names, " & ")) or ""
end

load.on_file(function()
	local auto = require("lualine.themes.auto")
	for _, mode in ipairs({ "insert", "normal", "visual", "command", "replace", "inactive", "terminal" }) do
		if auto[mode] and auto[mode].c then
			auto[mode].c.bg = "NONE"
		end
	end

	require("lualine").setup({
		options = {
			theme = auto,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { statusline = { "snacks_dashboard" } },
			globalstatus = true,
			refresh = {
				statusline = 1000,
				events = { "WinEnter", "BufEnter", "BufWritePost", "ModeChanged", "LspAttach", "LspDetach" },
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = {
				{ lsp_clients, icon = "" },
				-- built-in progress summary (fed by LSP progress, see config/lsp.lua)
				{ vim.ui.progress_status },
				"diagnostics",
			},
			lualine_x = { "filename" },
			lualine_y = { "filetype", "progress" },
			lualine_z = {
				function()
					return os.date(" %H:%M")
				end,
			},
		},
		inactive_sections = {
			lualine_c = { "filename" },
			lualine_x = { "location" },
		},
	})

	vim.api.nvim_create_autocmd("Progress", {
		group = vim.api.nvim_create_augroup("user.lualine", { clear = true }),
		callback = function()
			require("lualine").refresh({ place = { "statusline" } })
		end,
	})
end)

---------------------------------------------------------------------------
-- bufferline.nvim (set up after the first file is drawn; reserve its line meanwhile)
---------------------------------------------------------------------------
load.on(
	{ "BufReadPost", "BufNewFile" },
	function()
		vim.o.tabline = " "
		vim.o.showtabline = 2
	end,
	nil,
	function(ev)
		return vim.bo[ev.buf].buftype == ""
	end
)
load.on_file(function()
	require("bufferline").setup({
		options = {
			numbers = "none",
			always_show_bufferline = true,
			auto_toggle_bufferline = true,
			diagnostics = "nvim_lsp",
			diagnostics_update_in_insert = false,
			diagnostics_update_on_event = true,
			indicator = { style = "none" },
			separator_style = { "", "" },
			themeable = true,
		},
		highlights = {
			background = { fg = "#787c99", bg = "none", bold = true, italic = true },
			buffer_selected = { fg = "#ffffff", bg = "none", bold = true, italic = true },
		},
	})
end)
map("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })

---------------------------------------------------------------------------
-- dropbar.nvim (winbar breadcrumbs)
---------------------------------------------------------------------------
load.on_file(function()
	require("dropbar").setup({
		icons = { kinds = { symbols = icons.kind_with_space } },
		bar = {
			hover = false,
			enable = function(buf, win)
				if
					not vim.api.nvim_buf_is_valid(buf)
					or not vim.api.nvim_win_is_valid(win)
					or vim.fn.win_gettype(win) ~= ""
					or vim.wo[win].winbar ~= ""
					or vim.bo[buf].ft == "help"
					or vim.bo[buf].ft == ""
				then
					return false
				end
				return vim.bo[buf].ft == "markdown"
					or vim.treesitter.highlighter.active[buf] ~= nil
					or #vim.lsp.get_clients({ bufnr = buf, method = "textDocument/documentSymbol" }) > 0
			end,
			sources = function(buf)
				local sources = require("dropbar.sources")
				if vim.bo[buf].ft == "markdown" then
					return { sources.markdown }
				end
				if vim.bo[buf].buftype == "terminal" then
					return { sources.terminal }
				end
				return { require("dropbar.utils").source.fallback({ sources.lsp, sources.treesitter }) }
			end,
		},
	})
end, true) -- before the first draw: a winbar appearing later would shift the text
