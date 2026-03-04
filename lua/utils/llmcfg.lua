local M = {}
local extend = require("codecompanion.adapters").extend

function M.deepseek()
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
end

function M.modelscope()
	return extend("openai_compatible", {
		name = "modelscope",
		env = {
			api_key = "cmd:cat " .. os.getenv("HOME") .. "/.config/secrets/modelscope.api",
		},
		schema = {
			model = {
				default = "moonshotai/Kimi-K2.5",
				flash = "ZhipuAI/GLM-4.7",
			},
		},
		url = "https://api-inference.modelscope.cn/v1/chat/completions",
	})
end

function M.zhipu()
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
end

function M.iflow()
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
end

function M.agentrouter()
	return extend("openai_compatible", {
		name = "agentrouter",
		env = {
			api_key = "cmd:cat " .. os.getenv("HOME") .. "/.config/secrets/agentrouter.api",
		},
		schema = {
			model = {
				default = "deepseek-v3.2",
			},
		},
		url = "https://agentrouter.org/v1/chat/completions",
	})
end

function M.meituan()
	return extend("openai_compatible", {
		name = "meituan",
		env = {
			api_key = "cmd:cat " .. os.getenv("HOME") .. "/.config/secrets/meituan.api",
		},
		schema = {
			model = {
				default = "LongCat-Flash-Lite",
			},
		},
		url = "https://api.longcat.chat/openai/v1/chat/completions",
	})
end

function M.anyrouter()
	return extend("anthropic", {
		name = "anyrouter",
		env = {
			api_key = "cmd:cat " .. os.getenv("HOME") .. "/.config/secrets/anyrouter.api",
		},
		schema = {
			model = {
				default = "claude-haiku-4-5-20251001",
			},
		},
		url = "https://a-ocnfniawgw.cn-shanghai.fcapp.run/v1/messages",
	})
end
return M
