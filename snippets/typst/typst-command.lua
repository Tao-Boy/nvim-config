local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local c = ls.choice_node
local typst = require("utils.typst")

return {
    s({ trig = "begin", hidden = true },
        fmta(
            [[
        #import "template.typ":*
        #show: template.with(
            title: [<>],
            accent: orange
        )

        <>
        ]],
            { i(1), i(2) }
        ), { condition = typst.in_text }
    ),

    s({ trig = "box.def" },
        fmta(
            [[
        #definition("<>")[
           <>
        ]
        ]],
            {
                i(1,"定义"),
                i(2)
            }
        ), { condition = typst.in_text }

    ),

    s({ trig = "box.eg" },
        fmta(
            [[
        #example("<>")[
           <>
        ]
        ]],
            {
                i(1,"示例"),
                i(2)
            }
        ), { condition = typst.in_text }

    ),

    s({ trig = "box.danger" },
        fmta(
            [[
        #attention("<>")[
           <>
        ]
        ]],
            {
                i(1,"注意"),
                i(2)
            }
        ), { condition = typst.in_text }

    ),

    s({ trig = "box.thm" },
        fmta(
            [[
        #theorem("<>")[
           <>
        ]
        ]],
            {
                i(1,"定理"),
                i(2)
            }
        ), { condition = typst.in_text }

    ),

    s({ trig = "box.prop" },
        fmta(
            [[
        #proposition("<>")[
           <>
        ]
        ]],
            {
                i(1,"命题"),
                i(2)
            }
        ), { condition = typst.in_text }

    ),

    s({ trig = "text", snippetType = "autosnippet", wordTrig = false },
        fmta("<>text(<>,<>pt)[<>]<>", {
            i(1, "#"),
            i(2, "red"),
            i(3, "12"),
            i(4),
            i(5)
        }), { condition = typst.in_text }

    ),
}
