local function lsp()
	local clients = vim.lsp.get_clients()
	local buf = vim.api.nvim_get_current_buf()
	clients = vim.iter(clients)
		:filter(function(client)
			return client.attached_buffers[buf]
		end)
		:filter(function(client)
			return client.name ~= "GitHub Copilot"
		end)
		:map(function(client)
			return client.name
		end)
		:totable()
	local info = table.concat(clients, ", ")
	return info
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "User AfterLoad",
	opts = {
		options = {
			disabled_filetypes = { "snacks_dashboard", "mason" },
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
					padding = { left = 0, right = 0 },
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
				{ "diff", padding = { left = 0, right = 0 } },
			},
			lualine_c = {
				{ lsp, icon = "" },
				"diagnostics",
			},
			lualine_x = {
				"fileformat",
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
	},
}
