return {
	{
		"Kurama622/llm.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
		event = "User AfterLoad",
		cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
		config = function()
			require("llm").setup({
				app_handler = {
					-- Completion = {
					-- 	handler = tools.completion_handler,
					-- 	opts = {
					-- 		url = "https://api.siliconflow.cn/v1/completions",
					-- 		model = "Qwen/Qwen2.5-Coder-7B-Instruct",
					-- 		api_type = "openai",
					-- 		fetch_key = function()
					-- 			return vim.env.LLM_KEY
					-- 		end,
					-- 		n_completions = 3,
					-- 		context_window = 512,
					-- 		max_tokens = 256,
					--
					-- 		-- A mapping of filetype to true or false, to enable completion.
					-- 		filetypes = { sh = false },
					--
					-- 		-- Whether to enable completion of not for filetypes not specifically listed above.
					-- 		default_filetype_enabled = true,
					--
					-- 		auto_trigger = true,
					--
					-- 		-- just trigger by { "@", ".", "(", "[", ":", " " } for `style = "nvim-cmp"`
					-- 		only_trigger_by_keywords = true,
					--
					-- 		style = "blink.cmp", -- nvim-cmp or blink.cmp
					--
					-- 		timeout = 10, -- max request time
					--
					-- 		-- only send the request every x milliseconds, use 0 to disable throttle.
					-- 		throttle = 1000,
					-- 		-- debounce the request in x milliseconds, set to 0 to disable debounce
					-- 		debounce = 400,
					--
					-- 		--------------------------------
					-- 		---   just for virtual_text
					-- 		--------------------------------
					-- 		keymap = {
					-- 			virtual_text = {
					-- 				accept = {
					-- 					mode = "i",
					-- 					keys = "<A-a>",
					-- 				},
					-- 				next = {
					-- 					mode = "i",
					-- 					keys = "<A-n>",
					-- 				},
					-- 				prev = {
					-- 					mode = "i",
					-- 					keys = "<A-p>",
					-- 				},
					-- 				toggle = {
					-- 					mode = "n",
					-- 					keys = "<leader>cp",
					-- 				},
					-- 			},
					-- 		},
					-- 	},
					-- },
				},
        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"]      = { mode = "n", key = "<cr>" },
          ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-c>" },
          ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>ac" },
          ["Session:Close"]     = { mode = "n", key = {"<esc>", "Q"} },

          -- Scroll
          ["PageUp"]            = { mode = {"i","n"}, key = "<C-b>" },
          ["PageDown"]          = { mode = {"i","n"}, key = "<C-f>" },
          ["HalfPageUp"]        = { mode = {"i","n"}, key = "<C-u>" },
          ["HalfPageDown"]      = { mode = {"i","n"}, key = "<C-d>" },
          ["JumpToTop"]         = { mode = "n", key = "gg" },
          ["JumpToBottom"]      = { mode = "n", key = "G" },
        },
			})
		end,
		keys = {
			{ "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
			{ "<leader>ae", mode = "v", "<cmd>LLMSelectedTextHandler 请解释下面这段代码<cr>" },
			{ "<leader>ts", mode = "x", "<cmd>LLMSelectedTextHandler 英译汉<cr>" },
		},
	},
}
