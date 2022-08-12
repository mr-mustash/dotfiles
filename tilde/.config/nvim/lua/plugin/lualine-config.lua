-- Customizing the solarized theme to look like the vim-airline theme.
local custom_solarized = require'lualine.themes.solarized_dark'
-- Mode colors
custom_solarized.insert.a.bg = '#b58900'
custom_solarized.normal.a.bg = '#93a1a1'

-- Background colors
custom_solarized.normal.b.bg = '#586e75'
custom_solarized.normal.b.fg = '#fdf6e3'
custom_solarized.normal.c.fg = '#fdf6e3'

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme  = custom_solarized,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000
        }
    },
    extensions = {
        'fugitive',
        'man',
        'fzf',
        'mundo',
    }
}
