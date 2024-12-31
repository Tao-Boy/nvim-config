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
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local typst = require("utils.typst")

return {

    s({ trig = ";n", wordTrig = false, snippetType = "autosnippet" }, {
        t("nabla"),
    }, { condition = typst.in_mathzone }),
    s({ trig = "v.", wordTrig = false, snippetType = "autosnippet" }, {
        t("dots.v"),
    }, { condition = typst.in_mathzone }),

    s({ trig = "h.", wordTrig = false, snippetType = "autosnippet" }, {
        t("dots.h"),
    }, { condition = typst.in_mathzone }),


    s({ trig = "nin", wordTrig = false, snippetType = "autosnippet" }, {
        t("in.not"),
    }, { condition = typst.in_mathzone }),

    s({ trig = "aa", wordTrig = false, snippetType = "autosnippet" }, {
        t("forall"),
    }, { condition = typst.in_mathzone }),

    s({ trig = "ee", wordTrig = false, snippetType = "autosnippet" }, {
        t("exists"),
    }, { condition = typst.in_mathzone }),

    s({ trig = "==", wordTrig = false, snippetType = "autosnippet" }, {
        t("&="),
    }, { condition = typst.in_mathzone }),

    s({ trig = "mto", wordTrig = false, snippetType = "autosnippet", priority = 1001 }, {
        t("arrow.r.bar"),
    }, { condition = typst.in_mathzone }),

    s({ trig = "+-", wordTrig = false, snippetType = "autosnippet" }, {
        t("pm"),
    }, { condition = typst.in_mathzone }),

    s({ trig = "xx", wordTrig = false, snippetType = "autosnippet" }, {
        t("times"),
    }, { condition = typst.in_mathzone }),

    s({ trig = "up", wordTrig = false, snippetType = "autosnippet" }, {
        t("arrow.t"),
    }, { condition = typst.in_mathzone }),

    s({ trig = "eqv", wordTrig = false, snippetType = "autosnippet" }, {
        t("equiv"),
    }, { condition = typst.in_mathzone }),

    s({ trig = "ot", wordTrig = false, snippetType = "autosnippet" }, {
        t("otimes"),
    }, { condition = typst.in_mathzone }),

    s({ trig = "op", wordTrig = false, snippetType = "autosnippet" }, {
        t("oplus"),
    }, { condition = typst.in_mathzone }),

    s({ trig = "emp", snippetType = "autosnippet", priority = 2000 }, {
        t("emptyset"),
    }, { condition = typst.in_mathzone }),
    s(
        { trig = "ket", snippetType = "autosnippet" },
        fmta("ket(<>)", {
            i(1)
        }), { condition = typst.in_mathzone }
    ),
    s(
        { trig = "bra", snippetType = "autosnippet" },
        fmta("bra(<>)", {
            i(1)
        }), { condition = typst.in_mathzone }
    ),
    s(
        { trig = "bk", snippetType = "autosnippet" },
        fmta("braket(<>,<>)", {
            i(1),i(2)
        }), { condition = typst.in_mathzone }
    ),
    s({ trig = "cd", snippetType = "autosnippet", priority = 2000 }, {
        t("dot"),
    }, { condition = typst.in_mathzone }),

    s({ trig = ",,", wordTrig = false, snippetType = "autosnippet" }, {
        t("\",\""),
    }, { condition = typst.in_mathzone }),
}
