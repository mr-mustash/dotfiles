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
            null_ls.setup({
                sources = {
                    -- Everything but LSPs are listed here. All automatic LSP
                    -- installs can be found in lspconfig.lua under
                    -- `ensure_installed` for the mason-lspconfig setup.

                    -- Bash

                    null_ls.builtins.formatting.shellharden,
                    null_ls.builtins.formatting.shfmt,

                    -- Docker
                    null_ls.builtins.diagnostics.hadolint,

                    -- Fish
                    null_ls.builtins.diagnostics.fish,
                    null_ls.builtins.formatting.fish_indent,

                    -- Git
                    null_ls.builtins.code_actions.gitrebase,
                    null_ls.builtins.diagnostics.gitlint,

                    -- Golang
                    null_ls.builtins.formatting.gofumpt,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.golines,

                    -- Lua
                    null_ls.builtins.diagnostics.selene.with({
                        extra_args = { "--config", vim.fn.expand("~/.config/selene/selene.toml") },
                    }),
                    null_ls.builtins.formatting.stylua,

                    -- Markdown / Text
                    null_ls.builtins.code_actions.proselint,
                    null_ls.builtins.diagnostics.write_good.with({ filetypes = { "markdown", "text" }}),
                    null_ls.builtins.formatting.markdownlint,

                    -- SQL
                    null_ls.builtins.diagnostics.sqlfluff.with({
                        extra_args = { "--dialect", "postgres" }, -- change to your dialect
                    }),
                    null_ls.builtins.formatting.sql_formatter,

                    -- Terraform
                    null_ls.builtins.diagnostics.tfsec,
                    null_ls.builtins.diagnostics.terraform_validate,
                    null_ls.builtins.diagnostics.trivy,
                    null_ls.builtins.formatting.terraform_fmt, -- Terraform formatting in .tf files

                    -- Typescript
                    null_ls.builtins.formatting.prettierd,

                    -- Vim
                    null_ls.builtins.diagnostics.vint,

                    -- YAML
                    null_ls.builtins.formatting.yamlfmt,
                    null_ls.builtins.diagnostics.yamllint,
                },
                diagnostics_format = "[#{c}] #{m} (#{s})",
            })
        end
    },
}
