return{
    {
        "echasnovski/mini.nvim",
        version = '*',
        --event = { 'BufReadPre', 'BufNewFile' },
        event = { 'VeryLazy' },
        config = function()
            require('mini.surround').setup()
            --require('mini.comment').setup()
            require('mini.cursorword').setup()
            require('mini.indentscope').setup {
                mappings = {
                    -- Textobjects
                    object_scope = 'ii',
                    object_scope_with_border = 'ai',

                    -- Motions (jump to respective border line; if not present - body line)
                    goto_top = '[i',
                    goto_bottom = ']i',
                },
                options = {
                    try_as_border = true
                },
                symbol = '󰇙',
                draw = {
                    animation = require('mini.indentscope').gen_animation.quadratic({ easing = 'in', duration = 250, unit = 'total' }),
                }
            }
        end,

    },
}
