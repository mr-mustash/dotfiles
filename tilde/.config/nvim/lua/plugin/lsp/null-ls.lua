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
            null_ls.setup({
                sources = {
                    -- Bash
                    null_ls.builtins.code_actions.shellcheck,
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

                    -- Lua
                    null_ls.builtins.diagnostics.luacheck,
                    null_ls.builtins.formatting.stylua,

                    -- Markdown / Text
                    null_ls.builtins.code_actions.proselint,
                    null_ls.builtins.diagnostics.vale,
                    null_ls.builtins.diagnostics.write_good.with({ filetypes = { "markdown", "text" }}),
                    null_ls.builtins.formatting.markdownlint,

                    -- Python
                    null_ls.builtins.formatting.autopep8,

                    -- SQL
                    null_ls.builtins.diagnostics.sqlfluff.with({
                        extra_args = { "--dialect", "postgres" }, -- change to your dialect
                    }),
                    null_ls.builtins.formatting.sql_formatter,

                    -- Terraform
                    null_ls.builtins.diagnostics.tfsec,
                    null_ls.builtins.formatting.terrafmt, -- Terraform formatting in markdown
                    null_ls.builtins.formatting.terraform_fmt, -- Terraform formatting in .tf files

                    -- TOML
                    null_ls.builtins.formatting.taplo,

                    -- Typescript
                    null_ls.builtins.code_actions.eslint_d,
                    null_ls.builtins.formatting.prettierd,

                    -- Vim
                    null_ls.builtins.diagnostics.vint,

                    -- YAML
                    null_ls.builtins.diagnostics.yamllint,
                },
                diagnostics_format = "#{s}: #{m} [#{c}]",
                diagnostic_config = {
                    virtual_text = false,
                    virtual_lines = { only_current_line = true }
                },
            })
        end
    },
}
