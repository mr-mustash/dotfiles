return {
    'rmagatti/auto-session',
    config = function ()
        require("auto-session").setup {
            auto_session_enabled = true,
            auto_session_create_enabled = true,
            auto_session_use_git_branch = true,
            auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Library", "/"},


            log_level = "error",

            restore_upcoming_session = true,
            cwd_change_handling = {
                post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
                    require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
                end,
            },
            session_lens = {
                buftypes_to_ignore = {},
                load_on_setup = true,
                theme_conf = { border = true },
            },
        }
        vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
            noremap = true,
        })
    end
}
