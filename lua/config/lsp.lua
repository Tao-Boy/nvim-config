local custom = require("utils.custom")

local lsp_keymap = function(bufnr)
	local set = function(keys, func, indesc)
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = indesc })
	end
	set("gr", vim.lsp.buf.references, "[R]eferences")
	set("gi", vim.lsp.buf.implementation, "[I]mplementations")
	set("gK", vim.lsp.buf.signature_help, "LSP Signature help")
	set("gt", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
	set("gO", vim.lsp.buf.document_symbol, "Doc symb[O]ls")
	set("gD", vim.lsp.buf.declaration, "[D]eclaration")
	set("gd", vim.lsp.buf.definition, "[D]efinition")
	set("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	set("<leader>cn", vim.lsp.buf.rename, "[C]ode Item Re[N]ame")
	set("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")
end

vim.diagnostic.config({
	virtual_text = false,
	jump = { float = true },
	float = {
		border = custom.border,
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

-- automatically sign up lsp
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "General LSP Attach",
	callback = function(args)
		lsp_keymap(args.buf)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			if client:supports_method("textDocument/inlayHint") then
				vim.lsp.inlay_hint.enable(true)
			end
			if vim.fn.has("nvim-0.12") == 1 and client:supports_method("textDocument/documentColor") then
				vim.lsp.document_color.enable(true, { buffer = args.buf }, { style = "virtual" })
			end
		end
	end,
})

vim.keymap.del("n", "gO")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grt")

vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("clangd")
