return {
    "ray-x/lsp_signature.nvim",
    opts = {
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        always_trigger = true,
        auto_close_after = 5,
        floating_window = true,
        floating_window_above_cur_line = true,
        floating_window_off_x = 30, -- Right 10 columns
        handler_opts = { border = "single" },
        hi_parameter = 'LspSignatureActiveParameter',
        hint_enable = false,
        wrap = true,
        doc_lines = 15,
        max_height = 12,
        max_width = 150,
    },
    config = function(_, opts) require'lsp_signature'.setup(opts) end
}
