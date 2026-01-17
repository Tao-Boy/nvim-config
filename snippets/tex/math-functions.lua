local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local f = ls.function_node
local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local tex = require("utils.latex")

return {
	-- 三角函数
	s({ trig = "sin", snippetType = "autosnippet", hidden = true }, t("\\sin "), { condition = tex.in_mathzone }),

	s({ trig = "asin", snippetType = "autosnippet", hidden = true }, t("\\arcsin "), { condition = tex.in_mathzone }),

	s({ trig = "cos", snippetType = "autosnippet", hidden = true }, t("\\cos "), { condition = tex.in_mathzone }),

	s({ trig = "acos", snippetType = "autosnippet", hidden = true }, t("\\arccos "), { condition = tex.in_mathzone }),

	s({ trig = "tan", snippetType = "autosnippet", hidden = true }, t("\\tan "), { condition = tex.in_mathzone }),

	s({ trig = "atan", snippetType = "autosnippet", hidden = true }, t("\\arctan "), { condition = tex.in_mathzone }),

	s({ trig = "cot", snippetType = "autosnippet", hidden = true }, t("\\cot "), { condition = tex.in_mathzone }),

	s({ trig = "acot", snippetType = "autosnippet", hidden = true }, t("\\arccot "), { condition = tex.in_mathzone }),

	s({ trig = "csc", snippetType = "autosnippet", hidden = true }, t("\\csc "), { condition = tex.in_mathzone }),

	-- 其他函数
	s({ trig = "log", snippetType = "autosnippet", hidden = true }, t("\\log "), { condition = tex.in_mathzone }),

	s({ trig = "ln", snippetType = "autosnippet", hidden = true }, t("\\ln"), { condition = tex.in_mathzone }),

	s({ trig = "exp", snippetType = "autosnippet", hidden = true }, t("\\exp"), { condition = tex.in_mathzone }),

	-- 优化函数
	s({ trig = "min", snippetType = "autosnippet", hidden = true }, t("\\min"), { condition = tex.in_mathzone }),

	s({ trig = "max", snippetType = "autosnippet", hidden = true }, t("\\max"), { condition = tex.in_mathzone }),

	s(
		{ trig = "sup", snippetType = "autosnippet", priority = 2000, hidden = true },
		t("\\sup"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "inf", snippetType = "autosnippet", priority = 2000, hidden = true },
		t("\\inf"),
		{ condition = tex.in_mathzone }
	),

	-- 极限
	s(
		{ trig = "lim", snippetType = "autosnippet", hidden = true },
		fmta([[\lim_{<> \to <>} ]], { i(1), i(2, "\\infty") }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "lsup", snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[\limsup_{<>}]], { i(1) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "linf", snippetType = "autosnippet", hidden = true },
		fmta([[\liminf_{<>}]], { i(1) }),
		{ condition = tex.in_mathzone }
	),

	-- 符号装饰
	s(
		{ trig = "bar", snippetType = "autosnippet", hidden = true },
		fmta("\\bar{<>}", { i(1) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{
			trig = "(%a)bar",
			wordTrig = false,
			regTrig = true,
			snippetType = "autosnippet",
			hidden = true,
		},
		fmta("\\bar{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "hat", snippetType = "autosnippet", hidden = true },
		fmta([[\hat{<>}]], { i(1) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "vec", snippetType = "autosnippet", hidden = true },
		fmta([[\vec{<>}]], { i(1) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "dot", snippetType = "autosnippet", hidden = true },
		fmta([[\dot{<>}]], { i(1) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "doo", snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[\ddot{<>}]], { i(1) }),
		{ condition = tex.in_mathzone }
	),

	-- 波浪线
	s(
		{
			trig = "(\\%.+)~",
			wordTrig = false,
			regTrig = true,
			snippetType = "autosnippet",
			hidden = true,
		},
		fmta([[\tilde{<>}]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_mathzone }
	),

	s(
		{
			trig = "(%a)~",
			wordTrig = false,
			regTrig = true,
			snippetType = "autosnippet",
			hidden = true,
		},
		fmta([[\tilde{<>}]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_mathzone }
	),

	-- 括号和绝对值
	s({
		trig = "md",
		wordTrig = false,
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\left| <> \right|]], { i(1) }), { condition = tex.in_mathzone }),

	s({
		trig = "lrs",
		wordTrig = false,
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\left( <> \right)]], { i(1) }), { condition = tex.in_mathzone }),

	s({
		trig = "lrm",
		wordTrig = false,
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[ \left[ <> \right] ]], { i(1) }), { condition = tex.in_mathzone }),

	s({
		trig = "lrb",
		wordTrig = false,
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\left\{ <> \right\}]], { i(1) }), { condition = tex.in_mathzone }),

	-- 其他数学操作
	s({
		trig = "//",
		wordTrig = false,
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\frac{<>}{<>}]], { i(1), i(2) }), { condition = tex.in_mathzone }),

	s({ trig = "dd", snippetType = "autosnippet", hidden = true }, t("\\dif"), { condition = tex.in_mathzone }),

	s(
		{
			trig = "sq",
			wordTrig = false,
			snippetType = "autosnippet",
			hidden = true,
		},
		c(1, {
			sn(nil, { t("\\sqrt{"), i(1), t("}") }),
			sn(nil, { t("\\sqrt["), i(1), t("]{"), i(2), t("}") }),
		}),
		{ condition = tex.in_mathzone }
	),

	s({
		trig = "mod",
		wordTrig = false,
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\mod{<>}]], { i(1) }), { condition = tex.in_mathzone }),
}
