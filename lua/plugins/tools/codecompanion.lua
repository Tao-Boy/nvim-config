return {
	"olimorris/codecompanion.nvim",
	-- enabled = false,
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
		require("plugins.users.codecompanion-fidget"):init()
		local extend = require("codecompanion.adapters").extend
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
					adapter = "iflow",
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
					adapter = {
						name = "zhipu",
						model = "glm-4.7",
					},
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
					deepseek = function()
						return extend("openai_compatible", {
							env = {
								api_key = "cmd:cat " .. os.getenv("HOME") .. "/.config/secrets/deepseek.api",
							},
							schema = {
								model = {
									default = "deepseek-chat",
								},
							},
							url = "https://api.deepseek.com/v1/chat/completions",
						})
					end,
					modelscope = function()
						return extend("openai_compatible", {
							name = "modelscope",
							env = {
								api_key = "cmd:cat " .. os.getenv("HOME") .. "/.config/secrets/modelscope.api",
							},
							schema = {
								model = {
									default = "ZhipuAI/GLM-4.7",
									flash = "ZhipuAI/GLM-4.7-Flash",
								},
							},
							url = "https://api-inference.modelscope.cn/v1/chat/completions",
						})
					end,
					nvidia = function()
						return extend("openai_compatible", {
							name = "nvidia",
							env = {
								api_key = "cmd:cat " .. os.getenv("HOME") .. "/.config/secrets/nvidia.api",
							},
							schema = {
								model = {
									kimi = "moonshotai/kimi-k2.5",
									glm = "z-ai/glm4.7",
									gpt = "openai/gpt-oss-120b",
								},
							},
							url = "https://integrate.api.nvidia.com/v1/chat/completions",
						})
					end,
					zhipu = function()
						return extend("openai_compatible", {
							name = "zhipu",
							env = {
								api_key = "cmd:cat " .. os.getenv("HOME") .. "/.config/secrets/zhipu.api",
							},
							schema = {
								model = {
									glm = "glm-4.7",
								},
							},
							url = "https://open.bigmodel.cn/api/coding/paas/v4/chat/completions",
						})
					end,
					iflow = function()
						return extend("openai_compatible", {
							name = "iflow",
							env = {
								api_key = "cmd:cat " .. os.getenv("HOME") .. "/.config/secrets/iflow.api",
							},
							schema = {
								model = {
									default = "qwen3-max",
								},
							},
							url = "https://apis.iflow.cn/v1/chat/completions",
						})
					end,
				},
			},
		})
	end,
}
