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

-- -- 全局状态变量，用于跟踪上一次的输入法状态
-- local last_im_state = "chinese" -- 初始假设为中文
--
-- local timer = nil
--
-- vim.api.nvim_create_autocmd("CursorMovedI", {
-- 	pattern = "*.tex",
-- 	callback = function()
-- 		-- 如果定时器存在，先停止它（取消前一个延迟任务）
-- 		if timer then
-- 			timer:stop()
-- 			timer = nil
-- 		end
--
-- 		-- 延迟 50ms 执行检查（防抖）
-- 		timer = vim.defer_fn(function()
-- 			-- 检查 VimTeX 是否可用
-- 			-- if vim.fn.exists("vimtex#syntax#in_mathzone") == 0 then
-- 			-- 	return -- 如果 VimTeX 未加载，跳过
-- 			-- end
--
-- 			-- 调用 VimTeX 函数检查是否在数学环境中（返回 1 表示是，0 表示否）
-- 			local in_math = vim.fn["vimtex#syntax#in_mathzone"]()
--
-- 			if in_math == 1 then
-- 				-- 进入数学环境
-- 				if last_im_state == "chinese" then
-- 					-- 这里调用切换到英文输入法的函数（例如 fcitx 或 ibus 的命令）
-- 					-- switch_im('english')  -- 你可以自行实现或替换
-- 					last_im_state = "english"
-- 					vim.notify("it's in math mode")
-- 				end
-- 			else
-- 				-- 不在数学环境中
-- 				if last_im_state == "english" then
-- 					-- 这里调用切换到中文输入法的函数
-- 					-- switch_im('chinese')  -- 你可以自行实现或替换
-- 					last_im_state = "chinese"
-- 				end
-- 			end
--
-- 			timer = nil -- 执行后重置定时器
-- 		end, 100) -- 延迟时间（ms），可根据需要调整为 100 等
-- 	end,
-- })
