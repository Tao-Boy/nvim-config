local custom = require("utils.custom")

return {
	"Bekaboo/dropbar.nvim",
	event = { "BufRead", "BufNewFile" },
	opts = {
		icons = { kinds = { symbols = custom.icons.kind_with_space } },
		bar = {
			hover = false,
			enable = function(buf, win, _)
				if
					not vim.api.nvim_buf_is_valid(buf)
					or not vim.api.nvim_win_is_valid(win)
					or vim.fn.win_gettype(win) ~= ""
					or vim.wo[win].winbar ~= ""
					or vim.bo[buf].ft == "help"
					or vim.bo[buf].ft == ""
				then
					return false
				end

				return vim.bo[buf].ft == "markdown"
					or pcall(vim.treesitter.get_parser, buf)
					or not vim.tbl_isempty(vim.lsp.get_clients({
						bufnr = buf,
						method = "textDocument/documentSymbol",
					}))
			end,
			sources = function(buf, _)
				local sources = require("dropbar.sources")
				local utils = require("dropbar.utils")
				if vim.bo[buf].ft == "markdown" then
					return { sources.markdown }
				end
				if vim.bo[buf].buftype == "terminal" then
					return { sources.terminal }
				end
				return {
					utils.source.fallback({
						sources.lsp,
						sources.treesitter,
					}),
				}
			end,
		},
	},
}
