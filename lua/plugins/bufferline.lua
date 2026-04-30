return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "User AfterLoad",
	keys = {
		{ "<leader>bd", "<cmd>bd<CR>", desc = "Delete Current Buffer" },
		{ "<leader>br", "<cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
		{ "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
		{ "<S-h>", "<cmd>bprevious<cr>", desc = "Prev Buffer" },
		{ "<S-l>", "<cmd>bnext<cr>", desc = "Next Buffer" },
	},
	config = function()
		require("bufferline").setup({
			options = {
				numbers = "none",
				always_show_bufferline = true,
				auto_toggle_bufferline = true,
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				diagnostics_update_on_event = true,
				indicator = { style = "none" },
				separator_style = { "", "" },
				themeable = true,
			},
			highlights = {
				background = { fg = "#787c99", bg = "none", bold = true, italic = true },
				buffer_selected = { fg = "#ffffff", bg = "none", bold = true, italic = true },
			},
		})
	end,
}
