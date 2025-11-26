local M = {}
-- local ts_utils = require("nvim-treesitter.ts_utils")

M.in_mathzone = function()
	return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

M.not_in_mathzone = function()
	return not M.in_mathzone()
end

-- M.in_text = function()
-- 	return not M.in_latex()
-- end
--
-- M.in_latex = function()
-- 	local node = ts_utils.get_node_at_cursor()
-- 	while node do
-- 		if node:type() == "latex_block" then
-- 			return true
-- 		end
-- 		node = node:parent()
-- 	end
-- 	return false
-- end

M.in_latex = function()
	local info = vim.inspect_pos()
	for _, ts in ipairs(info.treesitter) do
		if ts.capture == "markup.math" then
			return true
		end
	end
	return false
end

M.not_in_latex = function()
	return not M.in_latex()
end

return M
