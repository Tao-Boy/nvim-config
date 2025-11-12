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
elseif jit.os:lower() == "osx" then
	local os = "aarch64-apple-darwin.dylib"
	local lib = ".dylib"
	cmd = "mkdir -p target/release && cd target/release"
		.. " && curl -LO "
		.. base_url
		.. os
		.. " && mv "
		.. os
		.. " libblink_cmp_fuzzy"
		.. lib
end

return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter", "User AfterLoad" },
	build = cmd,
	dependencies = {
		{ "L3MON4D3/LuaSnip" },
		{
			"Kaiser-Yang/blink-cmp-dictionary",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
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
				border = "single",
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
			default = { "lsp", "path", "lazydev", "buffer", "dictionary" },
			providers = {
				dictionary = {
					module = "blink-cmp-dictionary",
					name = "Dict",
					max_items = 10,
					min_keyword_length = 3,
					opts = {
						dictionary_files = { vim.fn.expand("~/.config/nvim/dicts/dict.txt") },
					},
				},
				lazydev = {
					name = "Development",
					module = "lazydev.integrations.blink",
				},
				lsp = {
					fallbacks = { "buffer", "dictionary" },
					transform_items = function(_, items)
						-- The default transformer will do this
						for _, item in ipairs(items) do
							if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
								item.score_offset = item.score_offset - 3
							end
						end
						-- You can define your own filter for rime item
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
