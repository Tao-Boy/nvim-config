local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local tex = require("utils.latex")

return {
	s(
		{ trig = "bra", wordTrig = false, snippetType = "autosnippet", priority = 4000, hidden = true },
		fmta([[\bra{<>}]], {
			i(1),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "ket", wordTrig = false, snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[\ket{<>}]], {
			i(1),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "bk", snippetType = "autosnippet", hidden = true },
		c(1, {
			sn(nil, { t("\\braket{"), i(1), t("}{"), i(2), t("}") }),
			sn(nil, { t("\\mel{"), i(1), t("}{"), i(2), t("}{"), i(3), t("}") }),
		}),
		{ condition = tex.in_mathzone }
	),
}
