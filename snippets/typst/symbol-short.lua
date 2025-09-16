local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local typst = require("utils.typst")

return {
	s({ trig = "...", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("dots"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "c.", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("dot"),
	}, { condition = typst.in_mathzone }),
	-- s({ trig = "\\cdot.", wordTrig = true, snippetType = "autosnippet" }, {
	--   t("\\cdots"),
	-- }, { condition = tex.in_mathzone }),
	s({ trig = "v.", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("dots.v"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "nin", wordTrig = true, snippetType = "autosnippet", priority = 3000, hidden = true }, {
		t("in.not"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "aa", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("forall"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "ee", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("exists"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "to", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("->"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "sr", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("^2"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "cb", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("^3"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "inv", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("^(-1)"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "**", wordTrig = false, snippetType = "autosnippet", hidden = true }, {
		t("^*"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "<>", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("diamond"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "+-", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("plus.minus"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "-+", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("minus.plus"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "cap", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("inter"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "cup", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("union"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "sub", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("subset"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "oo", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("infinity"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "dag", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("^dagger"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "xx", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("times"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "cir", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("circle"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "eqv", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("equiv"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "ox", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("times.circle"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "o+", wordTrig = true, snippetType = "autosnippet", hidden = true }, {
		t("plus.circle"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "emp", snippetType = "autosnippet", priority = 2000, hidden = true }, {
		t("emptyset"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";n", snippetType = "autosnippet", hidden = true }, {
		t("nabla"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "dd", snippetType = "autosnippet", hidden = true }, { t("dif") }, { condition = typst.in_mathzone }),
	s(
		{ trig = "jk", wordTrig = false, snippetType = "autosnippet", hidden = true },
		fmta(
			[[
    _(<>)
    ]],
			{ i(1) }
		),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "kj", wordTrig = false, snippetType = "autosnippet", hidden = true },
		fmta(
			[[
    ^(<>)
    ]],
			{ i(1) }
		),
		{ condition = typst.in_mathzone }
	),
}
