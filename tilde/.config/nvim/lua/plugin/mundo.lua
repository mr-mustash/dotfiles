return {
    {
        "simnalamburt/vim-mundo",
        keys = {
             { "<leader>u", ":MundoToggle<cr>", desc = "Mundo" },
         },
        config = function()
            vim.cmd([[
                let g:mundo_width          = 40
                let g:mundo_preview_height = 20
                let g:mundo_preview_bottom = 1
            ]])
        end,
    }
}
