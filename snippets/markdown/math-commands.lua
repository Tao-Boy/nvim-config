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
	s({ trig = "sin", snippetType = "autosnippet", hidden = true }, {
		t("\\sin "),
	}, { condition = tex.in_latex }),
	s({ trig = "asin", snippetType = "autosnippet", hidden = true }, {
		t("\\arcsin "),
	}, { condition = tex.in_latex }),
	s({ trig = "cos", snippetType = "autosnippet", hidden = true }, {
		t("\\cos "),
	}, { condition = tex.in_latex }),
	s({ trig = "acos", snippetType = "autosnippet", hidden = true }, {
		t("\\arccos "),
	}, { condition = tex.in_latex }),
	s({ trig = "tan", snippetType = "autosnippet", hidden = true }, {
		t("\\tan "),
	}, { condition = tex.in_latex }),
	s({ trig = "atan", snippetType = "autosnippet", hidden = true }, {
		t("\\arctan "),
	}, { condition = tex.in_latex }),
	s({ trig = "cot", snippetType = "autosnippet", hidden = true }, {
		t("\\cot "),
	}, { condition = tex.in_latex }),
	s({ trig = "acot", snippetType = "autosnippet", hidden = true }, {
		t("\\arccot "),
	}, { condition = tex.in_latex }),
	s({ trig = "csc", snippetType = "autosnippet", hidden = true }, {
		t("\\csc "),
	}, { condition = tex.in_latex }),
	s({ trig = "acsc", snippetType = "autosnippet", hidden = true }, {
		t("\\arccsc "),
	}, { condition = tex.in_latex }),
	s({ trig = "asec", snippetType = "autosnippet", hidden = true }, {
		t("\\arcsec "),
	}, { condition = tex.in_latex }),
	s({ trig = "log", snippetType = "autosnippet", hidden = true }, {
		t("\\log "),
	}, { condition = tex.in_latex }),
	s({ trig = "ln", snippetType = "autosnippet", hidden = true }, {
		t("\\ln"),
	}, { condition = tex.in_latex }),
	s({ trig = "exp", snippetType = "autosnippet", hidden = true }, {
		t("\\exp"),
	}, { condition = tex.in_latex }),
	-- s({ trig = "grad", snippetType = "autosnippet" }, {
	--   t("\\grad"),
	-- }, { condition = tex.in_latex }),
	-- s({ trig = "curl", snippetType = "autosnippet" }, {
	--   t("\\curl"),
	-- }, { condition = tex.in_latex }),
	-- s({ trig = "div", snippetType = "autosnippet" }, {
	--   t("\\div"),
	-- }, { condition = tex.in_latex }),
	-- s({ trig = "lap", snippetType = "autosnippet" }, {
	--   t("\\laplacian"),
	-- }, { condition = tex.in_latex }),
	-- s({ trig = "bbr", snippetType = "autosnippet" }, {
	--   t("\\mathbb{R}"),
	-- }, { condition = tex.in_latex }),
	-- s({ trig = "bbq", snippetType = "autosnippet" }, {
	--   t("\\mathbb{Q}"),
	-- }, { condition = tex.in_latex }),
	-- s({ trig = "bbh", snippetType = "autosnippet" }, {
	--   t("\\mathbb{H}"),
	-- }, { condition = tex.in_latex }),
	-- s({ trig = "bbc", snippetType = "autosnippet" }, {
	--   t("\\mathbb{C}"),
	-- }, { condition = tex.in_latex }),
	-- s({ trig = "bbz", snippetType = "autosnippet" }, {
	--   t("\\mathbb{Z}"),
	-- }, { condition = tex.in_latex }),
	-- s({ trig = "bbn", snippetType = "autosnippet" }, {
	--   t("\\mathbb{N}"),
	-- }, { condition = tex.in_latex }),
	-- s({ trig = "bb1", snippetType = "autosnippet", priority = 2000 }, {
	--   t("\\mathbbm{1}"),
	-- }, { condition = tex.in_latex }),
	-- s({ trig = "bbe", snippetType = "autosnippet" }, {
	--   t("\\mathbb{E}"),
	-- }, { condition = tex.in_latex }),
	-- s(
	--   { trig = "bb(%w)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
	--   fmta("\\mathbb{<>}", {
	--     f(function(_, snip)
	--       return string.upper(snip.captures[1])
	--     end),
	--   }),
	--   { condition = tex.in_latex }
	-- ),
	s(
		{ trig = "bb(%w)", wordTrig = false, regTrig = true, snippetType = "autosnippet", hidden = true },
		fmta("\\mathbb{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_latex }
	),
	s({ trig = "exp", snippetType = "autosnippet", hidden = true }, {
		t("\\exp"),
	}, { condition = tex.in_latex }),
	s({ trig = "cv", snippetType = "autosnippet", hidden = true }, fmta("\\conv", {}), { condition = tex.in_latex }),
	s(
		{ trig = "bar", snippetType = "autosnippet", hidden = true },
		fmta("\\bar{<>}", {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "(%a)bar", wordTrig = false, regTrig = true, snippetType = "autosnippet", hidden = true },
		fmta("\\bar{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "ob", snippetType = "autosnippet", hidden = true },
		fmta([[\overbrace{<>}^{<>}]], {
			i(1),
			i(2),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "td", snippetType = "autosnippet", hidden = true },
		fmta([[\ttlde{<>}]], {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "(\\%a+)~", wordTrig = false, regTrig = true, snippetType = "autosnippet", hidden = true },
		fmta([[\tilde{<>}]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "(%a)~", wordTrig = false, regTrig = true, snippetType = "autosnippet", hidden = true },
		fmta([[\tilde{<>}]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "dot", snippetType = "autosnippet", hidden = true },
		fmta([[\dot{<>}]], {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "doo", snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta([[\ddot{<>}]], {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "hat", snippetType = "autosnippet", hidden = true },
		fmta([[\hat{<>}]], {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "vec", snippetType = "autosnippet", hidden = true },
		fmta([[\vec{<>}]], {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "->", snippetType = "autosnippet", hidden = true },
		fmta([[\xlongrightarrow{<>}]], {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "<-", snippetType = "autosnippet", hidden = true },
		fmta([[\xlongleftarrow{<>}]], {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "--", snippetType = "autosnippet", hidden = true },
		{ t("\\longleftrightarrow") },
		{ condition = tex.in_latex }
	),
	-- s(
	--   { trig = "gt", snippetType = "autosnippet" },
	--   fmta("\\gt{<>}", {
	--     i(1),
	--   }),
	--   { condition = tex.in_latex }
	-- ),
	s({ trig = "min", snippetType = "autosnippet", hidden = true }, { t("\\min") }, { condition = tex.in_latex }),
	s({ trig = "max", snippetType = "autosnippet", hidden = true }, { t("\\max") }, { condition = tex.in_latex }),
	-- s(
	--   { trig = "amin", snippetType = "autosnippet" },
	--   fmta("\\argmin_{<>}", {
	--     i(1),
	--   }),
	--   { condition = tex.in_latex }
	-- ),
	-- s(
	--   { trig = "amax", snippetType = "autosnippet" },
	--   fmta("\\argmax_{<>}", {
	--     i(1),
	--   }),
	--   { condition = tex.in_latex }
	-- ),
	s(
		{ trig = "sup", snippetType = "autosnippet", priority = 2000, hidden = true },
		{ t("\\sup") },
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "inf", snippetType = "autosnippet", priority = 2000, hidden = true },
		{ t("\\inf") },
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "//", wordTrig = false, snippetType = "autosnippet", hidden = true },
		fmta([[\frac{<>}{<>}]], {
			i(1),
			i(2),
		}),
		{ condition = tex.in_latex }
	),
	s({ trig = "dd", snippetType = "autosnippet", hidden = true }, { t("\\dif") }, { condition = tex.in_latex }),
	s(
		{ trig = "sq", wordTrig = false, snippetType = "autosnippet", hidden = true },
		c(1, { sn(nil, { t("\\sqrt{"), i(1), t("}") }), sn(nil, { t("\\sqrt["), i(1), t("]{"), i(2), t("}") }) }),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "md", wordTrig = false, snippetType = "autosnippet", hidden = true },
		fmta([[\left| <> \right|]], {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "lrs", wordTrig = false, snippetType = "autosnippet", hidden = true },
		fmta([[\left( <> \right)]], {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "lrm", wordTrig = false, snippetType = "autosnippet", hidden = true },
		fmta([[ \left[ <> \right] ]], {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "lrb", wordTrig = false, snippetType = "autosnippet", hidden = true },
		fmta([[\left\{ <> \right\}]], {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "mod", wordTrig = false, snippetType = "autosnippet", hidden = true },
		fmta([[\mod{<>}]], {
			i(1),
		}),
		{ condition = tex.in_latex }
	),
	s(
		{ trig = "deg", wordTrig = false, snippetType = "autosnippet", priority = 2000, hidden = true },
		{ t("\\degree") },
		{ condition = tex.in_latex }
	),
}
