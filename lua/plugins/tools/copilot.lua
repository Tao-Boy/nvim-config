return {
	"zbirenbaum/copilot.lua",
	event = { "InsertEnter" },
	cmd = "Copilot",
	config = function()
		require("copilot").setup({
			panel = { enabled = false },
			suggestion = {
				enabled = true,
        auto_trigger = true,
			},
		})
	end,
}
