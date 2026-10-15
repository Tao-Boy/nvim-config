-- Native treesitter setup (no nvim-treesitter):
--   * highlighting / folding via vim.treesitter for every filetype with a parser + queries
--   * extra grammars are fetched by vim.pack (see plugins/init.lua) and compiled here
--   * small node-type based textobjects (af/if, ac/ic, aa/ia, ...); incremental selection
--     uses the built-in `an` / `in` / `]n` / `[n` mappings
local M = {}

local site = vim.fn.stdpath("data") .. "/site"

-- Parsers bundled with Neovim: c, lua, vim, vimdoc, query, markdown, markdown_inline.
-- Everything else is listed here: `vim.pack` clones the grammar repo, `M.build` compiles
-- `parser/<lang>.so` and copies the repo's queries to `queries/<lang>/` (both inside `site`).
M.grammars = {
	{ lang = "bash", repo = "tree-sitter/tree-sitter-bash" },
	{ lang = "cpp", repo = "tree-sitter/tree-sitter-cpp" },
	{ lang = "css", repo = "tree-sitter/tree-sitter-css" },
	{ lang = "html", repo = "tree-sitter/tree-sitter-html" },
	{ lang = "json", repo = "tree-sitter/tree-sitter-json" },
	{ lang = "nix", repo = "nix-community/tree-sitter-nix" },
	{ lang = "python", repo = "tree-sitter/tree-sitter-python" },
	{ lang = "rust", repo = "tree-sitter/tree-sitter-rust" },
	{ lang = "toml", repo = "tree-sitter-grammars/tree-sitter-toml" },
	{ lang = "typst", repo = "uben0/tree-sitter-typst" },
	{ lang = "yaml", repo = "tree-sitter-grammars/tree-sitter-yaml" },
}
for _, g in ipairs(M.grammars) do
	g.name = g.repo:match("[^/]+$") -- vim.pack plugin name
end

-- NOTE: `vim.treesitter` is only touched once a real file is opened, so starting on the
-- dashboard / an empty buffer does not pay for loading it.

---------------------------------------------------------------------------
-- Building grammars
---------------------------------------------------------------------------

local function copy_queries(path, lang)
	-- Neovim-style layout (queries/<lang>/*.scm) or upstream layout (queries/*.scm)
	local src = vim.uv.fs_stat(path .. "/queries/" .. lang) and (path .. "/queries/" .. lang) or (path .. "/queries")
	local dst = site .. "/queries/" .. lang
	vim.fn.delete(dst, "rf")
	vim.fn.mkdir(dst, "p")
	for name, type in vim.fs.dir(src) do
		if type == "file" and name:match("%.scm$") then
			vim.uv.fs_copyfile(src .. "/" .. name, dst .. "/" .. name)
		end
	end
end

local function restart_buffers(lang)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.treesitter.language.get_lang(vim.bo[buf].filetype) == lang then
			M.attach(buf)
		end
	end
end

local building = {} ---@type table<string, true>

--- Compile a grammar repo at `path` into `site/parser/<lang>.so` (async).
---@param lang string
---@param path string
function M.build(lang, path)
	if building[lang] then
		return
	end
	local src = path .. "/src"
	if not vim.uv.fs_stat(src .. "/parser.c") then
		return vim.notify(("treesitter: %s has no src/parser.c"):format(path), vim.log.levels.ERROR)
	end
	vim.fn.mkdir(site .. "/parser", "p")
	local out = ("%s/parser/%s.so"):format(site, lang)
	local tmp = out .. ".tmp"

	local cmd
	if vim.fn.executable("tree-sitter") == 1 then
		cmd = { "tree-sitter", "build", "-o", tmp, path }
	else
		local cc = vim.env.CC or "cc"
		cmd = { cc, "-o", tmp, "-shared", "-fPIC", "-O2", "-std=c11", "-I", src, src .. "/parser.c" }
		if vim.uv.fs_stat(src .. "/scanner.c") then
			table.insert(cmd, src .. "/scanner.c")
		end
	end

	building[lang] = true
	vim.system(cmd, { text = true }, function(res)
		vim.schedule(function()
			building[lang] = nil
			if res.code ~= 0 then
				vim.fn.delete(tmp)
				return vim.notify(("treesitter: building %s failed\n%s"):format(lang, res.stderr), vim.log.levels.ERROR)
			end
			-- Rename over the old file: a parser already loaded in this session keeps working.
			vim.uv.fs_rename(tmp, out)
			copy_queries(path, lang)
			M.reset(lang)
			vim.notify(("treesitter: built %s"):format(lang))
			restart_buffers(lang)
		end)
	end)
end

--- (Re)build the given languages, or every configured grammar that is not built yet.
---@param langs? string[]
---@param force? boolean rebuild even if the parser already exists
function M.build_all(langs, force)
	local wanted = langs and #langs > 0 and langs or nil
	for _, g in ipairs(M.grammars) do
		if not wanted or vim.list_contains(wanted, g.lang) then
			if force or not vim.uv.fs_stat(("%s/parser/%s.so"):format(site, g.lang)) then
				local ok, plugin = pcall(vim.pack.get, { g.name }, { info = false })
				if ok and plugin[1] then
					M.build(g.lang, plugin[1].path)
				end
			end
		end
	end
end

---------------------------------------------------------------------------
-- Attaching to buffers
---------------------------------------------------------------------------

local function has_query(lang, name)
	local ok, query = pcall(vim.treesitter.query.get, lang, name)
	return ok and query ~= nil
end

local predicates_added = false
-- Per-language capability cache, so filetypes without a parser (plugin UIs, ...) do not
-- search 'runtimepath' for parser/queries on every FileType event.
local cache = {} ---@type table<string, {highlights: boolean, folds: boolean}>

local function capabilities(lang)
	if not cache[lang] then
		if not predicates_added then
			predicates_added = true
			-- Upstream queries use `#is-not? local`, which needs locals tracking Neovim does not do.
			vim.treesitter.query.add_predicate("is-not?", function()
				return true
			end, { force = true })
		end
		local ok = vim.treesitter.language.add(lang) and has_query(lang, "highlights")
		cache[lang] = { highlights = ok or false, folds = ok and has_query(lang, "folds") or false }
	end
	return cache[lang]
end

--- Forget cached capabilities (after (re)building a parser).
---@param lang string
function M.reset(lang)
	cache[lang] = nil
end

--- Start treesitter highlighting and folding for `buf` when possible.
---@param buf integer
function M.attach(buf)
	local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
	local caps = lang and capabilities(lang)
	if not caps or not caps.highlights then
		return
	end
	if not vim.treesitter.highlighter.active[buf] then
		vim.treesitter.start(buf, lang)
	end
	if caps.folds then
		for _, win in ipairs(vim.fn.win_findbuf(buf)) do
			vim.wo[win][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end
	end
end

local group = vim.api.nvim_create_augroup("user.treesitter", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	desc = "Start treesitter",
	callback = function(ev)
		-- only file buffers: scratch/plugin buffers (dashboard, pickers, hover docs, ...)
		-- either have no parser or start treesitter themselves (markdown/help ftplugins)
		local bt = vim.bo[ev.buf].buftype
		if bt == "" or bt == "acwrite" then
			M.attach(ev.buf)
		end
	end,
})

vim.api.nvim_create_user_command("TSBuild", function(opts)
	M.build_all(opts.fargs, opts.bang)
end, {
	bang = true,
	nargs = "*",
	desc = "Build missing treesitter parsers (! = rebuild)",
	complete = function()
		return vim.tbl_map(function(g)
			return g.lang
		end, M.grammars)
	end,
})

---------------------------------------------------------------------------
-- Textobjects (node-type based, no queries needed)
---------------------------------------------------------------------------

local objects = {
	f = { "function", "method", "lambda", "closure", "arrow_function" },
	c = { "^class", "^struct", "^impl_item", "^trait_item", "^enum_item", "^enum_specifier", "^union", "^interface" },
	i = { "^if_", "conditional", "ternary", "^switch", "^match_expression", "^case_statement" },
	l = { "^for_", "^while_", "^loop_expression", "^do_statement", "^repeat_statement" },
	r = { "^return_" },
}
-- Node types that merely *mention* one of the above (`function_call`, `class_body`, ...)
local excluded = {
	"call",
	"invocation",
	"parameter",
	"argument",
	"signature",
	"declarator",
	"capture",
	"reference",
	"identifier",
	"name",
	"body",
	"list",
	"heritage",
	"type",
	"pointer",
}
local lists = { "parameters", "parameter_list", "arguments", "argument_list", "type_arguments", "type_parameters" }

local function matches(type, patterns)
	for _, p in ipairs(patterns) do
		if type:find(p) then
			return true
		end
	end
	return false
end

local function find(node, key)
	while node do
		local type = node:type()
		if key == "a" then
			local parent = node:parent()
			if parent and node:named() and matches(parent:type(), lists) then
				return node
			end
		elseif matches(type, objects[key]) and not matches(type, excluded) then
			return node
		end
		node = node:parent()
	end
end

---@return integer, integer, integer, integer
local function inner_range(node)
	local body = node:field("body")[1] or node:field("consequence")[1] or node
	local first, last = body:named_child(0), body:named_child(body:named_child_count() - 1)
	if not first then
		return body:range()
	end
	local sr, sc = first:range()
	local _, _, er, ec = last:range()
	return sr, sc, er, ec
end

---@return integer, integer, integer, integer
local function outer_param_range(node)
	local sr, sc, er, ec = node:range()
	local next, prev = node:next_sibling(), node:prev_sibling()
	if next and next:type() == "," then
		local after = next:next_named_sibling()
		if after then
			er, ec = after:start()
		else
			_, _, er, ec = next:range()
		end
	elseif prev and prev:type() == "," then
		local before = prev:prev_named_sibling()
		if before then
			_, _, sr, sc = before:range()
		else
			sr, sc = prev:start()
		end
	end
	return sr, sc, er, ec
end

local function select_range(sr, sc, er, ec)
	-- treesitter ranges are end-exclusive
	if ec == 0 and er > sr then
		er = er - 1
		ec = #vim.fn.getline(er + 1)
	end
	ec = math.max(ec - 1, 0)
	if vim.fn.mode() ~= "v" then
		vim.cmd("normal! v")
	end
	vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
	vim.cmd("normal! o")
	vim.api.nvim_win_set_cursor(0, { er + 1, ec })
end

local function textobject(key, inner)
	return function()
		local ok, node = pcall(vim.treesitter.get_node, { ignore_injections = false })
		node = ok and node and find(node, key)
		if not node then
			return
		end
		if key == "a" then
			if inner then
				select_range(node:range())
			else
				select_range(outer_param_range(node))
			end
		elseif inner then
			select_range(inner_range(node))
		else
			select_range(node:range())
		end
	end
end

for key, name in pairs({ f = "function", c = "class", a = "parameter", i = "conditional", l = "loop", r = "return" }) do
	vim.keymap.set({ "x", "o" }, "a" .. key, textobject(key, false), { desc = "around " .. name })
	vim.keymap.set({ "x", "o" }, "i" .. key, textobject(key, true), { desc = "inside " .. name })
end

return M
