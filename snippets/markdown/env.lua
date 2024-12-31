local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local tex = require("utils.markdown")

-- 数学定理及其其他的一些环境
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

return {
  s(
    { trig = "mk", snippetType = "autosnippet" },
    fmta(
      [[
      $<>$ 
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    { trig = "dm", snippetType = "autosnippet" },
    fmta(
      [[
            $$
            <>
            $$
        ]],
      {
        i(1),
      }
    )
  ),
  -- 开始一个环境
  s(
    { trig = "bal", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{align*}
        <>
      \end{align*}
      ]],
      {
        i(0),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "beg", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{<>}
        <>
      \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    ),
    { condition = tex.in_mathzone }
  ),
}
