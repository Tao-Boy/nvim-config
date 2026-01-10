local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local tex = require("utils.latex")

return {
	-- 数学字体
	s({
		trig = "msf",
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\mathsf{<>}]], { i(1) }), { condition = tex.in_mathzone }),

	s({
		trig = "mbf",
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\mathbf{<>}]], { i(1) }), { condition = tex.in_mathzone }),

	s({
		trig = "cal",
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\mathcal{<>}]], { i(1) }), { condition = tex.in_mathzone }),

	s({
		trig = "scr",
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\mathscr{<>}]], { i(1) }), { condition = tex.in_mathzone }),

	s({
		trig = "mbb",
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\mathbb{<>}]], { i(1) }), { condition = tex.in_mathzone }),

	s({
		trig = "bm",
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\bm{<>}]], { i(1) }), { condition = tex.in_mathzone }),

	s({
		trig = "mrm",
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\mathrm{<>}]], { i(1) }), { condition = tex.in_mathzone }),

	s({
		trig = "tbf",
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\textbf{<>}]], { i(1) })),

	s({
		trig = "text",
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[\text{<>}]], { i(1) }), { condition = tex.in_mathzone }),

	-- 数学集合
	s({ trig = "RR", snippetType = "autosnippet", hidden = true }, t("\\mathbb{R}"), { condition = tex.in_mathzone }),

	s({ trig = "CC", snippetType = "autosnippet", hidden = true }, t("\\mathbb{C}"), { condition = tex.in_mathzone }),

	s({ trig = "ZZ", snippetType = "autosnippet", hidden = true }, t("\\mathbb{Z}"), { condition = tex.in_mathzone }),

	s({ trig = "NN", snippetType = "autosnippet", hidden = true }, t("\\mathbb{N}"), { condition = tex.in_mathzone }),

	s({ trig = "QQ", snippetType = "autosnippet", hidden = true }, t("\\mathbb{Q}"), { condition = tex.in_mathzone }),

	s({ trig = "FF", snippetType = "autosnippet", hidden = true }, t("\\mathbb{F}"), { condition = tex.in_mathzone }),
}
