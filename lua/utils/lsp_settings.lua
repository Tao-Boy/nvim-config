local M = {}
M.config = {
	rime_ls = {
		name = "rime_ls",
		filetypes = { "tex", "typst" },
		cmd = { "rime_ls" },
		-- cmd = vim.lsp.rpc.connect("127.0.0.1", 9257),
		init_options = {
			enabled = false,
			shared_data_dir = nil,
			user_data_dir = "~/.local/share/rime-ls",
			-- log_dir = "/tmp",
			max_candidates = 9,
			paging_characters = { "=" },
			trigger_characters = {},
			schema_trigger_character = "&",
			max_tokens = 0,
			always_incomplete = false,
			preselect_first = false,
			show_filter_text_in_label = false,
			long_filter_text = true,
			show_order_in_label = true,
		},
	},
	lua_ls = {
		settings = {
			Lua = {
				hint = {
					enable = false,
					setType = true,
				},
				diagnostics = {
					disable = { "missing-fields", "incomplete-signature-doc" },
				},
			},
		},
	},
	texlab = {},
	pyright = {},
}

M.init = function()
	for lsp, config in pairs(M.config) do
		vim.lsp.config[lsp] = config
		vim.lsp.enable(lsp)
	end
end

return M
