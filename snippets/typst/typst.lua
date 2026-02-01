local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local typst = require("utils.functions")

local math_symbols = {
	s(
		{ trig = "...", wordTrig = true, snippetType = "autosnippet" },
		{ t("dots") },
		{ condition = typst.in_typ_mathzone }
	),
	s({
		trig = "c.",
		wordTrig = true,
		priority = 1500,
		snippetType = "autosnippet",
	}, { t("dot.c") }, { condition = typst.in_typ_mathzone }),
	s({
		trig = "o.",
		wordTrig = true,
		priority = 1500,
		snippetType = "autosnippet",
	}, { t("dot.o") }, { condition = typst.in_typ_mathzone }),
	s({
		trig = "v.",
		wordTrig = true,
		priority = 1500,
		snippetType = "autosnippet",
	}, { t("dot.v") }, { condition = typst.in_typ_mathzone }),
	s(
		{ trig = "dot.c.", wordTrig = true, priority = 2000, snippetType = "autosnippet" },
		{ t("dots.c") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "dot.v.", wordTrig = true, priority = 2000, snippetType = "autosnippet" },
		{ t("dots.v") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Equality and inequality
	s({
		trig = "==",
		wordTrig = true,
		snippetType = "autosnippet",
	}, { t("&=") }, { condition = typst.in_typ_mathzone }),
	s(
		{ trig = "~=", wordTrig = true, snippetType = "autosnippet" },
		{ t("approx") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "eqv", wordTrig = true, snippetType = "autosnippet" },
		{ t("equiv") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Logic symbols
	s({
		trig = "iff",
		wordTrig = true,
		snippetType = "autosnippet",
	}, { t("<==>") }, { condition = typst.in_typ_mathzone }),
	s(
		{ trig = "aa", wordTrig = true, snippetType = "autosnippet" },
		{ t("forall") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "ee", wordTrig = true, snippetType = "autosnippet" },
		{ t("exists") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Arrows
	s({
		trig = "to",
		wordTrig = true,
		snippetType = "autosnippet",
	}, { t("->") }, { condition = typst.in_typ_mathzone }),
	s(
		{ trig = "mto", wordTrig = true, snippetType = "autosnippet", priority = 1001 },
		{ t("mapsto") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "up", wordTrig = true, snippetType = "autosnippet" },
		{ t("arrow.t") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "down", wordTrig = true, snippetType = "autosnippet" },
		{ t("arrow.b") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Set operations
	s(
		{ trig = "cap", wordTrig = true, snippetType = "autosnippet" },
		{ t("inter") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "cup", wordTrig = true, snippetType = "autosnippet" },
		{ t("union") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "sub", wordTrig = true, snippetType = "autosnippet" },
		{ t("subset") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "emp", snippetType = "autosnippet", priority = 2000 },
		{ t("emptyset") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Binary operations
	s(
		{ trig = "+-", wordTrig = true, snippetType = "autosnippet" },
		{ t("plus.minus") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "-+", wordTrig = true, snippetType = "autosnippet" },
		{ t("minus.plus") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "xx", wordTrig = true, snippetType = "autosnippet" },
		{ t("times") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "cir", wordTrig = true, snippetType = "autosnippet" },
		{ t("circle") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "ot", wordTrig = true, snippetType = "autosnippet" },
		{ t("times.o") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "op", wordTrig = true, snippetType = "autosnippet" },
		{ t("plus.o") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Superscripts and subscripts
	s(
		{ trig = "sr", wordTrig = false, snippetType = "autosnippet" },
		{ t("^2") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "cb", wordTrig = false, snippetType = "autosnippet" },
		{ t("^3") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "inv", wordTrig = false, snippetType = "autosnippet" },
		{ t("^(-1)") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "**", wordTrig = false, snippetType = "autosnippet" },
		{ t("^*") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "tp", wordTrig = false, snippetType = "autosnippet" },
		{ t("^top") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "dr", wordTrig = false, snippetType = "autosnippet" },
		{ t("^dagger") },
		{ condition = typst.in_typ_mathzone }
	),
	s({ trig = "cc", snippetType = "autosnippet" }, { t("^c") }, { condition = typst.in_typ_mathzone }),
	s({ trig = "++", snippetType = "autosnippet" }, { t("^((+))") }, { condition = typst.in_typ_mathzone }),
	s(
		{ trig = "--", snippetType = "autosnippet", priority = 2000 },
		{ t("^((-))") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Other symbols
	s(
		{ trig = "oo", wordTrig = true, snippetType = "autosnippet" },
		{ t("infinity") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "par", wordTrig = true, snippetType = "autosnippet", priority = 2000 },
		{ t("partial") },
		{ condition = typst.in_typ_mathzone }
	),
	s({ trig = "nabla", snippetType = "autosnippet" }, { t("\\nabla") }, { condition = typst.in_typ_mathzone }),

	-- Integrals
	s({ trig = "ii", snippetType = "autosnippet" }, { t("integral") }, { condition = typst.in_typ_mathzone }),

	-- Positional snippets
	s(
		{ trig = "jk", wordTrig = false, snippetType = "autosnippet" },
		fmta("_(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "kj", wordTrig = false, snippetType = "autosnippet" },
		fmta("^(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),
}

local greek_letters = {
	-- Alpha
	s(
		{ trig = ";A", snippetType = "autosnippet", wordTrig = true },
		{ t("Alpha") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = ";a", snippetType = "autosnippet", wordTrig = true },
		{ t("alpha") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Beta
	s(
		{ trig = ";b", snippetType = "autosnippet", wordTrig = true },
		{ t("beta") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = ";B", snippetType = "autosnippet", wordTrig = true },
		{ t("Beta") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Gamma
	s(
		{ trig = ";g", snippetType = "autosnippet", wordTrig = true },
		{ t("gamma") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = ";G", snippetType = "autosnippet", wordTrig = true },
		{ t("Gamma") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Delta
	s(
		{ trig = ";d", snippetType = "autosnippet", wordTrig = true },
		{ t("delta") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = ";D", snippetType = "autosnippet", wordTrig = true },
		{ t("Delta") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Epsilon
	s(
		{ trig = "eps", snippetType = "autosnippet", wordTrig = true },
		{ t("epsilon") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "vps", snippetType = "autosnippet", wordTrig = true },
		{ t("epsilon.alt") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "Eps", snippetType = "autosnippet", wordTrig = true },
		{ t("Epsilon") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Zeta
	s(
		{ trig = ";z", snippetType = "autosnippet", wordTrig = true },
		{ t("zeta") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = ";Z", snippetType = "autosnippet", wordTrig = true },
		{ t("Zeta") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Theta
	s(
		{ trig = ";t", snippetType = "autosnippet", wordTrig = true },
		{ t("theta") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = ";T", snippetType = "autosnippet", wordTrig = true },
		{ t("Theta") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Lambda
	s(
		{ trig = "lam", snippetType = "autosnippet", wordTrig = true },
		{ t("lambda") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "Lam", snippetType = "autosnippet", wordTrig = true },
		{ t("Lambda") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Sigma
	s(
		{ trig = ";s", snippetType = "autosnippet", wordTrig = true },
		{ t("sigma") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = ";S", snippetType = "autosnippet", wordTrig = true },
		{ t("Sigma") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Upsilon
	s(
		{ trig = "ups", snippetType = "autosnippet", wordTrig = true },
		{ t("upsilon") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = "Ups", snippetType = "autosnippet", wordTrig = true },
		{ t("Upsilon") },
		{ condition = typst.in_typ_mathzone }
	),

	-- Omega
	s(
		{ trig = ";o", snippetType = "autosnippet", wordTrig = true },
		{ t("omega") },
		{ condition = typst.in_typ_mathzone }
	),
	s(
		{ trig = ";O", snippetType = "autosnippet", wordTrig = true },
		{ t("Omega") },
		{ condition = typst.in_typ_mathzone }
	),
}

local math_commands = {
	-- Accents and decorations
	s(
		{ trig = "ob", snippetType = "autosnippet" },
		fmta("overbrace(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),

	s({ trig = "td", snippetType = "autosnippet" }, fmta("tilde(<>)", { i(1) }), { condition = typst.in_typ_mathzone }),

	s(
		{ trig = "(%a)~", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("tilde(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = typst.in_typ_mathzone }
	),

	s({ trig = "dot", snippetType = "autosnippet" }, fmta("dot(<>)", { i(1) }), { condition = typst.in_typ_mathzone }),

	s(
		{ trig = "doo", snippetType = "autosnippet", priority = 2000 },
		fmta("dot.double(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),

	s({ trig = "hat", snippetType = "autosnippet" }, fmta("hat(<>)", { i(1) }), { condition = typst.in_typ_mathzone }),

	s(
		{ trig = "ub", snippetType = "autosnippet", priority = 2000 },
		fmta("underbrace(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),

	-- Square root
	s(
		{ trig = "sq", snippetType = "autosnippet", priority = 2000 },
		fmta("sqrt(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),
}

local environments = {
	-- Inline and display math
	s({ trig = "mk", snippetType = "autosnippet" }, fmta("$<>$", { i(1) }), { condition = typst.in_typ_text }),
	s({ trig = "dm", snippetType = "autosnippet" }, fmta("$\n  <>\n$", { i(1) }), { condition = typst.in_typ_text }),
}

local physics_braket = {
	s(
		{ trig = "bra", wordTrig = true, snippetType = "autosnippet", priority = 1000 },
		fmta("bra(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),

	s(
		{ trig = "ket", wordTrig = true, snippetType = "autosnippet", priority = 1000 },
		fmta("ket(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),

	s(
		{ trig = "bk", wordTrig = true, snippetType = "autosnippet", priority = 1000 },
		fmta("braket(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),

	s(
		{ trig = "kb", snippetType = "autosnippet" },
		fmta("ketbra(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),
}

local completion = {
	-- Subscript and superscript completion
	s(
		{ trig = "([%a%)%]%}])(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = typst.in_typ_mathzone }
	),

	s(
		{ trig = "([%a%)%]%}])_(%d)(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_(<><>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
			f(function(_, snip)
				return snip.captures[3]
			end),
		}),
		{ condition = typst.in_typ_mathzone }
	),

	s(
		{ trig = "([%a%)%]%}])(%a)%2", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 100 },
		fmta("<>_<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = typst.in_typ_mathzone }
	),

	s(
		{
			trig = "([%a%)%]%}])_(%a)(%a)%3",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			priority = 2000,
		},
		fmta("<>_(<><>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
			f(function(_, snip)
				return snip.captures[3]
			end),
		}),
		{ condition = typst.in_typ_mathzone }
	),

	-- Limits and sums
	s(
		{ trig = "lim", wordTrig = true, snippetType = "autosnippet" },
		fmta("lim_(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),

	s(
		{ trig = "lsup", wordTrig = true, snippetType = "autosnippet", priority = 2000 },
		fmta("limsup_(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),

	s(
		{ trig = "linf", wordTrig = true, snippetType = "autosnippet" },
		fmta("liminf_(<>)", { i(1) }),
		{ condition = typst.in_typ_mathzone }
	),

	s(
		{ trig = "sum", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("sum_("), i(1, "n=1"), t(")^("), i(2, "infinity"), t(")") }),
		}),
		{ condition = typst.in_typ_mathzone }
	),

	s(
		{ trig = "prod", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("product_("), i(1), t(")") }),
			sn(nil, { t("product_("), i(1), t(")^("), i(2), t(")") }),
		}),
		{ condition = typst.in_typ_mathzone }
	),

	-- Integrals
	s(
		{ trig = "int", wordTrig = true, snippetType = "autosnippet" },
		fmta("integral_(<>)^(<>) <> dif <>", { i(1), i(2), i(3), i(4) }),
		{ condition = typst.in_typ_mathzone }
	),

	s(
		{ trig = "2int", wordTrig = true, snippetType = "autosnippet", priority = 2000 },
		fmta("integral_(<>)^(<>) integral_(<>)^(<>) <> dif <> dif <>", { i(1), i(2), i(3), i(4), i(5), i(6), i(7) }),
		{ condition = typst.in_typ_mathzone }
	),

	s(
		{ trig = "lint", wordTrig = true, snippetType = "autosnippet", priority = 2000 },
		fmta("integral_(<>) <> dif <>", { i(1, "infinity"), i(2), i(3) }),
		{ condition = typst.in_typ_mathzone }
	),
}

local all_snippets = {}
vim.list_extend(all_snippets, math_symbols)
vim.list_extend(all_snippets, greek_letters)
vim.list_extend(all_snippets, math_commands)
vim.list_extend(all_snippets, environments)
vim.list_extend(all_snippets, physics_braket)
vim.list_extend(all_snippets, completion)
return all_snippets
