-- Requires the latest Neovim release (0.12+): vim.pack, ui2-era APIs, treesitter selection.
if vim.fn.has("nvim-0.12") == 0 then
	vim.api.nvim_echo({ { "This config requires Neovim >= 0.12", "ErrorMsg" } }, true, {})
	return
end

vim.loader.enable()

require("config.options")
require("config.highlights")
require("config.autocmds")
require("config.keymaps")
require("config.treesitter")
require("plugins")

-- LSP & diagnostics are loaded with the first real file, after it has been drawn
-- (vim.lsp.enable() attaches to buffers whose FileType already fired).
local load = require("utils.load")
load.on(
	{ "BufReadPre", "BufNewFile", "FileType" },
	function()
		load.later(function()
			require("config.lsp")
		end)
	end,
	nil,
	function(ev)
		return vim.bo[ev.buf].buftype == ""
	end
)
