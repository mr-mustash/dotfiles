return {
    "ray-x/lsp_signature.nvim",
    event = { 'LspAttach' },
    config = function()
        require "lsp_signature".setup({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            always_trigger = true,
            auto_close_after = 5,
            floating_window = true,
            floating_window_above_cur_line = true,
            floating_window_off_x = 30, -- Right 10 columns
            handler_opts = { border = "rounded"},
            hi_parameter = 'LspSignatureActiveParameter',
            hint_enable = true,
            max_height = 20,
            max_width = 120,
            wrap = false,
        })
    end
}
