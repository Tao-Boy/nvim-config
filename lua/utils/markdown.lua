local M = {}
local ts_utils = require("nvim-treesitter.ts_utils")

M.in_mathzone = function()
	local node = ts_utils.get_node_at_cursor()
	while node do
		if node:type() == "inline_formula" then
			return true
		elseif node:type() == "displayed_equation" then
			return true
		end
		node = node:parent()
	end
	return false
end

return M
