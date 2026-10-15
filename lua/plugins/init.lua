-- Plugin management with the built-in `vim.pack` (`:h vim.pack`).
--   :PackUpdate [name...]   fetch updates and review them (`:write` to apply, `:quit` to discard)
--   :PackStatus             show installed plugins without fetching
--   :PackClean              delete plugins that are no longer listed below
-- Revisions are pinned in `nvim-pack-lock.json`; keep it under version control.
local ts = require("config.treesitter")

local function gh(repo)
	return "https://" .. (vim.g.gh_proxy or "") .. "github.com/" .. repo
end

--- Route every github.com URL git sees through vim.g.gh_proxy while vim.pack is working.
--- The specs below already carry the prefix, but git submodules can use absolute
--- `https://github.com/...` URLs (e.g. tree-sitter-yaml's test suite). Where github.com
--- is unreachable such a clone stalls forever, and since vim.pack waits for all git jobs
--- without a timeout, Neovim froze during the first start.
--- Scoped through GIT_CONFIG_* env vars (inherited by vim.pack's git processes), so git
--- used from Neovim otherwise (terminal, pickers) is unaffected.
---@return fun() restore
local function use_mirror()
	local proxy = vim.g.gh_proxy or ""
	if proxy == "" then
		return function() end
	end
	local count = vim.env.GIT_CONFIG_COUNT
	local n = tonumber(count) or 0
	vim.env["GIT_CONFIG_KEY_" .. n] = ("url.https://%sgithub.com/.insteadOf"):format(proxy)
	vim.env["GIT_CONFIG_VALUE_" .. n] = "https://github.com/"
	vim.env.GIT_CONFIG_COUNT = tostring(n + 1)
	local restored = false
	return function()
		if restored then
			return
		end
		restored = true
		vim.env["GIT_CONFIG_KEY_" .. n] = nil
		vim.env["GIT_CONFIG_VALUE_" .. n] = nil
		vim.env.GIT_CONFIG_COUNT = count
	end
end

--- vim.pack.update() wrapper: keep the mirror active while its confirmation buffer
--- (where `:write` applies the updates) is open.
local function pack_update(names, opts)
	local restore = use_mirror()
	local ok, err = pcall(vim.pack.update, names, opts)
	local buf = vim.api.nvim_get_current_buf()
	if ok and vim.bo[buf].filetype == "nvim-pack" then
		vim.api.nvim_create_autocmd("BufWipeout", { buffer = buf, once = true, callback = restore })
	else
		restore()
	end
	if not ok then
		error(err, 0)
	end
end

local specs = {
	-- library / UI
	gh("nvim-tree/nvim-web-devicons"),
	gh("MunifTanjim/nui.nvim"),
	gh("folke/snacks.nvim"),
	gh("folke/persistence.nvim"),
	gh("folke/noice.nvim"),
	gh("folke/which-key.nvim"),
	gh("nvim-lualine/lualine.nvim"),
	gh("akinsho/bufferline.nvim"),
	gh("Bekaboo/dropbar.nvim"),
	-- editor
	gh("folke/flash.nvim"),
	gh("stevearc/oil.nvim"),
	gh("hedyhli/outline.nvim"),
	gh("akinsho/toggleterm.nvim"),
	gh("windwp/nvim-autopairs"),
	-- coding (`opt`: not loaded at startup, `:packadd`-ed on first use)
	{ src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2"), data = { opt = true } },
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("1"), data = { opt = true } },
	gh("stevearc/conform.nvim"),
	-- languages
	gh("lervag/vimtex"), -- not lazy-loadable: its ftplugin must win over the built-in tex one
	{ src = gh("chomosuke/typst-preview.nvim"), data = { opt = true } },
}

-- Tree-sitter grammars are fetched (and updated / locked) by vim.pack as well,
-- but never put on 'runtimepath': they are compiled into site/parser instead.
for _, g in ipairs(ts.grammars) do
	table.insert(specs, { src = gh(g.repo), name = g.name, data = { grammar = g.lang } })
end

-- Build hooks. Must be registered before vim.pack.add() to catch fresh installs.
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("user.pack", { clear = true }),
	desc = "Run plugin build steps",
	callback = function(ev)
		local data = ev.data
		local lang = type(data.spec.data) == "table" and data.spec.data.grammar or nil
		if data.kind == "delete" then
			if lang then
				vim.fn.delete(vim.fn.stdpath("data") .. "/site/parser/" .. lang .. ".so")
				vim.fn.delete(vim.fn.stdpath("data") .. "/site/queries/" .. lang, "rf")
			end
			return
		end
		if lang then
			ts.build(lang, data.path)
		elseif data.spec.name == "blink.cmp" then
			require("utils.functions").blink_cmp(data.path)
		end
	end,
})

-- During startup, collect plugin dirs and put them on 'runtimepath' in one go instead of one
-- `:packadd!` (a 'packpath' glob + 'rtp' rewrite) per plugin. The resulting order matches
-- `:packadd!`: plugins right after "site", their after/ dirs right before "site/after".
-- plugin/ and ftdetect/ files are then sourced by the normal startup sequence.
local rtp_dirs, rtp_after = {}, {}

-- First start: installing takes a while (everything is cloned before Neovim continues),
-- so make vim.pack's progress messages visible instead of showing a frozen screen.
local pack_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/"
local installing = false
for _, spec in ipairs(specs) do
	local name = type(spec) == "table" and (spec.name or spec.src:match("[^/]+$")) or spec:match("[^/]+$")
	installing = installing or not vim.uv.fs_stat(pack_dir .. name)
end
local cmdheight = vim.o.cmdheight
if installing then
	vim.o.cmdheight = math.max(cmdheight, 1)
	vim.api.nvim_echo({ { "vim.pack: installing plugins, this can take a few minutes ...", "WarningMsg" } }, false, {})
	vim.cmd.redraw()
end

local restore_git = use_mirror()
local ok, err = pcall(vim.pack.add, specs, {
	confirm = false,
	load = function(plugin)
		local data = plugin.spec.data
		if type(data) == "table" and (data.grammar or data.opt) then
			return
		end
		if vim.v.vim_did_enter == 1 then
			return vim.cmd.packadd(plugin.spec.name)
		end
		table.insert(rtp_dirs, plugin.path)
		if vim.uv.fs_stat(plugin.path .. "/after") then
			table.insert(rtp_after, 1, plugin.path .. "/after")
		end
	end,
})
restore_git()
vim.o.cmdheight = cmdheight
if not ok then
	vim.notify("vim.pack: " .. tostring(err), vim.log.levels.ERROR)
end
if #rtp_dirs > 0 then
	local site = vim.fn.stdpath("data") .. "/site"
	local rtp = vim.opt.rtp:get()
	local out = {}
	for _, dir in ipairs(rtp) do
		if dir == site .. "/after" then
			vim.list_extend(out, rtp_after)
			rtp_after = {}
		end
		table.insert(out, dir)
		if dir == site then
			vim.list_extend(out, rtp_dirs)
			rtp_dirs = {}
		end
	end
	-- 'site' not on 'rtp' (unusual setups): append whatever is left
	vim.list_extend(out, rtp_dirs)
	vim.list_extend(out, rtp_after)
	vim.o.runtimepath = table.concat(
		vim.tbl_map(function(dir)
			return (dir:gsub(",", "\\,"))
		end, out),
		","
	)
end

-- Grammars whose build failed or was skipped (e.g. compiler missing at install time)
ts.build_all()

vim.api.nvim_create_user_command("PackUpdate", function(opts)
	pack_update(#opts.fargs > 0 and opts.fargs or nil)
end, {
	nargs = "*",
	desc = "Update plugins",
	complete = function()
		return vim.tbl_map(function(p)
			return p.spec.name
		end, vim.pack.get(nil, { info = false }))
	end,
})
vim.api.nvim_create_user_command("PackStatus", function()
	pack_update(nil, { offline = true })
end, { desc = "Show plugin status" })
vim.api.nvim_create_user_command("PackClean", function()
	local stale = vim.iter(vim.pack.get(nil, { info = false }))
		:filter(function(p)
			return not p.active
		end)
		:map(function(p)
			return p.spec.name
		end)
		:totable()
	if #stale == 0 then
		return vim.notify("vim.pack: nothing to clean")
	end
	if vim.fn.confirm("Delete " .. table.concat(stale, ", ") .. "?", "&Yes\n&No", 2) == 1 then
		vim.pack.del(stale)
	end
end, { desc = "Delete plugins not listed in the config" })

require("plugins.ui")
require("plugins.editor")
require("plugins.coding")
require("plugins.lang")
