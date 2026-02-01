local M = {}

-- Download utilities from download.lua
local current_os = jit.os:lower()
local current_arch = jit.arch:lower()
local gh_proxy = vim.g.gh_proxy or ""

local function normalize_arch(arch)
	if arch == "x64" or arch == "amd64" then
		return "x86_64"
	end
	if arch == "arm64" then
		return "aarch64"
	end
	return arch
end

local blink_map = {
	linux = {
		x86_64 = { file = "x86_64-unknown-linux-gnu.so", ext = ".so" },
		aarch64 = { file = "aarch64-unknown-linux-gnu.so", ext = ".so" },
	},
	windows = {
		x86_64 = { file = "x86_64-pc-windows-msvc.dll", ext = ".dll" },
		aarch64 = { file = "aarch64-pc-windows-msvc.dll", ext = ".dll" },
	},
	osx = {
		x86_64 = { file = "x86_64-apple-darwin.dylib", ext = ".dylib" },
		aarch64 = { file = "aarch64-apple-darwin.dylib", ext = ".dylib" },
	},
}

local function get_blink_config()
	local os_map = blink_map[current_os]
	if not os_map then
		return nil
	end
	return os_map[normalize_arch(current_arch)]
end

-- Helper function to properly quote paths for shell commands
local function quote_path(path)
	if current_os == "windows" then
		-- Windows cmd.exe requires double quotes
		return '"' .. path .. '"'
	else
		-- Unix shells use single quotes
		return "'" .. path .. "'"
	end
end

-- autocmds
function M.loadAutocmd(opts)
	for augroup, autocmds in pairs(opts) do
		if autocmds then
			local augroup_id = vim.api.nvim_create_augroup(augroup, { clear = true })
			local function load_autocmd(autocmd)
				local event = autocmd.event
				autocmd.event = nil
				autocmd.group = augroup_id
				vim.api.nvim_create_autocmd(event, autocmd)
				autocmd.event = event
			end
			if #autocmds == 0 then
				load_autocmd(autocmds)
			end
			for _, autocmd in ipairs(autocmds) do
				load_autocmd(autocmd)
			end
		end
	end
end

-- Download functions
M.blink_cmp = function(plugin)
	local config = get_blink_config()
	if not config then
		vim.notify("Blink: no prebuilt binary for " .. current_os .. "/" .. current_arch, vim.log.levels.WARN)
		return
	end
	local base_url = "https://" .. gh_proxy .. "github.com/Saghen/blink.cmp/releases/latest/download/"
	local download_url = base_url .. config.file

	local target_dir = plugin.dir .. "/target/release"
	local target_file = target_dir .. "/libblink_cmp_fuzzy" .. config.ext

	if vim.fn.isdirectory(target_dir) == 0 then
		vim.fn.mkdir(target_dir, "p")
	end

	local curl_cmd = string.format("curl -Lo %s %s", quote_path(target_file), quote_path(download_url))

	vim.notify("Blink: downloading ...", vim.log.levels.INFO)

	vim.fn.jobstart(curl_cmd, {
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				vim.notify("Blink: download finished", vim.log.levels.INFO)
			else
				vim.notify("Blink: download failed", vim.log.levels.ERROR)
			end
		end,
	})
end

M.blink_pairs = function(plugin)
	local config = get_blink_config()
	if not config then
		vim.notify("blink-pairs: no prebuilt binary for " .. current_os .. "/" .. current_arch, vim.log.levels.WARN)
		return
	end
	local base_url = "https://" .. gh_proxy .. "github.com/Saghen/blink.pairs/releases/latest/download/"
	local download_url = base_url .. config.file

	local target_dir = plugin.dir .. "/target/release"
	local target_file = target_dir .. "/blink_pairs" .. config.ext

	local curl_cmd = string.format("curl -Lo %s %s", quote_path(target_file), quote_path(download_url))

	vim.notify("blink-pairs: downloading ...", vim.log.levels.INFO)

	if vim.fn.isdirectory(target_dir) == 0 then
		vim.fn.mkdir(target_dir, "p")
	end

	vim.fn.jobstart(curl_cmd, {
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				vim.notify("blink-pairs: download finished", vim.log.levels.INFO)
			else
				vim.notify("blink-pairs: download failed", vim.log.levels.ERROR)
			end
		end,
	})
end

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

M.in_typ_mathzone = function()
	local function node_at_cursor()
		local ok, node = pcall(vim.treesitter.get_node, { ignore_injections = false })
		if ok then
			return node
		end
		return nil
	end
	local node = node_at_cursor()
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

return M
