-- vim.api.nvim_create_autocmd("User", {
--     pattern = "VeryLazy",
--     callback = function()
--         local function _trigger()
--             vim.api.nvim_exec_autocmds("User", { pattern = "AfterLoad" })
--         end

--         if vim.bo.filetype == "alpha" then
--             vim.api.nvim_create_autocmd("BufRead", {
--                 once = true,
--                 callback = _trigger,
--             })
--         else
--             _trigger()
--         end
--     end,
-- })
