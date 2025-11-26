local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local tex = require("utils.latex")

return {
	s({ trig = "...", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\dots"),
	}, { condition = tex.in_latex }),
	s({ trig = "c.", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\cdot"),
	}, { condition = tex.in_latex }),
	-- s({ trig = "\\cdot.", wordTrig = false, snippetType = "autosnippet" }, {
	--   t("\\cdots"),
	-- }, { condition = tex.in_latex }),
	s({ trig = "v.", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\vdot"),
	}, { condition = tex.in_latex }),
	s({ trig = "inn", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\in"),
	}, { condition = tex.in_latex }),
	s({ trig = "nin", wordTrig = false, snippetType = "autosnippet", priority = 3000, hidden = true }, {
		t("\\not\\in"),
	}, { condition = tex.in_latex }),
	s({ trig = "aa", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\forall"),
	}, { condition = tex.in_latex }),
	s({ trig = "ee", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\exists"),
	}, { condition = tex.in_latex }),
	s({ trig = "!=", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\neq"),
	}, { condition = tex.in_latex }),
	s({ trig = "==", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("&="),
	}, { condition = tex.in_latex }),
	s({ trig = "~=", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\approx"),
	}, { condition = tex.in_latex }),
	s({ trig = "~~", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\sim"),
	}, { condition = tex.in_latex }),
	s({ trig = ">=", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\geq"),
	}, { condition = tex.in_latex }),
	s({ trig = "<=", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\leq"),
	}, { condition = tex.in_latex }),
	s({ trig = ">>", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\gg"),
	}, { condition = tex.in_latex }),
	s({ trig = "<<", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\ll"),
	}, { condition = tex.in_latex }),
	s({ trig = "cp", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\cp"),
	}, { condition = tex.in_latex }),
	s({ trig = "get", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\gets"),
	}, { condition = tex.in_latex }),
	s({ trig = "to", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\to"),
	}, { condition = tex.in_latex }),
	s({ trig = "mid", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\mid"),
	}, { condition = tex.in_latex }),
	s({ trig = "nmid", wordTrig = false, snippetType = "autosnippet", priority = 2000, hidden = true }, {
		t("\\nmid"),
	}, { condition = tex.in_latex }),
	s({ trig = "sr", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("^2"),
	}, { condition = tex.in_latex }),
	s({ trig = "cb", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("^3"),
	}, { condition = tex.in_latex }),
	s({ trig = "inv", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("^{-1}"),
	}, { condition = tex.in_latex }),
	s({ trig = "**", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("^*"),
	}, { condition = tex.in_latex }),
	s({ trig = "<>", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\diamond"),
	}, { condition = tex.in_latex }),
	s({ trig = "+-", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\pm"),
	}, { condition = tex.in_latex }),
	s({ trig = "-+", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\mp"),
	}, { condition = tex.in_latex }),
	s({ trig = "cap", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\cap"),
	}, { condition = tex.in_latex }),
	s({ trig = "cup", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\cup"),
	}, { condition = tex.in_latex }),
	s({ trig = "sub", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\subseteq"),
	}, { condition = tex.in_latex }),
	s({ trig = "oo", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\infty"),
	}, { condition = tex.in_latex }),
	s({ trig = "dag", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("^\\dagger"),
	}, { condition = tex.in_latex }),
	s({ trig = "ss", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\star"),
	}, { condition = tex.in_latex }),
	s({ trig = "xx", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\times"),
	}, { condition = tex.in_latex }),
	s({ trig = "=>", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\implies"),
	}, { condition = tex.in_latex }),
	s({ trig = "llr", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\longleftrightarrow"),
	}, { condition = tex.in_latex }),
	s({ trig = "up", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\uparrow"),
	}, { condition = tex.in_latex }),
	s({ trig = "cir", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\circ"),
	}, { condition = tex.in_latex }),
	s({ trig = "hbar", wordTrig = false, snippetType = "autosnippet", priority = 3000, hidden = true }, {
		t("\\hbar"),
	}, { condition = tex.in_latex }),
	s({ trig = "eqv", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\equiv"),
	}, { condition = tex.in_latex }),
	s({ trig = "##", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\#"),
	}, { condition = tex.in_latex }),
	s({ trig = "ell", wordTrig = false, snippetType = "autosnippet", priority = 2000, hidden = true }, {
		t("\\ell"),
	}, { condition = tex.in_latex }),
	s({ trig = "ox", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\otimes"),
	}, { condition = tex.in_latex }),
	s({ trig = "o+", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("\\oplus"),
	}, { condition = tex.in_latex }),
	s({ trig = "not", wordTrig = false, snippetType = "autosnippet", priority = 2000, hidden = true }, {
		t("\\not"),
	}, { condition = tex.in_latex }),
	s({ trig = "land", snippetType = "autosnippet", hidden = true }, {
		t("\\land"),
	}, { condition = tex.in_latex }),
	s({ trig = "lor", snippetType = "autosnippet", hidden = true }, {
		t("\\lor"),
	}, { condition = tex.in_latex }),
	s({ trig = "\\tri", snippetType = "autosnippet", hidden = true }, {
		t("\\triangle"),
	}, { condition = tex.in_latex }),
	s({ trig = "emp", snippetType = "autosnippet", priority = 2000, hidden = true }, {
		t("\\emptyset"),
	}, { condition = tex.in_latex }),
	s({ trig = "set", snippetType = "autosnippet", priority = 2000, hidden = true }, {
		t("\\{ "),
		i(1),
		t(" \\}"),
	}, { condition = tex.in_latex }),
	-- s({ trig = "po", snippetType = "autosnippet" }, {
	--   t("\\propto"),
	-- }, { condition = tex.in_latex }),
	s({ trig = "neg", snippetType = "autosnippet", hidden = true }, {
		t("\\neg"),
	}, { condition = tex.in_latex }),
	s({ trig = ";n", snippetType = "autosnippet", hidden = true }, {
		t("\\nabla"),
	}, { condition = tex.in_latex }),
	s(
		{ trig = "jk", wordTrig = false, snippetType = "autosnippet", hidden = true },
		fmta(
			[[
    _{<>}
    ]],
			{ i(1) }
		),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "kj", wordTrig = false, snippetType = "autosnippet", hidden = true },
		fmta(
			[[
    ^{<>}
    ]],
			{ i(1) }
		),
		{ condition = tex.in_latex }
	),
}
