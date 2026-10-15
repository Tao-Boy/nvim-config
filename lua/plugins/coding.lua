local load = require("utils.load")

---------------------------------------------------------------------------
-- LuaSnip + blink.cmp (loaded on first insert / cmdline use)
---------------------------------------------------------------------------
load.on({ "InsertEnter", "CmdlineEnter" }, function()
	local luasnip = require("luasnip")
	luasnip.config.setup({ enable_autosnippets = true })
	require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
	vim.keymap.set({ "i", "s" }, "<C-h>", "<Plug>luasnip-next-choice")

	require("blink.cmp").setup({
		keymap = {
			preset = "none",
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			["<C-u>"] = { "cancel", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
		},
		appearance = { nerd_font_variant = "mono" },
		snippets = { preset = "luasnip" },
		completion = {
			menu = {
				border = "rounded",
				max_height = 8,
				winhighlight = "Normal:None,CursorLine:BlinkCmpMenuSelection,Search:None",
				scrollbar = false,
				draw = {
					treesitter = { "lsp" }, -- highlight labels with the buffer's (native) treesitter parser
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } },
				},
			},
			list = { selection = { preselect = true, auto_insert = false } },
			documentation = { auto_show = true, window = { border = "rounded", scrollbar = false } },
			accept = { auto_brackets = { enabled = false } },
			trigger = {
				prefetch_on_insert = false,
				show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
			},
		},
		signature = { enabled = true, window = { border = "rounded" } },
		sources = {
			default = { "lsp", "path", "buffer" },
			providers = {
				lsp = {
					fallbacks = { "buffer" },
					transform_items = function(_, items)
						local snippet = require("blink.cmp.types").CompletionItemKind.Snippet
						for _, item in ipairs(items) do
							if item.kind == snippet then
								item.score_offset = item.score_offset - 3
							end
						end
						return items
					end,
				},
			},
		},
		-- blink.cmp downloads its prebuilt fuzzy matcher for the checked out tag on its own
		fuzzy = { implementation = "prefer_rust_with_warning" },
	})
end)

---------------------------------------------------------------------------
-- conform.nvim
---------------------------------------------------------------------------
load.on_file(function()
	require("conform").setup({
		format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
		formatters_by_ft = {
			yaml = { "yamlfmt" },
			nix = { "alejandra" },
			lua = { "stylua" },
			rust = { "rustfmt" },
			python = { "ruff_format" },
			cpp = { "clang_format" },
			css = { "dprint" },
			markdown = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			html = { "prettier" },
			json = { "jq" },
			jsonc = { "prettier" },
			tex = { "tex-fmt" },
			cls = { "tex-fmt" },
		},
		formatters = {
			["tex-fmt"] = { prepend_args = { "--nowrap" } },
		},
	})
end)
vim.keymap.set({ "n", "v" }, "<leader>F", function()
	require("conform").format()
end, { desc = "Format Document" })
