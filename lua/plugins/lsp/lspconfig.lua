local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	cmd = "LspInfo",
}

M.dependencies = {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}

function M.config()
	local lspconfig = require("lspconfig")
	local custom = require("custom")
	local lsps = require("lsp_settings").lsps

	require("lspconfig.ui.windows").default_options.border = "rounded"

	local lsp_keymap = function(bufnr)
		local set = function(keys, func, indesc)
			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = indesc })
		end
		set("K", vim.lsp.buf.hover, "hover")
		set("gD", vim.lsp.buf.declaration, "declaration")
		set("gd", vim.lsp.buf.definition, "definition")
		set("gk", vim.lsp.buf.signature_help, "LSP Signature help")
		set("gi", vim.lsp.buf.implementation, "implementation")
		set("<leader>cn", vim.lsp.buf.rename, "[C]ode Item Re[N]ame")
		set("<leader>ct", vim.lsp.buf.type_definition, "[C]ode [T]ype definition")
		set("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")
	end

	vim.api.nvim_create_autocmd("LspAttach", {
		desc = "General LSP Attach",
		callback = function(args)
			lsp_keymap(args.buf)

			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true)
			end
		end,
	})

	for lsp, config in pairs(lsps) do
		lspconfig[lsp].setup(config)
	end

	vim.diagnostic.config({
		virtual_lines = { current_line = true },
		jump = { float = true },
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
