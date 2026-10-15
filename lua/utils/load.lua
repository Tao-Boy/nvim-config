-- Tiny deferred-loading helpers. vim.pack only puts plugins on 'runtimepath';
-- these decide *when* their setup code runs.
local M = {}

local group = vim.api.nvim_create_augroup("user.load", { clear = true })

--- Run `fn` once, on the first of `events` (optionally filtered by `pattern`).
---@param events string|string[]
---@param fn fun(ev: vim.api.keyset.create_autocmd.callback_args)
---@param pattern? string|string[]
---@param cond? fun(ev: vim.api.keyset.create_autocmd.callback_args): boolean only fire when true
function M.on(events, fn, pattern, cond)
	local done = false
	vim.api.nvim_create_autocmd(events, {
		group = group,
		pattern = pattern,
		callback = function(ev)
			if done then
				return true
			end
			if cond and not cond(ev) then
				return
			end
			done = true
			fn(ev)
			return true -- delete the autocmd
		end,
	})
end

--- Run `fn` right after startup has finished, i.e. after the first screen has been drawn
--- (like lazy.nvim's "VeryLazy"). After startup it is merely scheduled.
---@param fn fun()
function M.later(fn)
	if vim.v.vim_did_enter == 1 then
		return vim.schedule(fn)
	end
	M.on("VimEnter", function()
		vim.schedule(fn)
	end)
end

local queue = { sync = {}, deferred = {} }
local file_opened = false

--- Run `fn` once the first real file is opened (not on the dashboard / empty start).
--- By default `fn` runs after that file has been drawn; `sync = true` runs it before
--- (for UI that would otherwise shift the layout, like a winbar).
---@param fn fun()
---@param sync? boolean
function M.on_file(fn, sync)
	if file_opened then
		return sync and fn() or vim.schedule(fn)
	end
	table.insert(sync and queue.sync or queue.deferred, fn)
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
	group = group,
	callback = function(ev)
		if file_opened or vim.bo[ev.buf].buftype ~= "" then
			return
		end
		file_opened = true
		for _, fn in ipairs(queue.sync) do
			fn()
		end
		local deferred = queue.deferred
		M.later(function()
			for _, fn in ipairs(deferred) do
				fn()
			end
		end)
		queue = { sync = {}, deferred = {} }
		return true
	end,
})

return M
