vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://gh.hitaoboy.top/https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
-------------------------------------

require("lazy").setup({
	spec = {
		{ import = "plugins.ui" },
		{ import = "plugins.lsp" },
		{ import = "plugins.git" },
		{ import = "plugins.edit" },
		{ import = "plugins.tools" },
	},
	defaults = {
		lazy = true,
		version = false,
	},
	install = { colorscheme = { "catppuccin" } },
	checker = {
		enabled = false,
		notify = false,
	},
	git = {
		url_format = "https://gh.hitaoboy.top/https://github.com/%s.git",
	},
	ui = {
		border = "rounded",
		title = "Lazy Panel",
	},
	performance = {
		cache = { enabled = true },
		reset_packpath = true,
		throttle = {
			enabled = true,
		},
		rtp = {
			reset = true,
			disabled_plugins = {
				"man",
				"osc52",
				"shada",
				"tutor",
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
})
