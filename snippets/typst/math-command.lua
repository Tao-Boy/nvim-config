local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local c = ls.choice_node
local events = require("luasnip.util.events")
local typst = require("utils.typst")

return {

	s({ trig = "mk", snippetType = "autosnippet" }, fmta([[ $<>$<>]], { i(1), i(2) })),

	s(
		{ trig = "dm", snippetType = "autosnippet" },
		fmta(
			[[
            $
            <>
            $
            ]],
			{ i(1) }
		),
		{ condition = typst.in_text }
	),

	s(
		{ trig = "sr", snippetType = "autosnippet", regTrig = true, wordTrig = false },
		fmta([[<>^(2)]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "cb", snippetType = "autosnippet", regTrig = true, wordTrig = false },
		fmta([[<>^(3)]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "([%w%)])kk", snippetType = "autosnippet", regTrig = true, wordTrig = false },
		fmta([[<>^(<>)]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "([%w%)])jj", snippetType = "autosnippet", regTrig = true, wordTrig = false },
		fmta([[<>_(<>)]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),

	s({ trig = "sq", snippetType = "autosnippet" }, fmta([[sqrt(<>)]], { i(1) }), { condition = typst.in_mathzone }),

	s(
		{ trig = "rt", snippetType = "autosnippet" },
		fmta([[root( <> , <> )]], { i(1), i(2) }),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "//", snippetType = "autosnippet", priority = 3000 },
		fmta([[frac( <> , <> )]], { i(1), i(2) }),
		{ condition = typst.in_mathzone }
	),

	s({ trig = "oo", snippetType = "autosnippet" }, { t("infinity") }, { condition = typst.in_mathzone }),

	s(
		{ trig = "sum", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("sum_("), i(1), t(") ") }),
			sn(nil, { t("sum_("), i(1), t(")^("), i(2), t(") ") }),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "pd", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("prod("), i(1), t(") ") }),
			sn(nil, { t("prod{"), i(1), t(")^("), i(2), t(") ") }),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "lim", snippetType = "autosnippet" },
		fmta([[lim_(<> arrow.r <>)]], { i(1, "n"), i(2, "infinity") }),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "bot", snippetType = "autosnippet" },
		fmta("bigotimes_(<>)^(<>)", { i(1), i(2) }),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "bcap", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("bigcap_(<>)^(<>)", {
			i(1),
			i(2),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "bcup", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("bigcup_(<>)^(<>)", {
			i(1),
			i(2),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "bscap", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("bigsqcap_(<>)^(<>)", {
			i(1),
			i(2),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "bscup", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("bigsqcup_(<>)^(<>)", {
			i(1),
			i(2),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "int", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("integral_(<>)^(<>) <> dif <>", {
			i(1),
			i(2),
			i(3),
			i(4),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "cint", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("integral.cont_(<>) <> dif <>", {
			i(1),
			i(2),
			i(3),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "sint", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("integral.surf_(<>) <> dif <>", {
			i(1),
			i(2),
			i(3),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "2int", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("integral_(<>)^(<>) integral_(<>)^(<>) <>  dif <> dif <>", {
			i(1),
			i(2),
			i(3),
			i(4),
			i(5),
			i(6),
			i(7),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "iint", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("integral.double_(<>) <> dif <>", {
			i(1),
			i(2),
			i(3),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "td", snippetType = "autosnippet", priority = 2000 },
		fmta("tilde(<>)", {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "bar", snippetType = "autosnippet" },
		fmta("overline(<>)", {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "(%a)bar", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("overline(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "(%a)bb", wordTrig = false, regTrig = true, snippetType = "autosnippet", priority = 3000 },
		fmta("bold(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "bb", wordTrig = false, regTrig = true, snippetType = "autosnippet", priority = 3000 },
		fmta("bold(<>)", {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "(%a)dot", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("dot(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "(%a)db", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("bold(dot(<>)<>)_<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(2),
			i(3),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "db", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("bold(dot(<>)<>)_<>", {
			i(1),
			i(2),
			i(3),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "(%a)ddb", wordTrig = false, regTrig = true, snippetType = "autosnippet", priority = 5000 },
		fmta("bold(ddot(<>)<>)_<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(2),
			i(3),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "ddb", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("bold(ddot(<>)<>)_<>", {
			i(1),
			i(2),
			i(3),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "dot", snippetType = "autosnippet" },
		fmta("dot(<>)", {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "(%a)dd", wordTrig = false, regTrig = true, snippetType = "autosnippet", priority = 4000 },
		fmta("ddot(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "dd", snippetType = "autosnippet", priority = 400 },
		fmta("ddot(<>)", {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "hat", snippetType = "autosnippet" },
		fmta("hat(<>)", {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "(%a)hat", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("hat(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "to", snippetType = "autosnippet" },
		fmta("arrow(<>)", {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "mid", snippetType = "autosnippet" },
		fmta("mod(<>)", {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "([%w])inv", snippetType = "autosnippet", regTrig = true, wordTrig = false },
		fmta([[<>^(-1)]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "([%w])conj", snippetType = "autosnippet", regTrig = true, wordTrig = false },
		fmta([[<>^(*)]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "div", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("(dif "), i(1), t(" )/(dif "), i(2), t(" )") }),
			sn(nil, { t("(dif^2 "), i(1), t(" )/(dif "), i(2), t("^2)") }),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "piv", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("(diff "), i(1), t(" )/(diff "), i(2), t(" )") }),
			sn(nil, { t("(diff^2 "), i(1), t(" )/(diff "), i(2), t("^2)") }),
			sn(nil, { t("(diff^2 "), i(1), t(" )/("), t("diff "), i(2), t(" diff "), i(3), t(" )") }),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "mat", snippetType = "autosnippet" },
		fmta(
			[[
            mat(
            <>
            )
            <>
        ]],
			{ i(1), i(2) }
		),
		{ condition = typst.in_mathzone }
	),
}
