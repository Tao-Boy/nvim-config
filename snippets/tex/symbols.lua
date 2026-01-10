local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local tex = require("utils.latex")

return {
	-- 基本符号
	s(
		{ trig = "...", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\dots"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "c.", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\cdot"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "v.", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\vdots"),
		{ condition = tex.in_mathzone }
	),

	-- 关系符号
	s(
		{ trig = "==", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("&="),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "!=", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\neq"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "~=", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\approx"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "~~", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\sim"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = ">=", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\geq"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "<=", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\leq"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = ">>", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\gg"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "<<", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\ll"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "eqv", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\equiv"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "=>", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\implies"),
		{ condition = tex.in_mathzone }
	),

	-- 箭头
	s(
		{ trig = "to", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\to"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "get", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\gets"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "up", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\uparrow"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "llr", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\longleftrightarrow"),
		{ condition = tex.in_mathzone }
	),

	-- 集合符号
	s(
		{ trig = "inn", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\in"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "nin", wordTrig = false, snippetType = "autosnippet", priority = 3000, hidden = true },
		t("\\not\\in"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "sub", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\subseteq"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "cap", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\cap"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "cup", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\cup"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "set", snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta("\\{ <> \\}", { i(1) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "emp", snippetType = "autosnippet", priority = 2000, hidden = true },
		t("\\emptyset"),
		{ condition = tex.in_mathzone }
	),

	-- 逻辑符号
	s(
		{ trig = "aa", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\forall"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "ee", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\exists"),
		{ condition = tex.in_mathzone }
	),

	s({ trig = "land", snippetType = "autosnippet", hidden = true }, t("\\land"), { condition = tex.in_mathzone }),

	s({ trig = "lor", snippetType = "autosnippet", hidden = true }, t("\\lor"), { condition = tex.in_mathzone }),

	s({ trig = "neg", snippetType = "autosnippet", hidden = true }, t("\\neg"), { condition = tex.in_mathzone }),

	-- 运算符
	s(
		{ trig = "+-", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\pm"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "-+", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\mp"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "xx", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\times"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "cir", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\circ"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "ox", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\otimes"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "o+", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\oplus"),
		{ condition = tex.in_mathzone }
	),

	-- 上标和特殊符号
	s(
		{ trig = "sr", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("^2"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "cb", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("^3"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "inv", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("^{-1}"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "**", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("^*"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "dag", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("^\\dagger"),
		{ condition = tex.in_mathzone }
	),

	-- 特殊符号
	s(
		{ trig = "hbar", wordTrig = false, snippetType = "autosnippet", priority = 3000, hidden = true },
		t("\\hbar"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "ell", wordTrig = false, snippetType = "autosnippet", priority = 2000, hidden = true },
		t("\\ell"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "oo", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\infty"),
		{ condition = tex.in_mathzone }
	),

	s({ trig = "tri", snippetType = "autosnippet", hidden = true }, t("\\triangle"), { condition = tex.in_mathzone }),

	s(
		{ trig = "#", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\#"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "<>", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\diamond"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "not", wordTrig = false, snippetType = "autosnippet", priority = 2000, hidden = true },
		t("\\not"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "nmid", wordTrig = false, snippetType = "autosnippet", priority = 2000, hidden = true },
		t("\\nmid"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "ss", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\star"),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "cp", wordTrig = false, snippetType = "autosnippet", hidden = true },
		t("\\cong"),
		{ condition = tex.in_mathzone }
	),

	-- 手动上下标
	s({
		trig = "jk",
		wordTrig = false,
		snippetType = "autosnippet",
		hidden = true,
	}, fmta("_{<>}", { i(1) }), { condition = tex.in_mathzone }),

	s({
		trig = "kj",
		wordTrig = false,
		snippetType = "autosnippet",
		hidden = true,
	}, fmta("^{<>}", { i(1) }), { condition = tex.in_mathzone }),
}
