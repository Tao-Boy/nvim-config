local cmd = ""
if jit.os:lower() == "windows" then
	cmd = " make install_jsregexp CC=gcc.exe SHELL=git-bash.exe .SHELLFLAGS=-c"
else
	cmd = "make install_jsregexp"
end
return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = cmd,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	events = "User AfterLoad",
	keys = {
		{ "<C-h>", "<Plug>luasnip-next-choice", mode = { "i", "s" } },
	},
	config = function()
		require("luasnip").config.setup({ enable_autosnippets = true })
		require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
	end,
}
