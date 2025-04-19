local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
	s(
		{ trig = "note" },
		fmta(
			[[
        #import "@preview/ori:0.2.2": *
        #import "@preview/physica:0.9.5": *
        #set heading(numbering: numbly("{1:一}、", default: "1.1  "))

        #show: ori.with(
            title: "<>",
            author: "Tau",
            maketitle: true,
            makeoutline: true,
            outline-depth: 3,
          )
    ]],
			{
				i(1),
			}
		)
	),
}
