local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local typst = require("utils.typst")

return {
	s(
		{ trig = "dot", snippetType = "autosnippet", hidden = true },
		fmta([[dot(<>)]], {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "doo", snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[dot.double(<>)]], {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "hat", snippetType = "autosnippet", hidden = true },
		fmta([[hat(<>)]], {
			i(1),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = ",,", wordTrig = false, snippetType = "autosnippet", hidden = true, priority = 5000 },
		fmta([[(<>)/(<>)]], {
			i(1),
			i(2),
		}),
		{ condition = typst.in_mathzone }
	),
	s(
		{ trig = "sq", wordTrig = false, snippetType = "autosnippet", hidden = true },
		c(1, { sn(nil, { t("sqrt("), i(1), t(")") }), sn(nil, { t("root("), i(1), t(",)("), i(2), t(")") }) }),
		{ condition = typst.in_mathzone }
	),
}
