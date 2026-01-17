local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
vim.opt.updatetime = 500

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
