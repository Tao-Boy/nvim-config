-- Plugin management with the built-in `vim.pack` (`:h vim.pack`).
--   :PackUpdate [name...]   fetch updates and review them (`:write` to apply, `:quit` to discard)
--   :PackStatus             show installed plugins without fetching
--   :PackClean              delete plugins that are no longer listed below
-- Revisions are pinned in `nvim-pack-lock.json`; keep it under version control.
local ts = require("config.treesitter")
local load = require("utils.load")

local function gh(repo)
	return "https://github.com/" .. repo
end

-- Only plugins marked `start` are put on 'runtimepath' at startup. All others are optional:
-- they are `:packadd`-ed by the first `require()` of one of their modules (see utils/load.lua),
-- i.e. when their setup code first runs, or by an explicit `load.packadd()`.
local specs = {
	-- needed for the first screen
	{ src = gh("folke/snacks.nvim"), data = { start = true } }, -- dashboard, notifier, bigfile, ...
	-- library / UI
	gh("nvim-tree/nvim-web-devicons"),
	gh("MunifTanjim/nui.nvim"),
	gh("nvim-lua/plenary.nvim"),
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
	-- coding
	{ src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2") },
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("1") },
	gh("stevearc/conform.nvim"),
	-- AI
	gh("ColinKennedy/mega.logging"),
	gh("ColinKennedy/mega.cmdparse"),
	gh("yetone/avante.nvim"),
	-- languages
	gh("lervag/vimtex"), -- loaded on FileType tex/bib (plugins/lang.lua)
}

-- Tree-sitter grammars are fetched (and updated / locked) by vim.pack as well,
-- but never put on 'runtimepath': they are compiled into site/parser instead.
for _, g in ipairs(ts.grammars) do
	table.insert(specs, { src = gh(g.repo), name = g.name, data = { grammar = g.lang } })
end

--- avante.nvim: fetch its prebuilt Rust libraries (needs curl + tar; `:AvanteBuild` builds from source).
local function build_avante(path)
	local cmd = vim.fn.has("win32") == 1
			and { "powershell", "-ExecutionPolicy", "Bypass", "-File", "Build.ps1", "-BuildFromSource", "false" }
		or { "bash", "build.sh" }
	vim.notify("avante.nvim: downloading prebuilt libraries ...")
	vim.system(cmd, { cwd = path, text = true }, function(res)
		vim.schedule(function()
			if res.code == 0 then
				vim.notify("avante.nvim: build finished")
			else
				vim.notify("avante.nvim: build failed\n" .. (res.stderr or ""), vim.log.levels.ERROR)
			end
		end)
	end)
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
		elseif data.spec.name == "avante.nvim" then
			build_avante(data.path)
		end
	end,
})

-- During startup, collect plugin dirs and put them on 'runtimepath' in one go instead of one
-- `:packadd!` (a 'packpath' glob + 'rtp' rewrite) per plugin. The resulting order matches
-- `:packadd!`: plugins right after "site", their after/ dirs right before "site/after".
-- plugin/ and ftdetect/ files are then sourced by the normal startup sequence.
local rtp_dirs, rtp_after = {}, {}
local optional = {} ---@type {name: string, path: string}[]

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

local ok, err = pcall(vim.pack.add, specs, {
	confirm = false,
	load = function(plugin)
		local data = plugin.spec.data
		if type(data) == "table" and data.grammar then
			return
		end
		if not (type(data) == "table" and data.start) then
			table.insert(optional, { name = plugin.spec.name, path = plugin.path })
			return
		end
		load.loaded[plugin.spec.name] = true
		if vim.v.vim_did_enter == 1 then
			return vim.cmd.packadd(plugin.spec.name)
		end
		table.insert(rtp_dirs, plugin.path)
		if vim.uv.fs_stat(plugin.path .. "/after") then
			table.insert(rtp_after, 1, plugin.path .. "/after")
		end
	end,
})
vim.o.cmdheight = cmdheight
if not ok then
	vim.notify("vim.pack: " .. tostring(err), vim.log.levels.ERROR)
end
load.on_require(optional)
if #rtp_dirs > 0 then
	-- normalize: on Windows 'rtp' entries use backslashes, stdpath() .. "/site" does not
	local norm = vim.fs.normalize
	local site = norm(vim.fn.stdpath("data") .. "/site")
	local rtp = vim.opt.rtp:get()
	local out = {}
	for _, dir in ipairs(rtp) do
		if norm(dir) == site .. "/after" then
			vim.list_extend(out, rtp_after)
			rtp_after = {}
		end
		table.insert(out, dir)
		if norm(dir) == site then
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
	vim.pack.update(#opts.fargs > 0 and opts.fargs or nil)
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
	vim.pack.update(nil, { offline = true })
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
require("plugins.ai")
