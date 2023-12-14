return{
    {
        "https://github.com/gbprod/yanky.nvim",
        event = { 'BufReadPre', 'BufNewFile' },
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
