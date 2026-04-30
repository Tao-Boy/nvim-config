local set_hl = vim.api.nvim_set_hl

-- Rainbow Colors
set_hl(0, "RainbowRed", { fg = "#E06C75" })
set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
set_hl(0, "RainbowOrange", { fg = "#D19A66" })
set_hl(0, "RainbowGreen", { fg = "#98C379" })
set_hl(0, "RainbowViolet", { fg = "#C678DD" })
set_hl(0, "RainbowCyan", { fg = "#56B6C2" })

-- Float & Popup
set_hl(0, "NormalFloat", { bg = "NONE" })
set_hl(0, "FloatBorder", { bg = "NONE" })
set_hl(0, "Pmenu", { bg = "NONE" })

-- Status Line
set_hl(0, "StatusLine", { bg = "NONE" })
set_hl(0, "StatusLineNC", { link = "StatusLine" })
set_hl(0, "StatusLineTerm", { link = "StatusLine" })
set_hl(0, "StatusLineTermNC", { link = "StatusLine" })

-- Tab Line
set_hl(0, "TabLineFill", { bg = "NONE" })

-- Sign & Fold Columns
set_hl(0, "SignColumn", { bg = "NONE" })
set_hl(0, "FoldColumn", { bg = "NONE" })

-- Cursor
set_hl(0, "CursorLine", { bg = "NONE" })

-- WinBar
set_hl(0, "WinBar", { bg = "NONE" })
set_hl(0, "WinBarNC", { bg = "NONE" })

-- Window Separator
set_hl(0, "WinSeparator", { fg = "#878787" })

-- Virtual Text
set_hl(0, "VirtualTextHint", { link = "DiagnosticHint" })
set_hl(0, "VirtualTextInfo", { link = "DiagnosticInfo" })
set_hl(0, "VirtualTextWarning", { link = "DiagnosticWarn" })
set_hl(0, "VirtualTextError", { link = "DiagnosticError" })

-- highlight line number and foldcolum
set_hl(0, "CursorLineNr", { fg = "#ff9e64", bold = true })
set_hl(0, "FoldColumn", { fg = "#ffffff", bg = "NONE", bold = true })
