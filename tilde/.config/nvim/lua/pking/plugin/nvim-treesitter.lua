return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { 'BufReadPre', 'BufNewFile' },
        config = function ()
            require'nvim-treesitter.configs'.setup {
                -- Automatically install missing parsers when entering buffer
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
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
            require('rainbow-delimiters.setup').setup {}
        end,
    },
}
