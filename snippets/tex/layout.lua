local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local tex = require("utils.latex")

return {
	-- Inline Math
	s({
		trig = "ii",
		snippetType = "autosnippet",
		hidden = true,
	}, fmta([[ \(<>\) ]], { i(1) }), { condition = tex.in_text }),

	-- Display Math
	s(
		{
			trig = "dd",
			snippetType = "autosnippet",
			hidden = true,
		},
		fmta(
			[[
		\[
			<>
		\]
	]],
			{ i(1) }
		),
		{ condition = tex.in_text }
	),

	-- 通用环境
	s(
		{
			trig = "beg",
			snippetType = "autosnippet",
			hidden = true,
		},
		fmta(
			[[
		\begin{<>}[<>]
			<>
		\end{<>}
	]],
			{
				i(1),
				i(2),
				i(0),
				rep(1),
			}
		),
		{ condition = line_begin }
	),

	-- 参考文献
	s(
		{
			trig = "bib",
			snippetType = "autosnippet",
			hidden = true,
		},
		fmta(
			[[
		\begin{thebibliography}
			<>
		\end{thebibliography}
	]],
			{ i(0) }
		),
		{ condition = line_begin }
	),

	-- 方程环境
	s(
		{
			trig = "equ",
			snippetType = "autosnippet",
			hidden = true,
		},
		fmta(
			[[
		\begin{equation}
			<>
		\end{equation}
	]],
			{ i(1) }
		),
		{ condition = tex.in_text * line_begin }
	),

	-- 分段函数
	s(
		{
			trig = "case",
			snippetType = "autosnippet",
			hidden = true,
		},
		fmta(
			[[
		\begin{cases}
			<>
		\end{cases}
	]],
			{ i(0) }
		),
		{ condition = tex.in_mathzone }
	),

	-- 列表
	s(
		{
			trig = "bit",
			snippetType = "autosnippet",
			hidden = true,
		},
		fmta(
			[[
		\begin{itemize}
			\item <>
		\end{itemize}
	]],
			{ i(0) }
		),
		{ condition = line_begin }
	),

	-- 章节
	s({
		trig = "cha",
		hidden = true,
		snippetType = "autosnippet",
	}, fmta([[ \chapter{<>} ]], { i(1) }), { condition = line_begin }),

	s({
		trig = "sec",
		hidden = true,
		snippetType = "autosnippet",
	}, fmta([[ \section{<>} ]], { i(1) }), { condition = tex.in_text * line_begin }),

	s({
		trig = "ssec",
		hidden = true,
		snippetType = "autosnippet",
	}, fmta([[ \subsection{<>} ]], { i(1) }), { condition = line_begin }),
}
