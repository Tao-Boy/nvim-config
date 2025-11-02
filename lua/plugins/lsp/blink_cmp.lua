local cmd = ""
local base_url = "https://" .. vim.g.gh_proxy .. "github.com/Saghen/blink.cmp/releases/latest/download/"
if jit.os:lower() == "linux" then
	local os = "x86_64-unknown-linux-gnu.so"
	local lib = ".so"
	cmd = "mkdir -p target/release && cd target/release"
		.. " && curl -LO "
		.. base_url
		.. os
		.. " && mv "
		.. os
		.. " libblink_cmp_fuzzy"
		.. lib
elseif jit.os:lower() == "windows" then
	local os = "x86_64-pc-windows-msvc.dll"
	local lib = ".dll"
	cmd = "mkdir target\\release & cd target\\release"
		.. " & curl -LO "
		.. base_url
		.. os
		.. " & ren "
		.. os
		.. " libblink_cmp_fuzzy"
		.. lib
end

return {
	"saghen/blink.cmp",
	event = "User AfterLoad",
	build = cmd,
	dependencies = {
		"L3MON4D3/LuaSnip",
		{ "Kaiser-Yang/blink-cmp-dictionary", dependencies = { "nvim-lua/plenary.nvim" } },
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
				border = "rounded",
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
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
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								if ctx.item.kind_name == "llm" then
									return " "
								else
									return ctx.kind_icon
								end
							end,

							highlight = function(ctx)
								if ctx.item.kind_name == "llm" then
									return "BlinkCmpKindSnippet"
								else
									return ctx.kind_hl
								end
							end,
						},
					},
				},
			},
			list = {
				selection = { preselect = true, auto_insert = false },
			},
			documentation = {
				auto_show = false,
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
				show_on_blocked_trigger_characters = {},
			},
		},
		signature = {
			enabled = true,
			window = {
				border = "single",
			},
		},
		sources = {
			default = { "lsp", "path", "lazydev", "buffer", "llm" },
			per_filetype = {
				llm = { inherit_defaults = false }, -- enbale: "llm_cmds"
			},
			providers = {
				llm = {
					name = "LLM",
					module = "llm.common.completion.frontends.blink",
					timeout_ms = 10000,
					score_offset = 100,
					async = true,
				},
				lazydev = {
					name = "Development",
					module = "lazydev.integrations.blink",
				},
				lsp = {
					transform_items = function(_, items)
						-- the default transformer will do this
						for _, item in ipairs(items) do
							if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
								item.score_offset = item.score_offset - 3
							end
						end
						-- you can define your own filter for rime item
						return items
					end,
				},
			},
		},

		fuzzy = {
			implementation = "prefer_rust_with_warning",
			prebuilt_binaries = {
				download = false,
				ignore_version_mismatch = false,
			},
		},
	},
}
