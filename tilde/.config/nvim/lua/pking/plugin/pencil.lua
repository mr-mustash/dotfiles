return {
    {
        "reedes/vim-pencil",
        ft = { "git", "text", "markdown"},
        config = function ()
            vim.cmd([[
                let g:pencil#wrapModeDefault = 'soft'
            ]])
        end,
    },
}
