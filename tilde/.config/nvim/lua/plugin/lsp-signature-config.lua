require "lsp_signature".setup({
    auto_close_after = 5,
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    floating_window = true,
    floating_window_off_x = 10, -- Right 10 columns
    handler_opts = { border = "rounded"},
    hint_enable = false,
    transparency = 10,
})
