return{
    {
        "gbprod/yanky.nvim",
        keys = {
            { "yy", mode = { "n",}, "yy", desc = "yank" },
            { "y", mode = { "x",}, "y", desc = "yank" },
            { "Y", mode = { "n", "x", }, "y$", desc = "yank" },
        },
        config = function()
            require("yanky").setup({
                system_clipboard = {
                    sync_with_ring = false,
                },
            })
            vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)=`]")
            vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)=`]")
            vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
            vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
        end,
    }
}
