local custom = require("custom")
local config = function()
	require("utils.lsp_settings").init()

	local lsp_keymap = function(bufnr)
		local set = function(keys, func, indesc)
			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = indesc })
		end
		set("gr", vim.lsp.buf.references, "[R]eferences")
		set("gi", vim.lsp.buf.implementation, "[I]mplementations")
		set("gk", vim.lsp.buf.signature_help, "LSP Signature help")
		set("gD", vim.lsp.buf.declaration, "[D]oc symbols")
		set("gd", vim.lsp.buf.definition, "definition")
		set("<leader>cn", vim.lsp.buf.rename, "[C]ode Item Re[N]ame")
		set("<leader>ct", vim.lsp.buf.type_definition, "[C]ode [T]ype definition")
		set("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")
	end

	vim.diagnostic.config({
		virtual_lines = { current_line = true },
		jump = { float = true },
		float = {
			border = "single",
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

	vim.api.nvim_create_autocmd("LspAttach", {
		desc = "General LSP Attach",
		callback = function(args)
			lsp_keymap(args.buf)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client then
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(false)
				end
				if client:supports_method("textDocument/foldingRange") then
					local win = vim.api.nvim_get_current_win()
					vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
				end
			end
		end,
	})

	vim.keymap.del("n", "gri")
	vim.keymap.del("n", "gra")
	vim.keymap.del("n", "grn")
	vim.keymap.del("n", "grr")
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		-- {
		-- 	"mason-org/mason-lspconfig.nvim",
		-- 	opts = {
		-- 		automatic_enable = false,
		-- 	},
		-- },
	},
	event = "User AfterLoad",
	config = config,
}
