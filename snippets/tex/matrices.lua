local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local tex = require("utils.latex")

return {
	-- 各种矩阵环境
	s(
		{
			trig = "pmat",
			snippetType = "autosnippet",
			hidden = true,
		},
		fmta(
			[[
		\begin{pmatrix}
			<>
		\end{pmatrix}
	]],
			{ i(1) }
		),
		{ condition = tex.in_mathzone }
	),

	s(
		{
			trig = "bmat",
			snippetType = "autosnippet",
			hidden = true,
		},
		fmta(
			[[
		\begin{bmatrix}
			<>
		\end{bmatrix}
	]],
			{ i(1) }
		),
		{ condition = tex.in_mathzone }
	),
}
