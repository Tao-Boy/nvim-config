local M = {}

local kind = {
	Class = "󰠱",
	Color = "󰏘",
	Constant = "󰏿",
	Constructor = "",
	Enum = "",
	EnumMember = "",
	Event = "",
	Field = "󰇽",
	File = "󰈙",
	Folder = "󰉋",
	Fragment = "",
	Function = "󰊕",
	Interface = "",
	Implementation = "",
	Keyword = "󰌋",
	Method = "󰆧",
	Module = "",
	Namespace = "󰌗",
	Number = "",
	Operator = "󰆕",
	Package = "",
	Property = "󰜢",
	Reference = "",
	Snippet = "",
	Struct = "",
	Text = "󰉿",
	TypeParameter = "󰅲",
	Undefined = "",
	Unit = "",
	Value = "󰎠",
	Variable = "",
	-- ccls-specific icons.
	TypeAlias = "",
	Parameter = "",
	StaticMethod = "",
	Macro = "",
}

local diagnostic = {
	Error = " ",
	Warning = " ",
	Information = " ",
	Question = " ",
	Hint = "󰌵 ",
}

local function append_space(icons)
	local result = {}
	for k, v in pairs(icons) do
		result[k] = v .. " "
	end
	return result
end

M.icons = {
	kind = kind,
	kind_with_space = append_space(kind),
	diagnostic = diagnostic,
}

return M
