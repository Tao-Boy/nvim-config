return {
	"lervag/vimtex",
	ft = { "tex" },
	init = function()
		vim.g.vimtex_view_method = "general"
		vim.g.vimtex_view_general_viewer = "echo"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_fold_enabled = 1
		vim.g.vimtex_compiler_latexmk = {
			aux_dir = "/dev/shm/",
			out_dir = "./",
			callback = 1,
			continuous = 1,
			options = {
				"-synctex=0",
			},
		}
	end,
}
