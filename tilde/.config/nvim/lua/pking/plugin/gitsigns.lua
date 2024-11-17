return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "VeryLazy" },
        config = function()
            require('gitsigns').setup {
                signs = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "-" },
                    topdelete = { text = "^" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true
                },
                attach_to_untracked = true,
                current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = true,
                },
                current_line_blame_formatter = '   <author> at <author_time:%Y-%m-%d> • <abbrev_sha> • <summary>',
                sign_priority = 6,
                update_debounce = 100,
            }
        end,
    },
}
