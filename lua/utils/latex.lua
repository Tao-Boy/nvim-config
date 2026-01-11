local M = {}

M.in_mathzone = function()
	return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

M.in_text = function()
	return not M.in_mathzone()
end

return M
