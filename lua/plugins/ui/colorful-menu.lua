return {
	"xzbdmw/colorful-menu.nvim",
	event = { "User AfterLoad" },
	opts = {
		ls = {
			lua_ls = {
				arguments_hl = "@comment",
			},
			["rust-analyzer"] = {
				extra_info_hl = "@comment",
			},
			clangd = {
				extra_info_hl = "@comment",
			},
			fallback = true,
		},
		fallback_highlight = "@variable",
		max_width = 60,
	},
}
