-- local cmd = ""
-- local base_url = "https://gh-proxy.hitaoboy.top/https://github.com/Saghen/blink.cmp/releases/latest/download/"
-- if jit.os:lower() == "linux" then
-- 	local os = "x86_64-unknown-linux-gnu.so"
-- 	local lib = ".so"
-- 	cmd = "mkdir -p target/release && cd target/release"
-- 		.. " && wget "
-- 		.. base_url
-- 		.. os
-- 		.. " && mv "
-- 		.. os
-- 		.. " libblink_cmp_fuzzy"
-- 		.. lib
-- elseif jit.os:lower() == "windows" then
-- 	local os = "x86_64-pc-windows-msvc.dll"
-- 	local lib = ".dll"
-- 	cmd = "mkdir target\\release & cd target\\release"
-- 		.. " & wget "
-- 		.. base_url
-- 		.. os
-- 		.. " & ren "
-- 		.. os
-- 		.. " libblink_cmp_fuzzy"
-- 		.. lib
-- end

return {
	"Saghen/blink.cmp",
	event = "User AfterLoad",
	version = "1.*",
	-- build = cmd,
	dependencies = {
		"L3MON4D3/LuaSnip",
	},
	opts = {
		keymap = {
			preset = "none",
			["<cr>"] = { "accept", "fallback" },
			["<c-u>"] = { "cancel", "fallback" },
			["<c-n>"] = { "select_next", "fallback" },
			["<c-p>"] = { "select_prev", "fallback" },
			["<space>"] = {
				function(cmp)
					if not vim.g.rime_enabled then
						return false
					end
					local rime_item_index = require("plugins.rime-ls").get_n_rime_item_index(1)
					if #rime_item_index ~= 1 then
						return false
					end
					return cmp.accept({ index = rime_item_index[1] })
				end,
				"fallback",
			},
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		snippets = {
			preset = "luasnip",
		},
		completion = {
			menu = {
				border = "single",
				winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
				scrollbar = false,
				draw = {
					treesitter = { "lsp" },
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
		},
		signature = {
			enabled = true,
			window = {
				border = "single",
			},
		},
		sources = {
			default = { "lsp", "path", "buffer", "snippets", "lazydev" },
			providers = {
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
			implementation = "rust",
			prebuilt_binaries = {
				ignore_version_mismatch = false,
			},
		},
	},
}
