local cmd = ""
local base_url = "https://gh.hitaoboy.top/https://github.com/Saghen/blink.cmp/releases/latest/download/"
if jit.os:lower() == "linux" then
	local os = "x86_64-unknown-linux-gnu.so"
	local lib = ".so"
	cmd = "mkdir -p target/release && cd target/release"
		.. " && wget "
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
		.. " & wget "
		.. base_url
		.. os
		.. " & ren "
		.. os
		.. " libblink_cmp_fuzzy"
		.. lib
end

return {
	"Saghen/blink.cmp",
	event = "User AfterLoad",
	version = "*",
	dependencies = {
		"L3MON4D3/LuaSnip",
		{
			"Kaiser-Yang/blink-cmp-dictionary",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
	build = cmd,
	opts = {
		keymap = {
			preset = "default",
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "normal",
		},
		snippets = {
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},
		completion = {
			menu = {
				border = "rounded",
				draw = {
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				window = {
					border = "rounded",
					scrollbar = false,
				},
			},
		},
		signature = {
			enabled = true,
			window = {
				border = "rounded",
			},
		},
		sources = {
			default = { "lsp", "path", "buffer", "snippets", "lazydev", "dictionary" },
			providers = {
				lazydev = {
					name = "Development",
					module = "lazydev.integrations.blink",
				},
				dictionary = {
					module = "blink-cmp-dictionary",
					name = "Dict",
					min_keyword_length = 3,
					opts = {
						dictionary_directories = { vim.fn.expand("/usr/share/dict/") },
					},
				},
			},
		},
		fuzzy = {
			prebuilt_binaries = {
				download = false,
			},
		},
	},
}
