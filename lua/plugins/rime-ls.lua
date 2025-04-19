local M = {}

function M.setup_rime()
	vim.g.rime_enabled = false

	vim.system({ "rime_ls", "--listen", "127.0.0.1:9257" }, { detach = true })
	local lspconfig = require("lspconfig")
	local configs = require("lspconfig.configs")
	if not configs.rime_ls then
		configs.rime_ls = {
			default_config = {
				name = "rime_ls",
				cmd = vim.lsp.rpc.connect("127.0.0.1", 9257),
				filetypes = { "*" },
				single_file_support = true,
			},
			settings = {},
		}
	end

	local rime_on_attach = function(client, _)
		local toggle_rime = function()
			client.request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
				if ctx.client_id == client.id then
					vim.g.rime_enabled = result
				end
			end)
		end
		-- keymaps for executing command
		vim.keymap.set("n", "<leader>rr", toggle_rime, { desc = "Toggle [R]ime" })
		vim.keymap.set("i", "<C-x>", toggle_rime, { desc = "Toggle Rime" })
	end

	-- local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	lspconfig.rime_ls.setup({
		init_options = {
			enabled = vim.g.rime_enabled,
			shared_data_dir = "~/.config/rimels/",
			user_data_dir = "~/.config/rimels/",
			-- log_dir = "/tmp",
			max_candidates = 9,
			paging_characters = { ",", "." },
			trigger_characters = {},
			schema_trigger_character = "&",
			max_tokens = 0,
			always_incomplete = false,
			preselect_first = false,
			show_filter_text_in_label = false,
			long_filter_text = true,
		},
		on_attach = rime_on_attach,
	})
end

local function contains_unacceptable_character(content)
	if content == nil then
		return true
	end
	local ignored_head_number = false
	for i = 1, #content do
		local b = string.byte(content, i)
		if b >= 48 and b <= 57 or b == 32 or b == 46 then
			-- number dot and space
			if ignored_head_number then
				return true
			end
		elseif b <= 127 then
			return true
		else
			ignored_head_number = true
		end
	end
	return false
end

function M.is_rime_item(item)
	if item == nil or item.source_name ~= "LSP" then
		return false
	end
	local client = vim.lsp.get_client_by_id(item.client_id)
	return client ~= nil and client.name == "rime_ls"
end

function M.rime_item_acceptable(item)
	return not contains_unacceptable_character(item.label) or item.label:match("%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d")
end

function M.get_n_rime_item_index(n, items)
	if items == nil then
		items = require("blink.cmp.completion.list").items
	end
	local result = {}
	if items == nil or #items == 0 then
		return result
	end
	for i, item in ipairs(items) do
		if M.is_rime_item(item) and M.rime_item_acceptable(item) then
			result[#result + 1] = i
			if #result == n then
				break
			end
		end
	end
	return result
end

return M
