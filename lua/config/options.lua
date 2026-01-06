vim.opt.viewoptions = "folds,cursor"
vim.opt.jumpoptions = "stack"
vim.g.snacks_animate = false

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.undofile = false
vim.opt.ruler = false

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

vim.opt.list = false
vim.opt.signcolumn = "yes"

vim.opt.fillchars = { eob = " " }

vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.timeoutlen = 400

vim.o.foldmethod = "manual"
vim.o.foldenable = true
vim.o.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.o.foldlevelstart = -1

vim.opt.statusline = " "
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.showmode = false

vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"

vim.opt.spell = false

vim.opt.cmdheight = 0
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"

vim.opt.smartindent = true
vim.opt.swapfile = false

vim.opt.updatetime = 200
vim.opt.writebackup = false

vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 8
vim.opt.title = false
vim.lsp.log.set_level(vim.log.levels.OFF)
vim.opt.shadafile = "NONE"

vim.g.tex_flavor = "latex"

vim.opt.pumblend = 20
vim.opt.fixeol = false

vim.opt.wrap = true
vim.opt.linebreak = true
