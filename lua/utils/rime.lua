vim.g.rime_enabled = false

local function map_punc(tbl)
	if vim.g.rime_enabled then
		vim.g.rime_enabled = false
		for k, _ in pairs(tbl) do
			pcall(vim.keymap.del, "i", k)
		end
	else
		vim.g.rime_enabled = true
		for k, v in pairs(tbl) do
			vim.keymap.set("i", k, function()
				return v
			end, { expr = true })
		end
	end
end

local function toggle_rime(client)
	local mapped_punc = {
		[","] = "，",
		["."] = "。",
		[":"] = "：",
		["?"] = "？",
		["\\"] = "、",
		["!"] = "！",
		[";"] = "；",
		["("] = "（",
		[")"] = "）",
		["["] = "【",
		["]"] = "】",
		["<"] = "《",
		[">"] = "》",
		['"'] = "“",
		["'"] = "‘",
	}
	vim.schedule(function()
		client.request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
			if ctx.client_id == client.id then
				vim.g.rime_enabled = result
			end
		end)
	end)
	map_punc(mapped_punc)
end

local function rime_on_attach(client, _)
	vim.keymap.set({ "n", "i" }, "<c-space>", function()
		toggle_rime(client)
	end)
end

return {
	rime_ls = {
		name = "rime_ls",
		cmd = { "rime_ls" },
		filetypes = { "typst", "tex" },
		init_options = {
			enabled = vim.g.rime_enabled,
			shared_data_dir = nil,
			user_data_dir = vim.fn.expand("~/.local/share/rime-ls"),
			log_dir = vim.fn.expand("~/.local/share/rime-ls"),
			always_incomplete = true,
			long_filter_text = true,
		},
		on_attach = rime_on_attach,
	},
}
