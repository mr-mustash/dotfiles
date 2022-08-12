require("null-ls").setup({
    sources = {
        require("null-ls").builtins.code_actions.gitsigns,
        require("null-ls").builtins.code_actions.shellcheck,
        require("null-ls").builtins.diagnostics.fish,
        require("null-ls").builtins.diagnostics.gitlint,
        require("null-ls").builtins.diagnostics.hadolint,
        --require("null-ls").builtins.diagnostics.luacheck,
        require("null-ls").builtins.diagnostics.write_good,
        --require("null-ls").builtins.diagnostics.vint,
        require("null-ls").builtins.diagnostics.yamllint,
        require("null-ls").builtins.formatting.fish_indent,
        require("null-ls").builtins.formatting.markdownlint,
        require("null-ls").builtins.formatting.prettierd,
        require("null-ls").builtins.formatting.shfmt,
        --require("null-ls").builtins.formatting.yamllint,
    },
})
