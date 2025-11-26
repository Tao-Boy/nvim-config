return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	cmd = { "Obsidian" },
	opts = {
		ui = { enable = false },
		legacy_commands = false,
		workspaces = {
			{
				name = "obsidian",
				path = "~/obsidian/",
			},
		},
		note_id_func = function(title)
			if title then
				title = "-" .. title:gsub(" ", "-"):lower()
			else
				title = ""
			end
			return tostring(os.date("%Y%m%d%H%M")) .. title
		end,
	},
}
