return {
	"yetone/avante.nvim",
	enabled = false,
	build = "make",
	event = "User AfterLoad",
	version = false, -- Never set this value to "*"! Never!
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("avante").setup({
			provider = "siliconflow",
			behaviour = {
				enable_cursor_planning_mode = true,
			},
			providers = {
				siliconflow = {
					__inherited_from = "openai",
					api_key_name = "SILICONFLOW",
					endpoint = "https://api.siliconflow.cn/v1",
					model = "deepseek-ai/DeepSeek-V3.2",
					extra_request_body = {
						max_tokens = 4096, -- to avoid using max_completion_tokens
					},
				},
			},
		})
	end,
}
