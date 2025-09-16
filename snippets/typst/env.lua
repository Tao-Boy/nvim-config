local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local typst = require("utils.typst")

ls.add_snippets("typst", {
	s(
		{ trig = "ii", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      $<>$
      ]],
			{
				i(1),
			}
		),
		{ condition = typst.in_text }
	),
	s(
		{ trig = "dd", snippetType = "autosnippet", hidden = true },
		fmta(
			[[
      $
        <>
      $
      ]],
			{
				i(1),
			}
		),
		{ condition = typst.in_text }
	),
})
