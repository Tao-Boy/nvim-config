local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
}

M.dependencies = {
	"williamboman/mason.nvim",
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}

function M.config()
	local lspconfig = require("lspconfig")
	local lsps = require("server_settings").lsps
	local custom = require("custom")

	local lsp_keymap = function(bufnr)
		local set = function(keys, func, indesc)
			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = indesc })
		end
		set("K", vim.lsp.buf.hover, "hover")
		set("gD", vim.lsp.buf.declaration, "declaration")
		set("gd", vim.lsp.buf.definition, "definition")
		set("gk", vim.lsp.buf.signature_help, "LSP Signature help")
		set("gi", vim.lsp.buf.implementation, "implementation")
		set("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
		set("]d", vim.diagnostic.goto_next, "Next Diagnostic")
		set("<leader>cn", vim.lsp.buf.rename, "[C]ode Item Re[N]ame")
		set("<leader>ct", vim.lsp.buf.type_definition, "[C]ode [T]ype definition")
		set("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")
	end

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(args)
			lsp_keymap(args.buf)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
				local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = args.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = args.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
					callback = function(args2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = args2.buf })
					end,
				})
			end
		end,
	})

	for lsp, config in pairs(lsps) do
		lspconfig[lsp].setup(config)
	end

	vim.diagnostic.config({
		virtual_text = { spacing = 4 },
		float = {
			border = "rounded",
			severity_sort = true,
			source = "if_many",
		},
		severity_sort = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = custom.icons.diagnostic.Error,
				[vim.diagnostic.severity.WARN] = custom.icons.diagnostic.Warning,
				[vim.diagnostic.severity.HINT] = custom.icons.diagnostic.Hint,
				[vim.diagnostic.severity.INFO] = custom.icons.diagnostic.Information,
			},
		},
	})
end

return M
