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
		get_root = function(path)
			if not path or path == "" then
				return vim.fn.getcwd()
			end
			local root = vim.fs.root(path, { "typst.toml", ".git" })
			if root then
				return root
			end
			return vim.fs.dirname(vim.fn.fnamemodify(path, ":p"))
		end,
	},
}
