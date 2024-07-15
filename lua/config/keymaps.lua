-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("i", "<C-j>", "<Esc>", { desc = "leave insert mode" })
map({ "n", "v" }, "H", "^", {desc = "turn to lead"})
map({ "n", "v" }, "L", "$", {desc = "turn to tail"})