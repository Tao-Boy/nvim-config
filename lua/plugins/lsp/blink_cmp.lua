return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter", "User AfterLoad" },
	build = function(plugin)
		require("utils.download").blink_cmp(plugin)
	end,
	dependencies = {
		{ "L3MON4D3/LuaSnip" },
		"Kaiser-Yang/blink-cmp-avante",
	},
	opts = {
		keymap = {
			preset = "none",
			["<enter>"] = { "accept", "fallback" },
			["<tab>"] = { "snippet_forward", "fallback" },
			["<s-tab>"] = { "snippet_backward", "fallback" },
			["<c-u>"] = { "cancel", "fallback" },
			["<c-n>"] = { "select_next", "fallback" },
			["<c-p>"] = { "select_prev", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		snippets = {
			preset = "luasnip",
		},
		completion = {
			menu = {
				max_height = 8,
				border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
				winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
				scrollbar = false,
				draw = {
					treesitter = { "lsp" },
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				},
			},
			list = {
				selection = { preselect = true, auto_insert = false },
			},
			documentation = {
				auto_show = true,
				window = {
					border = "single",
					scrollbar = false,
				},
			},
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			trigger = {
				prefetch_on_insert = false,
				show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
			},
		},
		signature = {
			enabled = true,
			window = {
				border = "single",
			},
		},
		sources = {
			default = { "avante", "lsp", "path", "buffer", "lazydev" },
			-- default = { "lsp", "path", "lazydev" },
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
				},
				lazydev = {
					name = "Development",
					module = "lazydev.integrations.blink",
				},
				lsp = {
					fallbacks = { "buffer" },
					transform_items = function(_, items)
						for _, item in ipairs(items) do
							if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
								item.score_offset = item.score_offset - 3
							end
						end
						return items
					end,
				},
			},
		},

		fuzzy = {
			implementation = "prefer_rust_with_warning",
			prebuilt_binaries = {
				download = false,
				ignore_version_mismatch = true,
			},
		},
	},
}
