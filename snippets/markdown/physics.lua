local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local tex = require("utils.markdown")

return {
  s(
    { trig = "bra", wordTrig = false, snippetType = "autosnippet", priority = 3000 },
    fmta("\\bra{<>}", {
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "ket", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
    fmta("\\ket{<>}", {
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "brk", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
    fmta("\\left\\langle <> \\middle| <> \\right\\rangle", {
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- s(
  --   { trig = "ev", snippetType = "autosnippet" },
  --   fmta("\\braket[1]{<>}", {
  --     i(1),
  --   }),
  --   { condition = tex.in_mathzone }
  -- ),
  -- s(
  --   { trig = "kb", snippetType = "autosnippet" },
  --   c(1, {
  --     sn(nil, { t("\\ketbra{"), i(1), t("}{"), i(2), t("}") }),
  --     sn(nil, { t("\\ketbra{"), i(1), t("}["), i(2), t("]{"), i(3), t("}") }),
  --   }),
  --   { condition = tex.in_mathzone }
  -- ),
  -- s(
  --   { trig = "pab", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
  --   fmta("\\ab( <> )", {
  --     i(1),
  --   }),
  --   { condition = tex.in_mathzone }
  -- ),
  -- s(
  --   { trig = "Bab", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
  --   fmta("\\ab\\{ <> \\}", {
  --     i(1),
  --   }),
  --   { condition = tex.in_mathzone }
  -- ),
  -- s(
  --   { trig = "bab", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
  --   fmta("\\ab[ <> ]", {
  --     i(1),
  --   }),
  --   { condition = tex.in_mathzone }
  -- ),
  -- s(
  --   { trig = "\\forallb", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
  --   fmta("\\ab<< <> >>", {
  --     i(1),
  --   }),
  --   { condition = tex.in_mathzone }
  -- ),
  -- s(
  --   { trig = "vab", wordTrig = false, snippetType = "autosnippet" },
  --   c(1, { sn(nil, { t("\\ab|"), i(1), t("|") }), sn(nil, { t("\\ab*|"), i(1), t("|") }) }),
  --   { condition = tex.in_mathzone }
  -- ),
  -- s(
  --   { trig = "Vab", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
  --   fmta("\\ab\\| <> \\|", {
  --     i(1),
  --   }),
  --   { condition = tex.in_mathzone }
  -- ),
  -- s({ trig = "\\tof", snippetType = "autosnippet" }, {
  --   t("\\Tof"),
  -- }, { condition = tex.in_mathzone }),
}
