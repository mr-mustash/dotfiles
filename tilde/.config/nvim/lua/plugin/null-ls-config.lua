-- Auto fix formatting on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Config
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.code_actions.gitsigns,
        require("null-ls").builtins.code_actions.shellcheck,
        require("null-ls").builtins.diagnostics.fish,
        require("null-ls").builtins.diagnostics.gitlint,
        require("null-ls").builtins.diagnostics.hadolint,
        require("null-ls").builtins.diagnostics.luacheck,
        require("null-ls").builtins.diagnostics.vint,
        require("null-ls").builtins.diagnostics.write_good,
        require("null-ls").builtins.diagnostics.yamllint,
        require("null-ls").builtins.formatting.fish_indent,
        require("null-ls").builtins.formatting.markdownlint,
        require("null-ls").builtins.formatting.prettierd,
        require("null-ls").builtins.formatting.shfmt,
        require("null-ls").builtins.formatting.yamllint,
    },
    -- Auto fix formatting on save
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
})
