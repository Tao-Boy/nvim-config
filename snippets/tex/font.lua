local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, t(parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local tex = require("utils.latex")

return {
  s(
    { trig = "msf", snippetType = "autosnippet" },
    fmta("\\mathsf{<>}", {
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "mbf", snippetType = "autosnippet" },
    fmta("\\mathbf{<>}", {
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "cal", snippetType = "autosnippet" },
    fmta("\\mathcal{<>}", {
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "scr", snippetType = "autosnippet" },
    fmta("\\mathscr{<>}", {
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "mbb", snippetType = "autosnippet" },
    fmta("\\mathbb{<>}", {
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "mbm", snippetType = "autosnippet" },
    fmta("\\bm{<>}", {
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "mrm", snippetType = "autosnippet" },
    fmta("\\mathrm{<>}", {
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "tit", snippetType = "autosnippet" },
    fmta("\\textit{<>}", {
      i(0),
    })
  ),
  s(
    { trig = "ttt", snippetType = "autosnippet" },
    fmta("\\texttt{<>}", {
      i(0),
    })
  ),
  s(
    { trig = "tbf", snippetType = "autosnippet" },
    fmta("\\textbf{<>}", {
      i(0),
    })
  ),
  s(
    { trig = ",,", snippetType = "autosnippet" },
    fmta("\\text{<>}", {
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
}
