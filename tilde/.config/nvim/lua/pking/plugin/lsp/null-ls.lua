return {
    {
        "nvimtools/none-ls.nvim",
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    require("null-ls").builtins.code_actions.shellcheck,
                    require("null-ls").builtins.diagnostics.fish,
                    require("null-ls").builtins.diagnostics.gitlint,
                    require("null-ls").builtins.diagnostics.hadolint,
                    require("null-ls").builtins.diagnostics.luacheck,
                    require("null-ls").builtins.diagnostics.tfsec,
                    require("null-ls").builtins.diagnostics.vint,
                    require("null-ls").builtins.diagnostics.write_good,
                    require("null-ls").builtins.diagnostics.yamllint,
                    require("null-ls").builtins.formatting.fish_indent,
                    require("null-ls").builtins.formatting.markdownlint,
                    require("null-ls").builtins.formatting.prettierd,
                    require("null-ls").builtins.formatting.shfmt,
                    require("null-ls").builtins.formatting.yamllint,
                },
                diagnostic_config = {
                    virtual_text = false,
                },
            })
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics,
                {
                    virtual_text = false,
                    virtual_lines = { only_current_line = true },
                    update_in_insert = false,
                    severity_sort = true,
                }
            )
        end
    },
}
