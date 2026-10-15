local M = {}

---------------------------------------------------------------------------
-- blink.cmp prebuilt fuzzy-matcher binary (downloaded through vim.g.gh_proxy)
---------------------------------------------------------------------------
local blink_targets = {
	linux = { x64 = "x86_64-unknown-linux-gnu", arm64 = "aarch64-unknown-linux-gnu", ext = ".so" },
	osx = { x64 = "x86_64-apple-darwin", arm64 = "aarch64-apple-darwin", ext = ".dylib" },
	windows = { x64 = "x86_64-pc-windows-msvc", arm64 = "aarch64-pc-windows-msvc", ext = ".dll" },
}

--- Download the fuzzy-matcher library matching the checked out blink.cmp tag (async).
---@param path string blink.cmp plugin directory
M.blink_cmp = function(path)
	local os_targets = blink_targets[jit.os:lower()]
	local triple = os_targets and os_targets[jit.arch:lower()]
	if not triple then
		return vim.notify("blink.cmp: no prebuilt binary for " .. jit.os .. "/" .. jit.arch, vim.log.levels.WARN)
	end

	local tag = vim.system({ "git", "describe", "--tags", "--exact-match", "HEAD" }, { cwd = path, text = true }):wait()
	local release = tag.code == 0 and ("download/" .. vim.trim(tag.stdout)) or "latest/download"
	local url = ("https://%sgithub.com/Saghen/blink.cmp/releases/%s/%s%s"):format(
		vim.g.gh_proxy or "",
		release,
		triple,
		os_targets.ext
	)
	local dir = path .. "/target/release"
	vim.fn.mkdir(dir, "p")

	vim.notify("blink.cmp: downloading fuzzy library ...")
	local cmd = {
		"curl",
		"-fL",
		"--retry",
		"3",
		"--connect-timeout",
		"10",
		"-o",
		dir .. "/libblink_cmp_fuzzy" .. os_targets.ext,
		url,
	}
	vim.system(cmd, {}, function(res)
		vim.schedule(function()
			if res.code == 0 then
				vim.notify("blink.cmp: download finished")
			else
				vim.notify("blink.cmp: download failed\n" .. (res.stderr or ""), vim.log.levels.ERROR)
			end
		end)
	end)
end

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
