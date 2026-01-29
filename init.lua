vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.gh_proxy = "gh.xxooo.cf/"

require("config.lazy")
require("config.keymaps")
require("config.options")
