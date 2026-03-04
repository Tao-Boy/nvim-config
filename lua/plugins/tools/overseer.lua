return {
	"stevearc/overseer.nvim",
  enabled = false,
	ft = { "cpp", "python", "rust" },
	opts = {},
	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)
		overseer.register_template(require("utils.templates.cpp_build"))
	end,
}
