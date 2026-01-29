local M = {}
local lsp_config = {
	lua_ls = {
		settings = {
			Lua = {
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				hint = {
					enable = false,
					setType = true,
				},
				diagnostics = {
					disable = { "missing-fields", "incomplete-signature-doc" },
				},
			},
		},
	},
	texlab = {
		settings = {
			texlab = {
				chktex = {
					onOpenAndSave = true,
					onEdit = false,
				},
			},
		},
	},
	pyright = {},
	julials = {},
	nixd = {
		filetypes = { "nix" },
		cmd = { "nixd" },
		settings = {
			nixd = {
				nixpkgs = {
					expr = "import <nixpkgs> { }",
				},
				formatting = {
					command = { "alejandra" },
				},
				options = {
					nixos = {
						expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
					},
					home_manager = {
						expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options',
					},
				},
			},
		},
	},
	clangd = {
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	},
	tinymist = {
		init_options = {
			formatterMode = "typstyle",
			exportPdf = "never",
			semanticTokens = "disable",
		},
	},
	rust_analyzer = {},
}

M.init = function()
	local path_sep = vim.fn.has("win32") == 1 and ";" or ":"
	local base_path = vim.fn.stdpath("data") .. "/mason/bin" .. path_sep
	vim.env.PATH = base_path .. (vim.env.PATH or "")
	for k, v in pairs(lsp_config) do
		vim.lsp.config[k] = v
		vim.lsp.enable(k)
	end
end

return M
