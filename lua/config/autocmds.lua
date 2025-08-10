local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("User", {
	pattern = "VeryLazy",
	group = augroup("AfterLoad", { clear = true }),
	callback = function()
		local function _trigger()
			vim.api.nvim_exec_autocmds("User", { pattern = "AfterLoad" })
		end

		if vim.bo.filetype == "snacks_dashboard" then
			vim.api.nvim_create_autocmd("BufRead", {
				once = true,
				callback = _trigger,
			})
		else
			_trigger()
		end
	end,
})

autocmd("TextYankPost", {
	group = augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("FileType", {
	group = augroup("filetype-set", { clear = true }),
	pattern = "*",
	command = "set formatoptions-=ro",
})

local diag_in_select = augroup("diag_in_select", { clear = true })
autocmd("ModeChanged", {
	group = diag_in_select,
	pattern = "*:s",
	callback = function()
		vim.diagnostic.enable(false)
	end,
})
autocmd("ModeChanged", {
	group = diag_in_select,
	pattern = "[is]:n",
	callback = function()
		vim.diagnostic.enable()
	end,
})
