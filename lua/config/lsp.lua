-- Loaded right after the first real file has been drawn (see init.lua): `vim.lsp` and
-- `vim.diagnostic` are not needed for the dashboard / an empty buffer, and servers take
-- far longer to start than the one frame of delay.
local icons = require("utils.custom").icons

vim.lsp.log.set_level(vim.log.levels.OFF)

-- Server configs live in `lsp/<name>.lua` and are picked up by vim.lsp.config automatically.
vim.lsp.enable({ "lua_ls", "ty", "rust_analyzer", "clangd", "tinymist" })

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	jump = { float = true },
	float = { severity_sort = true, source = "if_many" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.diagnostic.Error,
			[vim.diagnostic.severity.WARN] = icons.diagnostic.Warning,
			[vim.diagnostic.severity.HINT] = icons.diagnostic.Hint,
			[vim.diagnostic.severity.INFO] = icons.diagnostic.Information,
		},
	},
})

-- Replace the default gr* / gO mappings with buffer-local ones below
for _, lhs in ipairs({ "gO", "gra", "gri", "grn", "grr", "grt", "grx" }) do
	pcall(vim.keymap.del, lhs == "gra" and { "n", "x" } or "n", lhs)
end

local function set_keymaps(buf)
	local map = function(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
	end
	map("gr", vim.lsp.buf.references, "[R]eferences")
	map("gi", vim.lsp.buf.implementation, "[I]mplementations")
	map("gK", vim.lsp.buf.signature_help, "LSP Signature help")
	map("gt", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
	map("gO", vim.lsp.buf.document_symbol, "Doc symb[O]ls")
	map("gD", vim.lsp.buf.declaration, "[D]eclaration")
	map("gd", vim.lsp.buf.definition, "[D]efinition")
	map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	map("<leader>cn", vim.lsp.buf.rename, "[C]ode Item Re[N]ame")
	map("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")
end

local group = vim.api.nvim_create_augroup("user.lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	desc = "LSP keymaps and per-buffer features",
	callback = function(args)
		local buf = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end
		set_keymaps(buf)

		if client:supports_method("textDocument/inlayHint", buf) then
			vim.lsp.inlay_hint.enable(true, { bufnr = buf })
		end
		if client:supports_method("textDocument/documentColor", buf) then
			vim.lsp.document_color.enable(true, { bufnr = buf }, { style = "virtual" })
		end
		-- Fall back to LSP folding when treesitter cannot provide folds for this buffer
		if client:supports_method("textDocument/foldingRange", buf) then
			for _, win in ipairs(vim.fn.win_findbuf(buf)) do
				if vim.wo[win][0].foldexpr == "0" then
					vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
				end
			end
		end
	end,
})

-- Native replacement for fidget.nvim: turn LSP $/progress into progress messages
-- (shown by the message UI, the TUI progress bar (OSC 9;4) and `vim.ui.progress_status()`).
vim.api.nvim_create_autocmd("LspProgress", {
	group = group,
	desc = "Forward LSP progress to nvim_echo progress messages",
	callback = function(ev)
		local value = ev.data.params.value
		if type(value) ~= "table" or not value.kind then
			return
		end
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		vim.api.nvim_echo({ { value.message or (value.kind == "end" and "done" or "") } }, false, {
			id = ("lsp.%d.%s"):format(ev.data.client_id, tostring(ev.data.params.token)),
			kind = "progress",
			source = client and client.name or "vim.lsp",
			title = value.title,
			status = value.kind == "end" and "success" or "running",
			percent = value.percentage,
		})
	end,
})
