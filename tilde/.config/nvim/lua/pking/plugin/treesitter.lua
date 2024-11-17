return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { 'BufReadPre', 'BufNewFile' },
        config = function ()
            require'nvim-treesitter.configs'.setup {
                -- Automatically install missing passers when entering buffer
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = true,
                },
                indent = { enable = true },
                sync_install = false,
            }
        end,
    },
    {
        "hiphish/rainbow-delimiters.nvim",
        event = { 'BufReadPre', 'BufNewFile' },
        dependancies = { "nvim-treesitter/nvim-treesitter" },
        config = function ()
            require('rainbow-delimiters.setup').setup {
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                },
                priority = {
                    [''] = 110,
                    lua = 210,
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterCyan',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterViolet',
                },
            }
        end,
    },
}
