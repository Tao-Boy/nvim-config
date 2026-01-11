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

local function quote_path(path)
	if is_windows and path:find(" ") then
		return '"' .. path:gsub('"', '""') .. '"'
	end
	return path
end

local function get_download_command(url, dest)
	if is_windows then
		local dest_path = normalize_path(dest)
		-- Use curl if available, otherwise fallback to PowerShell
		return string.format(
			'curl -L -o "%s" "%s" || powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri \"%s\" -OutFile \"%s\"; exit 0 } catch { exit 1 }"',
			dest_path, url, url, dest_path
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
		local parent_dir = target_dir:match("^(.*)[\\/]")
		if parent_dir and vim.fn.isdirectory(parent_dir) == 0 then
			local success, err = pcall(vim.fn.mkdir, parent_dir, "p")
			if not success then
				vim.notify("Failed to create parent directory: " .. (err or "unknown error"), vim.log.levels.ERROR)
				return
			end
		end
		local success, err = pcall(vim.fn.mkdir, target_dir, "p")
		if not success then
			vim.notify("Failed to create directory: " .. (err or "unknown error"), vim.log.levels.ERROR)
			return
		end
	end

	local download_cmd = get_download_command(download_url, target_file)

	vim.notify("Blink: downloading ...", vim.log.levels.INFO)

	local job_id = vim.fn.jobstart(download_cmd, {
		on_stdout = function(_, data, _)
			if data and #data > 0 and data[1] ~= "" then
				vim.notify("Blink: " .. table.concat(data, "\n"), vim.log.levels.DEBUG)
			end
		end,
		on_stderr = function(_, data, _)
			if data and #data > 0 and data[1] ~= "" then
				vim.notify("Blink error: " .. table.concat(data, "\n"), vim.log.levels.WARN)
			end
		end,
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				vim.notify("Blink: download finished", vim.log.levels.INFO)
			else
				vim.notify("Blink: download failed (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
			end
		end,
	})
	if job_id <= 0 then
		vim.notify("Blink: Failed to start download job", vim.log.levels.ERROR)
	end
end

M.blink_pairs = function(plugin)
	local config = blink_map[current_os]
	local base_url = "https://" .. gh_proxy .. "github.com/Saghen/blink.pairs/releases/latest/download/"
	local download_url = base_url .. config.file

	local target_dir = plugin.dir .. "/target/release"
	local target_file = target_dir .. "/blink_pairs" .. config.ext

	if vim.fn.isdirectory(target_dir) == 0 then
		local parent_dir = target_dir:match("^(.*)[\\/]")
		if parent_dir and vim.fn.isdirectory(parent_dir) == 0 then
			local success, err = pcall(vim.fn.mkdir, parent_dir, "p")
			if not success then
				vim.notify("Failed to create parent directory: " .. (err or "unknown error"), vim.log.levels.ERROR)
				return
			end
		end
		local success, err = pcall(vim.fn.mkdir, target_dir, "p")
		if not success then
			vim.notify("Failed to create directory: " .. (err or "unknown error"), vim.log.levels.ERROR)
			return
		end
	end

	local download_cmd = get_download_command(download_url, target_file)

	vim.notify("blink-pairs: downloading ...", vim.log.levels.INFO)

	local job_id = vim.fn.jobstart(download_cmd, {
		on_stdout = function(_, data, _)
			if data and #data > 0 and data[1] ~= "" then
				vim.notify("blink-pairs: " .. table.concat(data, "\n"), vim.log.levels.DEBUG)
			end
		end,
		on_stderr = function(_, data, _)
			if data and #data > 0 and data[1] ~= "" then
				vim.notify("blink-pairs error: " .. table.concat(data, "\n"), vim.log.levels.WARN)
			end
		end,
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				vim.notify("blink-pairs: download finished", vim.log.levels.INFO)
			else
				vim.notify("blink-pairs: download failed (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
			end
		end,
	})
	if job_id <= 0 then
		vim.notify("blink-pairs: Failed to start download job", vim.log.levels.ERROR)
	end
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
		local parent_dir = target_dir:match("^(.*)[\\/]")
		if parent_dir and vim.fn.isdirectory(parent_dir) == 0 then
			local success, err = pcall(vim.fn.mkdir, parent_dir, "p")
			if not success then
				vim.notify("Failed to create parent directory: " .. (err or "unknown error"), vim.log.levels.ERROR)
				return
			end
		end
		local success, err = pcall(vim.fn.mkdir, target_dir, "p")
		if not success then
			vim.notify("Failed to create directory: " .. (err or "unknown error"), vim.log.levels.ERROR)
			return
		end
	end

	local download_cmd = get_download_command(download_url, target_file)

	vim.notify("Avante: downloading core library ...", vim.log.levels.INFO)

	local job_id = vim.fn.jobstart(download_cmd, {
		on_stdout = function(_, data, _)
			if data and #data > 0 and data[1] ~= "" then
				vim.notify("Avante: " .. table.concat(data, "\n"), vim.log.levels.DEBUG)
			end
		end,
		on_stderr = function(_, data, _)
			if data and #data > 0 and data[1] ~= "" then
				vim.notify("Avante error: " .. table.concat(data, "\n"), vim.log.levels.WARN)
			end
		end,
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				vim.notify("Avante: download finished. Ready to use.", vim.log.levels.INFO)
			else
				vim.notify("Avante: download failed (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
			end
		end,
	})
	if job_id <= 0 then
		vim.notify("Avante: Failed to start download job", vim.log.levels.ERROR)
	end
end

return M
