return {
    {
        "nvimtools/none-ls.nvim",
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            local null_ls = require("null-ls")
            -- Formatters/linters installed here. Language servers installed
            -- with mason-lspconfig in lspconfig.lua
            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            local code_actions = null_ls.builtins.code_actions
            null_ls.setup({
                sources = {
                    -- Everything but LSPs are listed here. All automatic LSP
                    -- installs can be found in lspconfig.lua under
                    -- `ensure_installed` for the mason-lspconfig setup.

                    -- Bash
                    formatting.shellharden,
                    formatting.shfmt,

                    -- Docker
                    diagnostics.hadolint,

                    -- Fish
                    diagnostics.fish,
                    formatting.fish_indent,

                    -- Git
                    code_actions.gitrebase,
                    diagnostics.gitlint,

                    -- Golang
                    formatting.gofumpt,
                    formatting.goimports,
                    formatting.golines,

                    -- Lua
                    diagnostics.selene.with({
                        extra_args = { "--config", vim.fn.expand("~/.config/selene/selene.toml") },
                    }),
                    formatting.stylua,

                    -- Markdown / Text
                    code_actions.proselint,
                    diagnostics.write_good.with({ filetypes = { "markdown", "text" }}),
                    formatting.markdownlint,

                    -- SQL
                    diagnostics.sqlfluff.with({
                        extra_args = { "--dialect", "postgres" }, -- change to your dialect
                    }),
                    formatting.sql_formatter,

                    -- Terraform
                    diagnostics.tfsec,
                    diagnostics.terraform_validate,
                    diagnostics.trivy,
                    formatting.terraform_fmt, -- Terraform formatting in .tf files

                    -- Typescript
                    formatting.prettierd,

                    -- Vim
                    diagnostics.vint,

                    -- YAML
                    formatting.yamlfmt,
                    diagnostics.yamllint,
                },
                diagnostics_format = "[#{c}] #{m} (#{s})",
            })
        end
    },
}
