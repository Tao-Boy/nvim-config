-- Tiny deferred-loading helpers. vim.pack only puts plugins on 'runtimepath';
-- these decide *when* their setup code runs.
local M = {}

local group = vim.api.nvim_create_augroup("user.load", { clear = true })

--- Run `fn` once, on the first of `events` (optionally filtered by `pattern`).
---@param events string|string[]
---@param fn fun(ev: vim.api.keyset.create_autocmd.callback_args)
---@param pattern? string|string[]
function M.on(events, fn, pattern)
	local done = false
	vim.api.nvim_create_autocmd(events, {
		group = group,
		pattern = pattern,
		callback = function(ev)
			if done then
				return true
			end
			done = true
			fn(ev)
			return true -- delete the autocmd
		end,
	})
end

--- Run `fn` right after startup has finished (like lazy.nvim's "VeryLazy").
---@param fn fun()
function M.later(fn)
	if vim.v.vim_did_enter == 1 then
		return vim.schedule(fn)
	end
	M.on("VimEnter", function()
		vim.schedule(fn)
	end)
end

local file_queue, file_opened = {}, false

--- Run `fn` once the first real file is opened (not on the dashboard / empty start).
---@param fn fun()
function M.on_file(fn)
	if file_opened then
		return fn()
	end
	table.insert(file_queue, fn)
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
	group = group,
	callback = function(ev)
		if file_opened or vim.bo[ev.buf].buftype ~= "" then
			return
		end
		file_opened = true
		for _, fn in ipairs(file_queue) do
			fn()
		end
		file_queue = {}
		return true
	end,
})

return M
