-- Tiny deferred-loading helpers. vim.pack only installs plugins; these decide *when*
-- optional plugins get on 'runtimepath' and when setup code runs.
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

---------------------------------------------------------------------------
-- Optional plugins: kept off 'runtimepath' until first needed
---------------------------------------------------------------------------
M.loaded = {} ---@type table<string, true> plugins on 'runtimepath' (set by plugins/init.lua too)
local by_module = {} ---@type table<string, string[]> top-level Lua module -> optional plugins

--- Put an optional plugin on 'runtimepath' and source its plugin/ files (once).
---@param name string
function M.packadd(name)
	if M.loaded[name] then
		return
	end
	M.loaded[name] = true
	-- Before load-plugins (`:h startup`) only add it to 'rtp': startup sources its plugin/
	-- files with all the others, `:packadd` would source them a second time.
	vim.cmd.packadd({ name, bang = vim.v.vim_did_init == 0 })
end

--- Load optional plugins on the first `require` of any of their Lua modules (like lazy.nvim's
--- `module` trigger), so setup code can simply `require()` them.
---@param plugins {name: string, path: string}[]
function M.on_require(plugins)
	for _, p in ipairs(plugins) do
		for entry, kind in vim.fs.dir(p.path .. "/lua") do
			local mod = kind == "directory" and entry or entry:match("^([^.]+)%.")
			if mod then
				by_module[mod] = by_module[mod] or {}
				table.insert(by_module[mod], p.name)
			end
		end
	end
end

local function search(modname)
	local names = by_module[modname:match("^[^.]+")]
	if not names then
		return
	end
	by_module[modname:match("^[^.]+")] = nil
	for _, name in ipairs(names) do
		M.packadd(name)
	end
	-- the plugin/ files just sourced may have loaded the module already (capture it now:
	-- `require` puts a sentinel into package.loaded before calling the loader)
	local mod = package.loaded[modname]
	if mod ~= nil then
		return function()
			return mod
		end
	end
	-- now on 'runtimepath': let the other searchers (vim.loader, ...) find it
	for _, searcher in ipairs(package.loaders) do
		if searcher ~= search then
			local loader = searcher(modname)
			if type(loader) == "function" then
				return loader
			end
		end
	end
end
table.insert(package.loaders, 2, search)

---------------------------------------------------------------------------
-- File-triggered setup
---------------------------------------------------------------------------
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
