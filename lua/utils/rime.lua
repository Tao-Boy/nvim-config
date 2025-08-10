local M = {}

vim.g.rime_enabled = false

local function buf_get_rime_ls_client()
	local bufnr = vim.api.nvim_get_current_buf()
	local buffer_rimels_clients = vim.lsp.get_clients({ bufnr = bufnr, name = "rime_ls" })
	if #buffer_rimels_clients > 0 then
		return buffer_rimels_clients[1]
	end
	return nil
end

function M.toggle_rime()
	local client = buf_get_rime_ls_client()
	if not client or client.name ~= "rime_ls" then
		return
	end
	vim.schedule(function()
		client.request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
			if ctx.client_id == client.id then
				vim.g.rime_enabled = not vim.g.rime_enabled
			end
		end)
	end)
end

return M
