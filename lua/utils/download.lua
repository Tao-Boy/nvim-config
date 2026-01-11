local current_os = jit.os:lower()
local gh_proxy = vim.g.gh_proxy or ""
local is_windows = current_os == "windows"

local blink_map = {
	linux = { file = "x86_64-unknown-linux-gnu.so", ext = ".so" },
	windows = { file = "x86_64-pc-windows-msvc.dll", ext = ".dll" },
	osx = { file = "aarch64-apple-darwin.dylib", ext = ".dylib" },
}

local avante_map = {
	linux = { file = "avante_lib-linux-x86_64.so", ext = ".so" },
	windows = { file = "avante_lib-windows-x86_64.dll", ext = ".dll" },
	osx = { file = "avante_lib-darwin-aarch64.dylib", ext = ".dylib" },
}

local M = {}

local function normalize_path(path)
	if is_windows then
		return path:gsub("/", "\\")
	end
	return path
end

local function get_download_command(url, dest)
	if is_windows then
		local dest_path = normalize_path(dest)
		-- Escape quotes in paths for PowerShell
		local escaped_url = url:gsub("'", "''")
		local escaped_dest = dest_path:gsub("'", "''")
		return string.format(
			'powershell -ExecutionPolicy Bypass -Command "& { try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri \'%s\' -OutFile \'%s\'; exit 0 } catch { Write-Error $_.Exception.Message; exit 1 } }"',
			escaped_url,
			escaped_dest
		)
	else
		return string.format("curl -Lo '%s' '%s'", dest, url)
	end
end

M.blink_cmp = function(plugin)
	local config = blink_map[current_os]
	local base_url = "https://" .. gh_proxy .. "github.com/Saghen/blink.cmp/releases/latest/download/"
	local download_url = base_url .. config.file

	local target_dir = plugin.dir .. "/target/release"
	local target_file = target_dir .. "/libblink_cmp_fuzzy" .. config.ext

	if vim.fn.isdirectory(target_dir) == 0 then
		vim.fn.mkdir(target_dir, "p")
	end

	local download_cmd = get_download_command(download_url, target_file)

	vim.notify("Blink: downloading ...", vim.log.levels.INFO)

	vim.fn.jobstart(download_cmd, {
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
	local config = blink_map[current_os]
	local base_url = "https://" .. gh_proxy .. "github.com/Saghen/blink.pairs/releases/latest/download/"
	local download_url = base_url .. config.file

	local target_dir = plugin.dir .. "/target/release"
	local target_file = target_dir .. "/blink_pairs" .. config.ext

	if vim.fn.isdirectory(target_dir) == 0 then
		vim.fn.mkdir(target_dir, "p")
	end

	local download_cmd = get_download_command(download_url, target_file)

	vim.notify("blink-pairs: downloading ...", vim.log.levels.INFO)

	vim.fn.jobstart(download_cmd, {
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				vim.notify("blink-pairs: download finished", vim.log.levels.INFO)
			else
				vim.notify("blink-paris: download failed", vim.log.levels.ERROR)
			end
		end,
	})
end

M.avante = function(plugin)
	local config = avante_map[current_os]
	if not config then
		vim.notify("Avante: Unsupported OS for auto-download", vim.log.levels.ERROR)
		return
	end

	local base_url = "https://" .. gh_proxy .. "github.com/yetone/avante.nvim/releases/latest/download/"
	local download_url = base_url .. config.file

	local target_dir = plugin.dir .. "/build"

	local target_filename = "avante_lib" .. config.ext
	local target_file = target_dir .. "/" .. target_filename

	if vim.fn.isdirectory(target_dir) == 0 then
		vim.fn.mkdir(target_dir, "p")
	end

	local download_cmd = get_download_command(download_url, target_file)

	vim.notify("Avante: downloading core library ...", vim.log.levels.INFO)

	vim.fn.jobstart(download_cmd, {
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				vim.notify("Avante: download finished. Ready to use.", vim.log.levels.INFO)
			else
				vim.notify("Avante: download failed", vim.log.levels.ERROR)
			end
		end,
	})
end

return M
