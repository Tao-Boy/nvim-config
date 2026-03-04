require("utils.autocmds")
-- Editor appearance
vim.cmd.colorscheme("catppuccin")
vim.opt.background = "dark" -- Set background to dark
vim.opt.termguicolors = true -- Enable true color support
vim.opt.cursorline = true -- enable highlighting of the current line
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.fillchars = { eob = " ", diff = "\u{2591}" } -- Set fill characters (end of buffer and diff)
vim.opt.list = false -- Disable showing whitespace characters
vim.opt.wrap = false -- Disable automatic line wrapping
vim.opt.linebreak = true -- Wrap lines at word boundaries
vim.opt.conceallevel = 0 -- Disable text concealment
vim.opt.pumblend = 20 -- Popup menu transparency
require("utils.highlights")

-- Line numbers and scrolling
vim.opt.number = true -- Show line numbers
vim.opt.cursorlineopt = "number"
vim.opt.relativenumber = false -- Disable relative line numbers
vim.opt.ruler = false -- Disable ruler display
vim.opt.scrolloff = 0 -- Number of lines to keep above/below cursor when scrolling vertically
vim.opt.sidescrolloff = 8 -- Number of columns to keep left/right of cursor when scrolling horizontally

-- Windows and layout
vim.opt.splitbelow = true -- Open horizontal splits below
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.laststatus = 3 -- Global statusline
vim.opt.statusline = " " -- Statusline content
vim.opt.cmdheight = 0 -- Command line height set to 0
vim.opt.showcmd = false -- Disable showing command in bottom bar
vim.opt.showmode = false -- Disable showing mode in bottom bar

-- Indentation and tabs
vim.opt.tabstop = 2 -- Tab width is 2 spaces
vim.opt.shiftwidth = 2 -- Indent width is 2 spaces
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Enable smart indentation

-- Searching
vim.opt.incsearch = true -- Incremental search
vim.opt.hlsearch = false -- Disable search highlighting
vim.opt.ignorecase = true -- Ignore case in searches
vim.opt.smartcase = true -- Smart case (case-sensitive if uppercase letters are used)

-- Undo and backup
vim.opt.undofile = true -- Enable persistent undo
vim.opt.undolevels = 1000 -- Number of undo levels
vim.opt.backup = false -- Disable backup files
vim.opt.writebackup = false -- Disable write backup
vim.opt.swapfile = false -- Disable swap files

-- Sessions and views
vim.opt.viewoptions = "folds,cursor" -- What to save in view files
vim.opt.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,terminal" -- Session saving options
vim.opt.shada = "'100,<50,s10,h" -- ShaDa file configuration

-- Folding
vim.o.foldmethod = "expr" -- Folding method is expr
vim.o.foldenable = false -- Disable folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99 -- Folding level
vim.o.foldlevelstart = 1 -- Initial folding level
vim.o.foldcolumn = "0" -- Width of the fold column
vim.opt.foldtext = "" -- Fold text
vim.opt.foldnestmax = 4 -- Maximum fold nesting

-- Completion and input
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Completion options
vim.opt.shortmess = vim.o.shortmess .. "a" -- Shorten message display
vim.opt.timeoutlen = 400 -- Timeout for key mappings (ms)

-- Mouse
vim.opt.mouse = "a" -- Enable mouse support in all modes
vim.opt.mousemoveevent = true -- Enable mouse move events

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Spelling and encoding
vim.opt.spell = false -- Disable spell checking
vim.opt.fileencoding = "utf-8" -- File encoding is UTF-8

-- Miscellaneous
vim.opt.autoread = true -- Automatically reload files changed externally
vim.opt.updatetime = 200 -- Update time (ms)
vim.opt.fixeol = false -- Do not enforce end-of-file newline
vim.opt.title = false -- Disable window title
vim.g.asyncrun_open = 6 -- Async run window setting
vim.g.tex_flavor = "latex" -- TeX file type
vim.lsp.log.set_level(vim.log.levels.OFF) -- LSP log level
vim.o.iskeyword = "@,48-57,_,192-255,-" -- Keyword character definition
vim.g.no_plugin_maps = true
