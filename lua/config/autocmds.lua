local group = vim.api.nvim_create_augroup("user.autocmds", { clear = true })
local autocmd = function(event, opts)
	opts.group = group
	vim.api.nvim_create_autocmd(event, opts)
end

autocmd("FileType", {
	desc = "Soft wrap for prose filetypes",
	pattern = { "markdown", "markdown.mdx", "typst", "tex" },
	command = "setlocal wrap",
})

autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	callback = function()
		vim.hl.on_yank()
	end,
})

autocmd("FileType", {
	desc = "Close help / quickfix / man windows with q",
	pattern = { "help", "qf", "man", "checkhealth" },
	callback = function(args)
		vim.keymap.set(
			"n",
			"q",
			"<Cmd>close<CR>",
			{ buffer = args.buf, silent = true, nowait = true, desc = "Close window" }
		)
	end,
})

autocmd("ModeChanged", {
	desc = "Hide diagnostics while jumping through snippet placeholders",
	pattern = "*:s",
	callback = function()
		vim.diagnostic.enable(false)
	end,
})
autocmd("ModeChanged", {
	desc = "Restore diagnostics after select mode",
	pattern = "[is]:n",
	callback = function()
		vim.diagnostic.enable()
	end,
})

-- Make the terminal's own background match 'Normal' so its padding blends in (OSC 11 / OSC 111)
autocmd({ "UIEnter", "ColorScheme" }, {
	desc = "Sync terminal background with Normal",
	callback = function()
		local bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
		if bg then
			vim.api.nvim_ui_send(string.format("\027]11;#%06x\027\\", bg))
		end
	end,
})
autocmd("UILeave", {
	desc = "Reset terminal background",
	callback = function()
		vim.api.nvim_ui_send("\027]111\027\\")
	end,
})
