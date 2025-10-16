local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("utils.latex")
local events = require("luasnip.util.events")

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

ls.add_snippets("tex", {
	s(
		{ trig = ",,", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      \( <> \)
      ]],
			{
				i(1),
			}
		),
		-- callbacks = {
		-- 	[1] = {
		-- 		[events.enter] = function()
		-- 			if vim.g.rime_enabled then
		-- 				vim.cmd("ToggleRime")
		-- 			end
		-- 		end,
		-- 		[events.leave] = function()
		-- 			if not vim.g.rime_enabled then
		-- 				vim.cmd("ToggleRime")
		-- 			end
		-- 		end,
		-- 	},
		-- },
		{ condition = tex.in_text }
	),
	s(
		{ trig = ";;", snippetType = "autosnippet", hidden = true },
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
		-- callbacks = {
		-- 	[1] = {
		-- 		[events.enter] = function()
		-- 			if vim.g.rime_enabled then
		-- 				vim.cmd("ToggleRime")
		-- 			end
		-- 		end,
		-- 		[events.leave] = function()
		-- 			if not vim.g.rime_enabled then
		-- 				vim.cmd("ToggleRime")
		-- 			end
		-- 		end,
		-- 	},
		-- },
		{ condition = tex.in_text }
	),
	-- 开始一个环境
	s(
		{ trig = "beg", snippetType = "autosnippet", hidden = true },
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
		{
			-- callbacks = {
			-- 	[1] = {
			-- 		[events.enter] = function()
			-- 			if vim.g.rime_enabled then
			-- 				vim.cmd("ToggleRime")
			-- 			end
			-- 		end,
			-- 		[events.leave] = function()
			-- 			if not vim.g.rime_enabled then
			-- 				vim.cmd("ToggleRime")
			-- 			end
			-- 		end,
			-- 	},
			-- },
			condition = line_begin,
		}
	),

	------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------

	-- 参考文献
	s(
		{ trig = "bib", snippetType = "autosnippet", hidden = true },
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
	-- 代码块
	s(
		{ trig = "equ", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      \begin{equation}
        <>
      \end{equation}
      ]],
			{
				i(1),
			}
		),
		{
			-- callbacks = {
			-- 	[1] = {
			-- 		[events.enter] = function()
			-- 			if vim.g.rime_enabled then
			-- 				vim.cmd("ToggleRime")
			-- 			end
			-- 		end,
			-- 		[events.leave] = function()
			-- 			if not vim.g.rime_enabled then
			-- 				vim.cmd("ToggleRime")
			-- 			end
			-- 		end,
			-- 	},
			-- },
			condition = tex.in_text * line_begin,
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
			-- callbacks = {
			-- 	[1] = {
			-- 		[events.enter] = function()
			-- 			if vim.g.rime_enabled then
			-- 				vim.cmd("ToggleRime")
			-- 			end
			-- 		end,
			-- 		[events.leave] = function()
			-- 			if not vim.g.rime_enabled then
			-- 				vim.cmd("ToggleRime")
			-- 			end
			-- 		end,
			-- 	},
			-- },
			condition = tex.in_mathzone,
		}
	),

	-- 无序列表
	s(
		{ trig = "bit", snippetType = "autosnippet", hidden = true },
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

	-- 章
	s(
		{ trig = "cha", hidden = true, snippetType = "autosnippet" },
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

	-- 节
	s(
		{ trig = "sec", hidden = true, snippetType = "autosnippet" },
		fmta(
			[[
        \section{<>}
      ]],
			{
				i(1),
			}
		),
		{ condition = tex.in_text * line_begin }
	),
	s(
		{ trig = "ssec", hidden = true, snippetType = "autosnippet" },
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
})
