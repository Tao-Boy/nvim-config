vim.cmd.colorscheme("gruvbox")

vim.opt.viewoptions = "folds,cursor"
vim.opt.jumpoptions = "stack"

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.undofile = false
vim.opt.ruler = false

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.cursorline = false
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

vim.opt.cmdheight = 1
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"

vim.opt.smartindent = true
vim.opt.swapfile = false

vim.opt.updatetime = 100
vim.opt.writebackup = false

vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 8
vim.opt.title = false
vim.lsp.log.set_level(vim.log.levels.OFF)
vim.opt.shadafile = "NONE"

vim.opt.iskeyword = "_,49-57,A-Z,a-z"

vim.opt.pumblend = 20
vim.opt.fixeol = false

vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
