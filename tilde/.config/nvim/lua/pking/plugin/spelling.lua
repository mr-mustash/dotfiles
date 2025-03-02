return {
    {
        "psliwka/vim-dirtytalk",
        event = "VeryLazy",
        build = ":DirtytalkUpdate",
        config = function()
            vim.opt.spelllang = { "en", "programming" }
            vim.opt.spelloptions = { "camel", "noplainbuffer" }
        end,
    },
    {
        "micarmst/vim-spellsync",
        config = function ()
            vim.cmd([[
            let g:spellsync_run_at_startup = 1
            let g:spellsync_enable_git_union_merge = 1
            let g:spellsync_enable_git_ignore = 1
            ]])
        end
    },
}
