local M = {}

M.in_mathzone = function()
	local info = vim.inspect_pos()
	for _, ts in ipairs(info.treesitter) do
		if ts.capture == "markup.math" then
			return true
		end
	end
	return false
end

M.in_text = function ()
  return not M.in_mathzone()
end

return M
