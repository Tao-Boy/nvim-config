return {
	"zbirenbaum/copilot.lua",
	enabled = false,
	dependencies = {
		"copilotlsp-nvim/copilot-lsp",
	},
	event = { "InsertEnter" },
	cmd = "Copilot",
	config = function()
		require("copilot").setup({
			panel = { enabled = false },
			suggestion = {
				enabled = true,
			},
		})
	end,
}
