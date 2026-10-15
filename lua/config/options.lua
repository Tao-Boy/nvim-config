vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.no_plugin_maps = true
vim.g.tex_flavor = "latex"

-- No remote-plugin providers are used. Probing them is expensive: e.g. opening the first
-- Python file runs the python3 provider check (~100ms) via ftplugin/python.vim.
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- Disable unused built-in plugins (oil.nvim replaces netrw)
for _, plugin in ipairs({
	"gzip",
	"matchit",
	"netrw",
	"netrwPlugin",
	"remote_plugins",
	"tar",
	"tarPlugin",
	"zip",
	"zipPlugin",
}) do
	vim.g["loaded_" .. plugin] = 1
end

local opt = vim.opt

-- UI
opt.background = "dark"
opt.termguicolors = true
opt.cursorline = true
opt.cursorlineopt = "number"
opt.number = true
opt.relativenumber = false
opt.signcolumn = "yes"
opt.fillchars = { eob = " ", diff = "\u{2591}" }
opt.list = false
opt.wrap = false
opt.conceallevel = 0
opt.pumblend = 20
opt.winborder = "rounded" -- default border for every floating window (LSP hover, diagnostics, ...)
opt.ruler = false
opt.scrolloff = 0
opt.sidescrolloff = 8
opt.title = false

-- Statusline / cmdline (lualine + noice take over)
opt.laststatus = 3
opt.statusline = " "
opt.cmdheight = 0
opt.showcmd = false
opt.showmode = false

-- Windows
opt.splitbelow = true
opt.splitright = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.formatoptions:remove({ "r", "o" }) -- no comment continuation

-- Search
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true

-- Files, undo & sessions
opt.undofile = true
opt.undolevels = 1000
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.autoread = true
opt.fixeol = false
opt.viewoptions = "folds,cursor"
opt.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,terminal"
opt.shada = "'100,<50,s10,h"

-- Folding: foldexpr is set per window from treesitter / LSP (see config/treesitter.lua & config/lsp.lua)
opt.foldmethod = "expr"
opt.foldexpr = "0"
opt.foldenable = false
opt.foldlevel = 99
opt.foldlevelstart = 1
opt.foldcolumn = "0"
opt.foldtext = ""
opt.foldnestmax = 4

-- Completion & input
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("a")
opt.timeoutlen = 400
opt.updatetime = 200
opt.mouse = "a"
opt.spell = false
opt.iskeyword = "@,48-57,_,192-255,-"

-- Sync with the system clipboard without slowing down startup
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)

vim.cmd.colorscheme("catppuccin") -- bundled with Neovim
