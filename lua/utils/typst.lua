local M = {}

M.in_mathzone = function()
	local info = vim.inspect_pos()
	for _, syn in ipairs(info.syntax) do
		if syn.hl_group_link:match("mathblock") then
			return true
		end
	end
end

M.in_text = function()
	return not M.in_mathzone()
end

return M
