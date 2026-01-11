return {
	"lervag/vimtex",
	ft = { "tex" },
	init = function()
		vim.g.vimtex_view_method = "general"
		vim.g.vimtex_view_general_viewer = "echo"
		-- vim.g.vimtex_compiler_method = "tectonic"
		-- vim.g.vimtex_compiler_tectonic = {
		-- 	options = {
		-- 		"--synctex",
		-- 		"--keep-logs",
		-- 		"--keep-intermediates",
		-- 	},
		-- }
		vim.g.vimtex_quickfix_ignore_filters = {
			'does not contain requested Script "CJK"',
		}
	end,
}
