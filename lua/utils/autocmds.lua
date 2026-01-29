local opts = {
	treesitter_start = {
		event = "FileType",
		pattern = "*",
		callback = function()
			pcall(vim.treesitter.start)
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	},
	lsp_attach = {
		event = "LspAttach",
		desc = "General LSP Attach",
		callback = function(args)
			local lsp_keymap = function(bufnr)
				local set = function(keys, func, indesc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = indesc })
				end
				set("gr", vim.lsp.buf.references, "[R]eferences")
				set("gi", vim.lsp.buf.implementation, "[I]mplementations")
				set("gk", vim.lsp.buf.signature_help, "LSP Signature help")
				set("gt", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
				set("gD", vim.lsp.buf.declaration, "[D]oc symbols")
				set("gd", vim.lsp.buf.definition, "definition")
				set("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				set("<leader>cn", vim.lsp.buf.rename, "[C]ode Item Re[N]ame")
				set("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")
			end
			lsp_keymap(args.buf)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client then
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(false)
				end
			end
		end,
	},
	no_comment = {
		event = "FileType",
		pattern = "*",
		desc = "set no comment in next line",
		command = "set formatoptions-=ro",
	},
	auto_wrap = {
		event = "FileType",
		desc = "set wrap only for markdown, typst, latex and codecompanion",
		pattern = { "markdown", "markdown.mdx", "typst", "tex", "codecompanion" },
		command = "setlocal wrap",
	},
	highlight_yank = {
		event = "TextYankPost",
		desc = "Highlight when yanking (copying) text",
		callback = function()
			vim.hl.on_yank()
		end,
	},
	q_close_windows = {
		event = "BufWinEnter",
		desc = "Make q close help, man, quickfix, dap floats",
		callback = function(args)
			-- Add cache for buffers that have already had mappings created
			if not vim.g.q_close_windows then
				vim.g.q_close_windows = {}
			end
			-- If the buffer has been checked already, skip
			if vim.g.q_close_windows[args.buf] then
				return
			end
			-- Mark the buffer as checked
			vim.g.q_close_windows[args.buf] = true
			-- Check to see if `q` is already mapped to the buffer (avoids overwriting)
			for _, map in ipairs(vim.api.nvim_buf_get_keymap(args.buf, "n")) do
				if map.lhs == "q" then
					return
				end
			end
			-- If there is no q mapping already and the buftype is a non-real file, create one
			if vim.tbl_contains({ "help", "nofile", "quickfix" }, vim.bo[args.buf].buftype) then
				vim.keymap.set("n", "q", "<Cmd>close<CR>", {
					desc = "Close window",
					buffer = args.buf,
					silent = true,
					nowait = true,
				})
			end
		end,
	},
	diag_in_select = {
		{
			event = "ModeChanged",
			pattern = "*:s",
			desc = "Disable diagnostics in select mode",
			callback = function()
				vim.diagnostic.enable(false)
			end,
		},
		{
			event = "ModeChanged",
			pattern = "[is]:n",
			desc = "Enable diagnostics when leaving select mode",
			callback = function()
				vim.diagnostic.enable()
			end,
		},
	},
	fix_terminal_padding = {
		{
			event = { "UIEnter", "ColorScheme" },
			desc = "Fix terminal padding",
			callback = function()
				local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
				if not normal.bg then
					return
				end
				io.write(string.format("\027]11;#%06x\027\\", normal.bg))
			end,
		},
		{
			event = "UILeave",
			desc = "Reset terminal padding",
			callback = function()
				io.write("\027]111\027\\")
			end,
		},
	},
	lazyload_forfile = {
		event = { "BufReadPost", "BufNewFile", "BufWritePost" },
		desc = "custom lazyload",
		callback = function()
			local function _trigger()
				vim.api.nvim_exec_autocmds("User", { pattern = "AfterLoad" })
			end
			if vim.bo.filetype == "snacks_dashboard" then
				vim.api.nvim_create_autocmd("BufReadPost", { once = true, callback = _trigger })
			else
				_trigger()
			end
		end,
	},
}

-- autocmds
require("utils.functions").loadAutocmd(opts)
