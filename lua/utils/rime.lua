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

-- vim.api.nvim_create_user_command("ToggleRime", function(_)
-- 	local bufnr = vim.api.nvim_get_current_buf()
-- 	local client = vim.lsp.get_clients({ bufnr = bufnr, name = "rime_ls" })
-- 	if #client > 0 then
-- 		toggle_rime(client[1])
-- 	end
-- end, { nargs = "?", desc = "Toggle Rime" })

local function rime_on_attach(client, _)
	vim.keymap.set({ "n", "i" }, "<c-space>", function()
		toggle_rime(client)
	end)
	-- vim.keymap.set("i", "<C-k>", ",,")
	-- vim.keymap.set("i", "<C-l>", ";;")
end

return {
	rime_ls = {
		name = "rime_ls",
		cmd = { "rime_ls" },
		filetypes = { "tex", "typ" },
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
