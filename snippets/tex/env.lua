local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("utils.latex")
local get_visual = function(args, parent)
	if #parent.snippet.env.SELECT_RAW > 0 then
		return sn(nil, t(parent.snippet.env.SELECT_RAW))
	else -- If SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

-- 数学定理及其其他的一些环境
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

return {
	s(
		{ trig = "mk", snippetType = "autosnippet" },
		fmta(
			[[
      \(<>\)
      ]],
			{
				i(1),
			}
		),
		{ condition = tex.in_text }
	),
	s(
		{ trig = "dm", snippetType = "autosnippet" },
		fmta(
			[[
      \[
        <>
      \]
      ]],
			{
				i(1),
			}
		),
		{ condition = tex.in_text }
	),
	-- 开始一个环境
	s(
		{ trig = "beg", snippetType = "autosnippet" },
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
	-- 定理
	s(
		{ trig = "bthm", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{theorem}[<>]\label{thm:<>}
        <>
      \end{theorem}
      ]],
			{
				i(1),
				rep(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- 定义
	s(
		{ trig = "bdef", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{definition}[<>]\label{def:<>}
        <>
      \end{definition}
      ]],
			{
				i(1),
				rep(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- 命题
	s(
		{ trig = "bpro", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{proposition}[<>]\label{pro:<>}
        <>
      \end{proposition}
      ]],
			{
				i(1),
				rep(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- 推论
	s(
		{ trig = "bcor", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{corollary}[<>]\label{cor:<>}
        <>
      \end{corollary}
      ]],
			{
				i(1),
				rep(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- 引理
	s(
		{ trig = "blem", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{lemma}[<>]\label{lem:<>}
        <>
      \end{lemma}
      ]],
			{
				i(1),
				rep(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- 公理
	s(
		{ trig = "baxi", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{axiom}[<>]\label{axi:<>}
        <>
      \end{axiom}
      ]],
			{
				i(1),
				rep(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- 假设
	s(
		{ trig = "bpos", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{postulate}[<>]\label{pos:<>}
        <>
      \end{postulate}
      ]],
			{
				i(1),
				rep(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- 举例
	s(
		{ trig = "bexa", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{example}
        <>
      \end{example}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- 问题
	s(
		{ trig = "problem", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{problem}
        <>
      \end{problem}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- 练习
	s(
		{ trig = "bexe", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{exercise}
        <>
      \end{exercise}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- 结论
	s(
		{ trig = "bcls", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{conclusion}
        <>
      \end{conclusion}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- 章节摘要
	s(
		{ trig = "bint", snippetType = "autosnippet", priority = 3000 },
		fmta(
			[[
      \begin{introduction}
        <>
      \end{introduction}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	s(
		{ trig = "bsol", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{solution}
        <>
      \end{solution}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	s(
		{ trig = "bsol", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{solution}
        <>
      \end{solution}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),

	------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------

	-- 参考文献
	s(
		{ trig = "bib", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{thebibliography}
        <>
      \end{thebibliography}
      ]],
			{
				i(0),
			}
		),
		{ condition = line_begin }
	),
	s({ trig = "bib", snippetType = "autosnippet" }, {
		t("\\bibitem"),
	}, { condition = tex.in_bib * line_begin }),

	-- 插入图片
	s(
		{ trig = "bfig", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{figure}[htbp]
        \centering
        \includegraphics[width=0.5\textwidth]{<>}
        \caption{<>}
        \label{fig:<>}
      \end{figure}
      ]],
			{
				i(1),
				i(2),
				rep(2),
			}
		),
		{ condition = line_begin }
	),
	-- 有序列表
	s(
		{ trig = "benu", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{enumerate}[<>]
        \item <>
      \end{enumerate}
      ]],
			{
				i(1, "(a)"),
				i(0),
			}
		),
		{ condition = line_begin }
	),
	-- 代码块
	s(
		{ trig = "blst", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{lstlisting}[language=<>]
        <>
      \end{lstlisting}
      ]],
			{
				i(1),
				i(0),
			}
		),
		{ condition = tex.in_text * line_begin }
	),
	-- 等式
	s(
		{ trig = "equ", snippetType = "autosnippet" },
		fmta(
			[[
            \begin{equation}
                <>
            \end{equation}
      ]],
			{
				i(0),
			}
		),
		{ condition = tex.in_text * line_begin }
	),
	-- 带方框的等式
	s(
		{ trig = "bequ", snippetType = "autosnippet", priority = 3000 },
		fmta(
			[[
            \begin{equation}
                \boxed{
                <>
                }
            \end{equation}
      ]],
			{
				i(0),
			}
		),
		{ condition = tex.in_text * line_begin }
	),
	-- 方程组display
	s(
		{ trig = "dcase", snippetType = "autosnippet", priority = 2000 },
		fmta(
			[[
      \begin{dcases}
        <>
      \end{dcases}
      ]],
			{
				i(0),
			}
		),
		{ condition = tex.in_mathzone }
	),
	-- 方程组
	s(
		{ trig = "case", snippetType = "autosnippet" },
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
		{ condition = tex.in_mathzone }
	),
	-- 对齐公式
	s(
		{ trig = "bal", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{aligned}
        <>
      \end{aligned}
      ]],
			{
				i(0),
			}
		),
		{ condition = tex.in_mathzone }
	),
	-- s(
	--     { trig = "bal", snippetType = "autosnippet", priority = 2000 },
	--     fmta(
	--         [[
	--   \begin{aligned}
	--     <>
	--   \end{aligned}
	--   ]],
	--         {
	--             d(1, get_visual),
	--         }
	--     ),
	--     { condition = tex.in_mathzone }
	-- ),

	-- 无序列表
	s(
		{ trig = "bit", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{itemize}
        \item <>
      \end{itemize}
      ]],
			{
				i(0),
			}
		),
		{ condition = line_begin }
	),
	s({ trig = "im", snippetType = "autosnippet" }, {
		t("\\item"),
	}, { condition = tex.in_item * line_begin }),

	-- 居中
	s(
		{ trig = "bcr", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{center}
        <>
      \end{center}
      ]],
			{
				i(0),
			}
		),
		{ condition = line_begin }
	),

	-- 表格
	s(
		{ trig = "btr", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{tabular}{<>}
        \hline
        <>
        \hline
      \end{tabular}
      ]],
			{
				i(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),

	-- 章
	s(
		{ trig = "cha", snippetType = "autosnippet" },
		fmta(
			[[
        \chapter{<>}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),

	-- 段落
	s(
		{ trig = "par", snippetType = "autosnippet" },
		fmta(
			[[
        \paragraph{<>}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),

	-- 节
	s(
		{ trig = "sec", snippetType = "autosnippet" },
		c(1, { sn(nil, { t("\\section{"), i(1), t("}") }), sn(nil, { t("\\section*{"), i(1), t("}") }) }),
		{ condition = tex.in_text * line_begin }
	),
	s(
		{ trig = "ssec", snippetType = "autosnippet" },
		fmta(
			[[
        \subsection{<>}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	s(
		{ trig = "sss", snippetType = "autosnippet" },
		c(1, { sn(nil, { t("\\subsubsection{"), i(1), t("}") }), sn(nil, { t("\\subsubsection*{"), i(1), t("}") }) }),
		{ condition = tex.in_text * line_begin }
	),
	s(
		{ trig = "sss", snippetType = "autosnippet" },
		fmta(
			[[
        \subsubsection{<>}
      ]],
			{
				i(0),
			}
		),
		{ condition = line_begin * line_begin }
	),
}
