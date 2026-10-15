local M = {}

---------------------------------------------------------------------------
-- Snippet conditions
---------------------------------------------------------------------------
M.in_tex_env = function(env)
	local pos = vim.fn["vimtex#env#is_inside"](env)
	return pos[1] ~= 0 or pos[2] ~= 0
end

M.in_tex_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

M.in_tex_text = function()
	return not M.in_tex_mathzone()
end

M.in_tex_item = function()
	return M.in_tex_env("itemize") or M.in_tex_env("enumerate")
end
M.in_tex_bib = function()
	return M.in_tex_env("thebibliography")
end
M.in_tex_tikz = function()
	return M.in_tex_env("tikzpicture")
end

--- Fallback when no treesitter parser is available: odd number of `$` before the cursor
local function odd_dollars_before_cursor()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- 1-indexed column
	local _, dollars = line:sub(1, col):gsub("%$", "")
	return dollars % 2 == 1
end

M.in_typ_mathzone = function()
	local ok, node = pcall(vim.treesitter.get_node, { ignore_injections = false })
	if not ok or not node then
		return odd_dollars_before_cursor()
	end
	while node do
		if node:type() == "math" then
			return true
		end
		node = node:parent()
	end
	return false
end

M.in_typ_text = function()
	return not M.in_typ_mathzone()
end

M.in_md_mathzone = function()
	local math_types = { latex_span = true, latex_block = true }
	local ok, node = pcall(vim.treesitter.get_node, { ignore_injections = false })
	if ok and node then
		while node do
			if math_types[node:type()] then
				return true
			end
			node = node:parent()
		end
		return false
	end
	return odd_dollars_before_cursor()
end

M.in_md_text = function()
	return not M.in_md_mathzone()
end

return M
