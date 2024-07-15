return {
    "dfendr/clipboard-image.nvim",
    ft = "typst",
    keys = {	{"<leader>t",":PasteImg<cr>"}	},
    config = function()
        require 'clipboard-image'.setup ({
            default = {
                img_dir = "./images",
		img_dir_txt = "images",
                img_name = function() return os.date('%Y-%m-%d-%H-%M-%S') end,
                affix = "#image(\"%s\")"
            }
        })
    end
}
