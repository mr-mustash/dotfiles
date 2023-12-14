local lsp = {}

local function null_ls_init()
    -- Config
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
end

local function mason_null_ls_init()
    require("mason-null-ls").setup({
        ensure_installed = nil,
        automatic_installation = true,
    })
end

local function mason_init()
    require('mason.settings').set({
        ui = {
            border = 'rounded'
        }
    })
    require("mason").setup()
end

local function lsp_zero_mason_lspconfig_navic_init()
    local mason_lspconfig = require("mason-lspconfig")
    local lsp_zero = require('lsp-zero').preset('lsp-only')
    local navic = require("nvim-navic")
    local navbuddy = require("nvim-navbuddy")

    lsp_zero.set_sign_icons({
        error = '',
        warn = '',
        info = '',
        hint = '⚑'
    })

    lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings to learn the available actions
        lsp_zero.default_keymaps({buffer = bufnr})

        -- Navic and navbuddy require documentSymbolProvider
        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
            navbuddy.attach(client, bufnr)
        end
    end)

    lsp_zero.setup()

    mason_lspconfig.setup({
        automatic_installation = true,
        handlers = {
            lsp_zero.default_setup,
        },
    })

    navic.setup {
        highlight = true,
        separator = " > ",
        depth_limit_indicator = "...",
        lazy_update_context = false,
        click = false,
    }

end

local function lsp_signature_init()
    require "lsp_signature".setup({
        auto_close_after = 5,
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        floating_window = true,
        floating_window_off_x = 10, -- Right 10 columns
        handler_opts = { border = "rounded"},
        hint_enable = false,
        transparency = 10,
    })
end

function lsp.init()
    require("lspconfig")
    null_ls_init()
    mason_init()
    lsp_zero_mason_lspconfig_navic_init()
    mason_null_ls_init()
    lsp_signature_init()

    -- This is necessary to make sure virtual text is only shown on the current
    -- line
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
            virtual_lines = { only_current_line = true }
        }
    )
end

return lsp
