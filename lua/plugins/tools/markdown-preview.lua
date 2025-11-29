return {
	"iamcco/markdown-preview.nvim",
  enabled = false,
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && npm install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_port = "8080"
    vim.g.mkdp_echo_preview_url = 1
	end,
	ft = { "markdown" },
}
