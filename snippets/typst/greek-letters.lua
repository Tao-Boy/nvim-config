local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local extras = require "luasnip.extras"
local fmt = extras.fmt
local m = extras.m
local l = extras.l
local postfix = require "luasnip.extras.postfix".postfix
local typst = require("utils.typst")

return
{
    s({ trig = ";a", snippetType = "autosnippet" },
        {
            t("alpha"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";b", snippetType = "autosnippet" },
        {
            t("beta"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";g", snippetType = "autosnippet" },
        {
            t("gamma"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";G", snippetType = "autosnippet" },
        {
            t("Gamma"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";d", snippetType = "autosnippet" },
        {
            t("delta"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";D", snippetType = "autosnippet" },
        {
            t("Delta"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";e", snippetType = "autosnippet" },
        {
            t("epsilon"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";E", snippetType = "autosnippet" },
        {
            t("Epsilon"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";ve", snippetType = "autosnippet" },
        {
            t("epsilon.alt"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";i", snippetType = "autosnippet" },
        {
            t("iota"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";I", snippetType = "autosnippet" },
        {
            t("Iota"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";z", snippetType = "autosnippet" },
        {
            t("zeta"),
        }, { condition = typst.in_mathzone }),

    s({ trig = ";t", snippetType = "autosnippet" },
        {
            t("theta"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";vt", snippetType = "autosnippet" },
        {
            t("theta.alt"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";T", snippetType = "autosnippet" },
        {
            t("Theta"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";k", snippetType = "autosnippet" },
        {
            t("kappa"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";l", snippetType = "autosnippet" },
        {
            t("lambda"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";L", snippetType = "autosnippet" },
        {
            t("Lambda"),
        }, { condition = typst.in_mathzone }),

    s({ trig = ";r", snippetType = "autosnippet" },
        {
            t("rho"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";s", snippetType = "autosnippet" },
        {
            t("sigma"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";S", snippetType = "autosnippet" },
        {
            t("Sigma"),
        }, { condition = typst.in_mathzone }),

    s({ trig = ";p", snippetType = "autosnippet" },
        {
            t("phi"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";vp", snippetType = "autosnippet" },
        {
            t("phi.alt"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";P", snippetType = "autosnippet" },
        {
            t("Phi"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";c", snippetType = "autosnippet" },
        {
            t("chi"),
        }, { condition = typst.in_mathzone }),

    s({ trig = ";o", snippetType = "autosnippet" },
        {
            t("omega"),
        }, { condition = typst.in_mathzone }),
    s({ trig = ";O", snippetType = "autosnippet" },
        {
            t("Omega"),
        }, { condition = typst.in_mathzone }),
}
