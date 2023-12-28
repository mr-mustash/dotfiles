return {
    {
        "ishan9299/nvim-solarized-lua",
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[
            " Load custom highlights after colorscheme is loaded
            " https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
            function! MyHighlights() abort
                " Only highlight the 121st character when it's visible on the screen.
                highlight ColorColumn guibg=#e75480 guifg=#b58900
                let g:noColumnHighlight = ['man', 'fzf']
                autocmd customaugroup Filetype * if index(g:noColumnHighlight, &ft) == -1 | call matchadd('ColorColumn', '\%121v',100) | endif

                highlight SearchHighlight ctermfg=3
                highlight CursorLineNR    cterm=bold guifg=#b58900
                highlight CursorLine      cterm=none ctermbg=0 ctermfg=none
                highlight SignColumn      guibg=#073642

                highlight SpellBad   ctermbg=7 guifg=#ef3b3b
                highlight SpellLocal ctermbg=7 guifg=#ef3b3b
                highlight SpellCap   ctermbg=7 guifg=#ef3b3b
                highlight clear SpellRare " clearing because of https://github.com/psliwka/vim-dirtytalk#known-issues

                highlight DiagnosticSignError guifg=#dc322f guibg=#073642
                highlight DiagnosticSignWarn guifg=#b58900 guibg=#073642
                highlight DiagnosticSignHint guifg=#859900 guibg=#073642
                highlight DiagnosticSignInfo guifg=#268bd2 guibg=#073642

                highlight FloatBorder guibg=#002b36
                highlight NormalFloat guibg=#002b36

                highlight TelescopeSelection guibg=#073642 gui=bold

                highlight RainbowDelimiterRed guifg=#DE2A33
                highlight RainbowDelimiterOrange guifg=#FFAD00
                highlight RainbowDelimiterYellow guifg=#ffef00
                highlight RainbowDelimiterGreen guifg=#08FF08
                highlight RainbowDelimiterCyan guifg=#00C8F0
                highlight RainbowDelimiterBlue guifg=#4D4DFF
                highlight RainbowDelimiterViolet guifg=#C724B1

            endfunction

            augroup MyColors
                autocmd!
                autocmd ColorScheme * call MyHighlights()
            augroup END

            set termguicolors

            let g:solarized_italics = 0
            colorscheme solarized
            ]])
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },
}
