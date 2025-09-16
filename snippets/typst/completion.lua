local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local typst = require("utils.typst")

ls.add_snippets("typst", {
	s(
		{ trig = "([%a%)%]%}])(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet", hidden = true },
		fmta("<>_<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "([%a%)%]%}])_(%d)(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet", hidden = true },
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
		{ condition = typst.in_mathzone }
	),
	s(
		{
			trig = "([%a%)%]%}])(%a)%2",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			priority = 100,
			hidden = true,
		},
		fmta("<>_<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{
			trig = "([%a%)%]%}])_(%a)(%a)%3",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			priority = 2000,
			hidden = true,
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
		{ condition = typst.in_mathzone }
	),
	s(
		{
			trig = "(%d+)/",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			priority = 100,
			hidden = true,
		},
		fmta("(<>)/(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{
			trig = "(%a+)/",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			priority = 100,
			hidden = true,
		},
		fmta("(<>)/(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{
			trig = "(%a+%(%a+%))/",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			priority = 3000,
			hidden = true,
		},
		fmta("(<>)(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "lim", regTrig = true, wordTrig = true, snippetType = "autosnippet", hidden = true },
		fmta(
			[[
        lim_(<> arrow <>) 
      ]],
			{
				i(1),
				i(2, "infinity"),
			}
		),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "lsup", regTrig = true, wordTrig = true, snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[limsup_(<>)]], {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "linf", regTrig = true, wordTrig = true, snippetType = "autosnippet", hidden = true },
		fmta([[liminf_(<>)]], {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "sum", snippetType = "autosnippet", hidden = true },
		c(1, {
			sn(nil, { t("sum_("), i(1), t(") ") }),
			sn(nil, { t("sum_("), i(1), t(")^("), i(2), t(") ") }),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "par", snippetType = "autosnippet", hidden = true },
		c(1, {
			sn(nil, { t("(partial "), i(1), t(" ) / (partial "), i(2), t(" )") }),
			sn(nil, { t("(partial^2 "), i(1), t(" ) / (partial "), i(2), t("^2 )") }),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "div", snippetType = "autosnippet", hidden = true },
		c(1, {
			sn(nil, { t("(dif "), i(1), t(" ) / (dif "), i(2), t(" )") }),
			sn(nil, { t("(dif^2 "), i(1), t(" ) / (dif "), i(2), t("^2 )") }),
		}),
		{ condition = typst.in_mathzone }
	),

	s(
		{ trig = "pd", snippetType = "autosnippet", hidden = true },
		c(1, {
			sn(nil, { t("product_("), i(1), t(") ") }),
			sn(nil, { t("product_("), i(1), t(")^("), i(2), t(") ") }),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "bot", regTrig = true, wordTrig = true, snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[times.circle.big_(<>)^(<>)]], {
			i(1),
			i(2),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "bcap", regTrig = true, wordTrig = true, snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[inter.big_(<>)^(<>)]], {
			i(1),
			i(2),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "bcup", regTrig = true, wordTrig = true, snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[union.big_(<>)^(<>)]], {
			i(1),
			i(2),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "int", regTrig = true, wordTrig = true, snippetType = "autosnippet", hidden = true },
		fmta([[integral_(<>)^(<>) <> dif <>]], {
			i(1),
			i(2),
			i(3),
			i(4),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "oint", regTrig = true, wordTrig = true, snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[integral.cont_(<>) <> dif <>]], {
			i(1),
			i(2),
			i(3),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "2int", regTrig = true, wordTrig = true, snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[integral_(<>)^(<>)integral_(<>)^(<>) <> dif <> dif <>]], {
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
		{ trig = "iint", regTrig = true, wordTrig = true, snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[integral.double_(<>) <> dif <>]], {
			i(1, "S"),
			i(2),
			i(3),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{
			trig = "iiont",
			regTrig = true,
			wordTrig = true,
			snippetType = "autosnippet",
			priority = 2000,
			hidden = true,
		},
		fmta([[integral.surf_{<>} <> dif <>]], {
			i(1, "S"),
			i(2),
			i(3),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "lint", regTrig = true, wordTrig = true, snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[integral_(- infinity)^(+ infinity) <> dif <>]], {
			i(1),
			i(2),
		}),
		{ condition = typst.in_mathzone }
	),
})
