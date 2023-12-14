return {
    {
        "neovim/nvim-lspconfig",
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
            {
                "nvimtools/none-ls.nvim",
                dependencies = {
                    "nvim-lua/plenary.nvim"
                },
            },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "jay-babu/mason-null-ls.nvim",
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim"
                },
            },
            "ray-x/lsp_signature.nvim",
        },
        config = function()
            local lsp = require("plugin.config.lsp")
            lsp.init()
        end,
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        event = { 'LspAttach' },
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("lsp_lines").setup()
        end,
    }
}
