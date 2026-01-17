local M = {}

local ts_utils = require("nvim-treesitter.ts_utils")
-- M.in_mathzone = function()
-- 	local info = vim.inspect_pos()
-- 	for _, ts in ipairs(info.treesitter) do
-- 		if ts.capture == "markup.math" then
-- 			return true
-- 		end
-- 	end
--   return false
-- end

M.in_mathzone = function()
	local node = ts_utils.get_node_at_cursor()
	while node do
		if node:type() == "math" then
			return true
		end
		node = node:parent()
	end
	return false
end

M.in_text = function()
	return not M.in_mathzone()
end

return M
