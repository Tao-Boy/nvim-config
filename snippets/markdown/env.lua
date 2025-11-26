local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("utils.latex")

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

ls.add_snippets("markdown", {
	s(
		{ trig = "ii", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      $<>$<>
      ]],
			{
				i(1),
				i(0),
			}
		),
		{ condition = tex.not_in_latex }
	),
	s(
		{ trig = "dd", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      $$
        <>
      $$
      <>
      ]],
			{
				i(1),
				i(0),
			}
		),
		{ condition = tex.not_in_latex }
	),
	s(
		{ trig = "beg", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      \begin{<>}
        <>
      \end{<>}
      <>
      ]],
			{
				i(1),
				i(2),
				rep(1),
				i(0),
			}
		),
		{
			condition = line_begin,
		}
	),

	s(
		{ trig = "equ", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      \begin{equation}
        <>
      \end{equation}
      <>
      ]],
			{
				i(1),
				i(0),
			}
		),
		{
			condition = tex.not_in_latex * line_begin,
		}
	),
	-- 方程组
	s(
		{ trig = "case", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      \begin{cases}
        <>
      \end{cases}
      ]],
			{
				i(0),
			}
		),
		{
			condition = tex.in_mathzone,
		}
	),
})
