return {
	"lervag/vimtex",
	ft = { "tex" },
	event = "User AfterLoad",
	init = function()
		vim.g.vimtex_view_method = "zathura"
	end,
}
