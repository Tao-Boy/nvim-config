return {
	"olimorris/codecompanion.nvim",
	cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
	-- enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ravitemer/codecompanion-history.nvim",
		"j-hui/fidget.nvim",
		-- { "tau/llm-spinner", dev = true },
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
		require("plugins.users.codecompanion-fidget"):init()
		local extend = require("codecompanion.adapters").extend
		require("codecompanion").setup({
			opts = {
				language = "Chinese",
				log_level = "DEBUG",
			},

			extensions = {
				history = {
					enabled = true, -- defaults to true
					opts = {
						dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
					},
				},
				-- spinner = {},
			},

			interactions = {
				inline = {
					adapter = "modelscope",
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
					adapter = "modelscope",
				},
			},

			prompt_library = {
				["grammar"] = {
					interaction = "inline",
					description = "英文语法润色",
					opts = {
						alias = "grammar",
						auto_submit = true,
						ignore_system_prompt = true,
						stop_context_insertion = true,
						is_slash_cmd = true,
						placement = "replace",
						adapter = {
							name = "siliconflow",
							-- model = "deepseek-ai/DeepSeek-V3.2",
						},
					},
					prompts = {
						{
							role = "system",
							content = [[你是一个专业的语法检查器，你的任务是检查并修复文本中的英语语法、拼写和风格问题，不要修改除了语法错误以外的内容，不要返回多余的信息，保留原格式. 如果其中包含LaTeX数学公式或者LaTeX语法，不要修改，并且不要把\( \[ 改成$
             ]],
						},
						{
							role = "user",
							content = function(context)
								local text = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
								return "请润色以下内容：\n\n" .. text .. "\n"
							end,
						},
					},
				},
			},

			adapters = {
				http = {
					copilot = function()
						return extend("copilot", {
							schema = { model = { default = "gpt-5-mini" } },
						})
					end,
					my_gemini = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							env = {
								url = "https://api.laozhang.ai",
								chat_url = "/v1/chat/completions",
							},
							schema = {
								model = {
									default = "gemini-3-pro-preview",
								},
							},
						})
					end,
					siliconflow = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							env = {
								url = "https://api.siliconflow.cn",
								chat_url = "/v1/chat/completions",
							},
							schema = {
								model = {
									default = "Pro/zai-org/GLM-4.7",
								},
							},
						})
					end,
					deepseek = function()
						return extend("openai_compatible", {
							env = {
								url = "https://api.deepseek.com",
								chat_url = "/v1/chat/completions",
								api_key = "cmd:cat " .. os.getenv("HOME") .. "/.config/secrets/deepseek.api",
							},
							schema = {
								model = {
									default = "deepseek-chat",
								},
							},
						})
					end,
					modelscope = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							name = "modelscope",
							env = {
							},
							schema = {
								model = {
									default = "ZhipuAI/GLM-4.7",
								},
							},
							url = "https://api-inference.modelscope.cn/v1/chat/completions",
						})
					end,
				},
			},
		})
	end,
}
