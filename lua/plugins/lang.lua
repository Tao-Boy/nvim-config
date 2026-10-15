local load = require("utils.load")

---------------------------------------------------------------------------
-- vimtex: configured through globals, must be set before the ftplugin runs
---------------------------------------------------------------------------
vim.g.vimtex_view_method = "general"
vim.g.vimtex_view_general_viewer = "echo"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_fold_enabled = 1
vim.g.vimtex_compiler_latexmk = {
	-- keep aux files in RAM where available (Linux); latexmk's default elsewhere (Windows)
	aux_dir = vim.fn.isdirectory("/dev/shm") == 1 and "/dev/shm/" or nil,
	out_dir = "./",
	callback = 1,
	continuous = 1,
	options = { "-synctex=0" },
}

-- Loaded with the first tex / bib buffer. The built-in ftplugin and indent script have
-- already run for it by then, so run those FileType autocmds again: they undo the built-in
-- ones (b:undo_ftplugin) and now find vimtex's first ('runtimepath' puts it before $VIMRUNTIME).
load.on("FileType", function(ev)
	load.packadd("vimtex")
	for _, group in ipairs({ "filetypeplugin", "filetypeindent" }) do
		pcall(vim.api.nvim_exec_autocmds, "FileType", { group = group, pattern = ev.match, modeline = false })
	end
end, { "tex", "bib" })

---------------------------------------------------------------------------
-- typst: live preview served by tinymist itself (no plugin), opened in the browser.
-- Clicking in the preview jumps to the source (tinymist sends window/showDocument).
---------------------------------------------------------------------------
local previews = {} ---@type table<string, {client: vim.lsp.Client, group: integer}> by task id

---@param buf integer
local function task_id(buf)
	return "nvim-" .. vim.fn.sha256(vim.api.nvim_buf_get_name(buf)):sub(1, 12)
end

---@param client vim.lsp.Client
---@param buf integer
---@param command string
---@param args any[]
---@param on_result? fun(result: any)
local function exec(client, buf, command, args, on_result)
	client:exec_cmd({ title = command, command = command, arguments = args }, { bufnr = buf }, function(err, result)
		if err then
			return vim.notify(("tinymist: %s failed: %s"):format(command, err.message), vim.log.levels.ERROR)
		end
		if on_result then
			on_result(result)
		end
	end)
end

--- Scroll the preview to the cursor position.
local function sync(buf)
	local preview = previews[task_id(buf)]
	if preview then
		local pos = vim.api.nvim_win_get_cursor(0)
		exec(preview.client, buf, "tinymist.scrollPreview", {
			task_id(buf),
			{ event = "panelScrollTo", filepath = vim.api.nvim_buf_get_name(buf), line = pos[1] - 1, character = pos[2] },
		})
	end
end

local function stop(buf)
	local id = task_id(buf)
	local preview = previews[id]
	if preview then
		previews[id] = nil
		vim.api.nvim_del_augroup_by_id(preview.group)
		if not preview.client:is_stopped() then
			exec(preview.client, buf, "tinymist.doKillPreview", { id })
		end
		vim.notify("tinymist: preview stopped")
	end
end

local function toggle(buf, client)
	if previews[task_id(buf)] then
		return stop(buf)
	end
	local id = task_id(buf)
	exec(client, buf, "tinymist.doStartPreview", {
		{
			"--task-id",
			id,
			"--data-plane-host=127.0.0.1:0", -- random free ports
			"--control-plane-host=127.0.0.1:0",
			"--invert-colors=auto",
			vim.api.nvim_buf_get_name(buf),
		},
	}, function(result)
		local group = vim.api.nvim_create_augroup("user.typst_preview." .. id, { clear = true })
		previews[id] = { client = client, group = group }
		-- follow the cursor (CursorHold: once it rests for 'updatetime')
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = group,
			buffer = buf,
			callback = function()
				sync(buf)
			end,
		})
		vim.api.nvim_create_autocmd("LspDetach", {
			group = group,
			buffer = buf,
			callback = function(ev)
				if ev.data.client_id == client.id then
					stop(buf)
				end
			end,
		})
		if result and result.staticServerAddr then
			local url = "http://" .. result.staticServerAddr
			vim.notify("tinymist: preview at " .. url)
			vim.ui.open(url)
		end
	end)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user.typst", { clear = true }),
	desc = "Typst preview keymaps",
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client or client.name ~= "tinymist" then
			return
		end
		local buf = ev.buf
		vim.keymap.set("n", "<leader>tp", function()
			toggle(buf, client)
		end, { buffer = buf, desc = "Typst: Toggle Preview" })
		vim.keymap.set("n", "<leader>ts", function()
			sync(buf)
		end, { buffer = buf, desc = "Typst: Sync Preview to Cursor" })
	end,
})
