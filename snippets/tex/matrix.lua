local ls = require("luasnip")
local t = ls.text_node
local s = ls.snippet
local d = ls.dynamic_node
local i = ls.insert_node
local sn = ls.snippet_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local tex = require("utils.latex")

ls.add_snippets("tex", {
	s(
		{ trig = "bmat", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      \begin{bmatrix}
        <>
      \end{bmatrix}
      ]],
			{
				i(1),
			}
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "Bmat", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      \begin{Bmatrix}
        <>
      \end{Bmatrix}
      ]],
			{
				i(1),
			}
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "pmat", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
	     \begin{pmatrix}
	       <>
	     \end{pmatrix}
	     ]],
			{
				i(1),
			}
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "Vmat", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      \begin{Vmatrix}
        <>
      \end{Vmatrix}
      ]],
			{
				i(1),
			}
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "Bmat", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      \Bmat{<>}
      ]],
			{
				i(1),
			}
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "vmat", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      \vmat{<>}
      ]],
			{
				i(1),
			}
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "Vmat", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      \Vmat{<>}
      ]],
			{
				i(1),
			}
		),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "II3", snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta(
			[[
      \begin{bmatrix}
        1 & & \\
        & 1 & \\
        & & 1 \\
      \end{bmatrix}
      ]],
			{}
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "II4", snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta(
			[[
      \begin{bmatrix}
        1 & & & \\
        & 1 & & \\
        & & 1 & \\
        & & & 1 \\
      \end{bmatrix}
      ]],
			{}
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "II5", snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta(
			[[
      \begin{bmatrix}
        1 & & & &\\
        & 1 & & &\\
        & & 1 & &\\
        & & & 1 &\\
        & & & & 1\\
      \end{bmatrix}
      ]],
			{}
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "II6", snippetType = "autosnippet", priority = 2000, hidden = true },
		fmta(
			[[
      \begin{bmatrix}
        1 & & & & &\\
        & 1 & & & &\\
        & & 1 & & &\\
        & & & 1 & &\\
        & & & & 1 &\\
        & & & & & 1\\
      \end{bmatrix}
      ]],
			{}
		),
		{ condition = tex.in_mathzone }
	),
})
