return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	opts = {
		debug = false,
		-- invert_colors = "auto",
		port = 8080,
		dependencies_bin = {
			["tinymist"] = "tinymist",
			["websocat"] = "websocat",
		},
		get_root = function(bufnr)
			return vim.fs.root(bufnr, { ".git" })
		end,
	},
}
