return {
    {
        "folke/flash.nvim",
        keys = {
            { "s", mode = { "n", "o", "x" }, false },
            { "S", false },
            { ",", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" }
        },
    }
}
