return {
	"olimorris/codecompanion.nvim",
	cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ravitemer/codecompanion-history.nvim",
		"j-hui/fidget.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			ft = { "codecompanion" },
		},
	},
	keys = {
		{ "<leader>ah", "<cmd>CodeCompanionHistory<CR>", desc = "CodeCompanion Chat" },
		{ "<leader>ac", "<cmd>CodeCompanionActions<CR>", desc = "CodeCompanion Chat" },
		{ "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", desc = "CodeCompanion Chat" },
		-- { "<leader>h", "<cmd>CodeCompanion /grammar <CR>", mode = "v", desc = "CodeCompanion Chat" },
	},
	config = function()
		local cfg = require("utils.llmcfg")
		require("plugins.users.codecompanion-fidget"):init()
		require("codecompanion").setup({
			opts = {
				language = "Chinese",
				log_level = "ERROR",
			},
			display = {
				chat = {
					intro_message = "Welcome ✨! Press ? for options",
					auto_scroll = false,
				},
				diff = {
					enabled = true,
				},
			},

			extensions = {
				history = {
					enabled = true,
					opts = {
						dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
					},
				},
			},

			interactions = {
				inline = {
					adapter = "anyrouter",
					keymaps = {
						accept_change = { modes = { n = "." } },
						reject_change = { modes = { n = "," } },
						always_accept = { modes = { n = "ga" } },
					},
				},
				chat = {
					opts = {
						system_prompt = "You can always give me extract physics and math instructions in Chinese.",
					},
					adapter = "anyrouter",
				},
			},

			adapters = {
				http = {
					deepseek = cfg.deepseek(),
					modelscope = cfg.modelscope(),
					zhipu = cfg.zhipu(),
					iflow = cfg.iflow(),
					agentrouter = cfg.agentrouter(),
					anyrouter = cfg.anyrouter(),
					meituan = cfg.meituan(),
				},
			},
		})
	end,
}
