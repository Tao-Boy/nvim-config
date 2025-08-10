return {
	"willothy/nvim-cokeline",
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
	event = { "BufRead", "BufNewFile" },
	keys = {
		{ "<C-h>", "<Plug>(cokeline-focus-prev)", desc = "Prev Buffer" },
		{ "<C-l>", "<Plug>(cokeline-focus-next)", desc = "Next Buffer" },
	},
	config = function()
		local get_hex = require("cokeline.hlgroups").get_hl_attr
		require("cokeline").setup({
			default_hl = {
				bg = function(buffer)
					if buffer.is_focused then
						return get_hex("GruvBoxBlue", "fg")
					else
						return "none"
					end
				end,
			},
		})
	end,
}
