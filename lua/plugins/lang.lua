local load = require("utils.load")

---------------------------------------------------------------------------
-- vimtex: configured through globals, must be set before the ftplugin runs
---------------------------------------------------------------------------
vim.g.vimtex_view_method = "general"
vim.g.vimtex_view_general_viewer = "echo"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_fold_enabled = 1
vim.g.vimtex_compiler_latexmk = {
	aux_dir = "/dev/shm/",
	out_dir = "./",
	callback = 1,
	continuous = 1,
	options = { "-synctex=0" },
}

---------------------------------------------------------------------------
-- typst-preview.nvim
---------------------------------------------------------------------------
load.on("FileType", function()
	vim.cmd.packadd("typst-preview.nvim")
	require("typst-preview").setup({
		debug = false,
		port = 8080,
		dependencies_bin = {
			["tinymist"] = "tinymist",
			["websocat"] = "websocat",
		},
		get_root = function(path)
			if not path or path == "" then
				return vim.fn.getcwd()
			end
			return vim.fs.root(path, { "typst.toml", ".git" }) or vim.fs.dirname(vim.fn.fnamemodify(path, ":p"))
		end,
	})
end, "typst")
