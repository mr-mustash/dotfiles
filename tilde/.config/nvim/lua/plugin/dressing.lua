return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
        require("dressing").setup({
            input = {
                enabled = true,
            },
              select = {
                -- Set to false to disable the vim.ui.select implementation
                enabled = true,
                backend = { "telescope", }
            }
        })
    end
}
