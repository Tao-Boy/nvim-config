return {
	"Saghen/blink.cmp",
	event = "User AfterLoad",
	version = "*",
	dependencies = { "L3MON4D3/LuaSnip" },
	build = function()
		local function get_info()
			local os = jit.os:lower()
			if os == "osx" then
				os = "mac"
			end
			return os
		end

		local os = get_info()
		local base_url = "https://gh.hitaoboy.top/https://github.com/Saghen/blink.cmp/releases/latest/download/"
		local lib, cmd = "", ""

		if os == "linux" then
			os = "x86_64-unknown-linux-gnu.so"
			lib = ".so"
			cmd = "cd "
				.. vim.fn.stdpath("data")
				.. "/lazy/blink.cmp"
				.. "&& mkdir -p target/release && cd target/release"
				.. "&& wget "
				.. base_url
				.. os
				.. "&& mv "
				.. os
				.. " libblink_cmp_fuzzy"
				.. lib
		elseif os == "windows" then
			os = "x86_64-pc-windows-msvc.dll"
			lib = ".dll"
			cmd = "cd "
				.. vim.fn.stdpath("data")
				.. "\\lazy\\blink.cmp"
				.. "& mkdir target\\release & cd target\\release"
				.. "& wget "
				.. base_url
				.. os
				.. " & mv "
				.. os
				.. " libblink_cmp_fuzzy"
				.. lib
		end

		return vim.fn.system(cmd)
	end,
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
			default = { "lsp", "path", "buffer", "snippets", "lazydev" },
			providers = {
				lazydev = {
					name = "Development",
					module = "lazydev.integrations.blink",
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
