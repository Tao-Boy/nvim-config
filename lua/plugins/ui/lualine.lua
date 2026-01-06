local function get_lsp()
	local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
	if #buf_clients == 0 then
		return nil
	end

	local buf_client_names = {}

	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" and client.name ~= "copilot" then
			table.insert(buf_client_names, client.name)
		end
	end

	local unique_client_names = table.concat(buf_client_names, " & ")

	local language_servers = string.format("[%s]", unique_client_names)

	return language_servers
end

local function get_copilot_status()
	local clients = vim.lsp.get_clients({ bufnr = 0 })

	for _, client in ipairs(clients) do
		if client.name == "copilot" then
			return ""
		end
	end

	return ""
end

local opts = {
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {
				"snacks_dashboard",
				"Avante",
				"AvanteInput",
				"AvanteSelectedFiles",
			},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = {
			{
				get_lsp,
				icon = "",
			},
			"diagnostics",
		},
		lualine_x = { get_copilot_status, "filename" },
		lualine_y = { "filetype", "progress" },
		lualine_z = { {
			function()
				return "" .. os.date(" %H:%M")
			end,
		} },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
}

return {
	"nvim-lualine/lualine.nvim",
	event = "User AfterLoad",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
	config = function()
		local auto = require("lualine.themes.auto")
		local lualine_modes = { "insert", "normal", "visual", "command", "replace", "inactive", "terminal", "WinBar" }
		for _, field in ipairs(lualine_modes) do
			if auto[field] and auto[field].c then
				auto[field].c.bg = "NONE"
			end
		end
		opts.options.theme = auto
		require("lualine").setup(opts)
	end,
}
