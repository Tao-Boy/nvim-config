-- Transparent backgrounds and a few custom groups, re-applied after every :colorscheme
local set_hl = vim.api.nvim_set_hl

--- Drop a group's background but keep the rest of the color scheme's definition (text color,
--- bold, ...). `set_hl(0, name, { bg = "NONE" })` would replace the whole group.
local function clear_bg(name)
	local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
	hl.bg, hl.ctermbg = nil, nil
	set_hl(0, name, hl)
end

local function apply()
	-- Rainbow Colors
	set_hl(0, "RainbowRed", { fg = "#E06C75" })
	set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	set_hl(0, "RainbowGreen", { fg = "#98C379" })
	set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	set_hl(0, "RainbowCyan", { fg = "#56B6C2" })

	-- Window Separator (before the float groups: FloatBorder links to it)
	set_hl(0, "WinSeparator", { fg = "#878787" })

	-- Transparent background: editor, floats/popups, status/tab/win bars, sign column.
	for _, group in ipairs({
		"Normal", -- NormalNC / EndOfBuffer link to it
		"NormalFloat",
		"FloatBorder",
		"Pmenu",
		"StatusLine",
		"TabLineFill",
		"SignColumn",
		"CursorLine",
		"WinBar",
		"WinBarNC",
	}) do
		clear_bg(group)
	end
	set_hl(0, "StatusLineNC", { link = "StatusLine" })
	set_hl(0, "StatusLineTerm", { link = "StatusLine" })
	set_hl(0, "StatusLineTermNC", { link = "StatusLine" })

	-- Virtual Text
	set_hl(0, "VirtualTextHint", { link = "DiagnosticHint" })
	set_hl(0, "VirtualTextInfo", { link = "DiagnosticInfo" })
	set_hl(0, "VirtualTextWarning", { link = "DiagnosticWarn" })
	set_hl(0, "VirtualTextError", { link = "DiagnosticError" })

	-- highlight line number and foldcolum
	set_hl(0, "CursorLineNr", { fg = "#ff9e64", bold = true })
	set_hl(0, "FoldColumn", { fg = "#ffffff", bg = "NONE", bold = true })
end

apply()
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("user.highlights", { clear = true }),
	callback = apply,
})
