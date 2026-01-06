return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	events = "User AfterLoad",
	build = "make install_jsregexp",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<C-h>", "<Plug>luasnip-next-choice", mode = { "i", "s" } },
	},
	config = function()
		require("luasnip").config.setup({ enable_autosnippets = true })
		require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
	end,
}
