local function rime_status()
	if vim.g.rime_enabled then
		return "ㄓ"
	else
		return ""
	end
end
local opts = {
	options = {
		icons_enabled = true,
		disabled_filetypes = { "snacks_dashboard" },
		always_divide_middle = true,
		globalstatus = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{
				function()
					if vim.bo.modified then
						return ""
					else
						return "󰄳"
					end
				end,
				separator = { left = "", right = "" },
				padding = { left = 0, right = 1 },
			},
			{
				"mode",
				separator = { left = "", right = "" },
				padding = { left = 0, right = 0 },
			},
		},
		lualine_b = {
			{
				"branch",
				icon = "",
			},
			{ "diff", padding = { left = 1, right = 1 } },
		},
		lualine_c = {
			{
				"lsp_status",
				icon = "",
				symbols = {
					done = "",
					separator = " & ",
				},
				ignore_lsp = { "rime_ls" },
			},
			"diagnostics",
		},
		lualine_x = {
			{ rime_status },
		},
		lualine_y = {
			{
				"filetype",
				colored = true,
				icon_only = true,
				icon = { align = "left" },
				padding = { left = 0, right = 0 },
			},
			{
				"filename",
				separator = { left = "", right = "" },
				padding = { left = 0, right = 1 },
			},
		},
		lualine_z = {
			{
				"progress",
				separator = { right = "" },
				icon = { "󰇽", align = "left" },
				padding = { left = 1, right = 1 },
			},
		},
	},
}

return {
	"nvim-lualine/lualine.nvim",
	event = "User AfterLoad",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local auto = require("lualine.themes.auto")
		local lualine_modes = { "insert", "normal", "visual", "command", "replace", "inactive", "terminal" }
		for _, field in ipairs(lualine_modes) do
			if auto[field] and auto[field].c then
				auto[field].c.bg = "NONE"
			end
		end
		opts.options.theme = auto
		require("lualine").setup(opts)
	end,
}
