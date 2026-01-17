return {
	"akinsho/toggleterm.nvim",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{ "<c-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
	},
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		open_mapping = [[<c-\>]],
		direction = "float",
		float_opts = {
			winblend = 20,
			title_pos = "center",
		},
	},
}
