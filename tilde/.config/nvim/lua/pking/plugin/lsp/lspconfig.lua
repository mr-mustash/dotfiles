return {
    "neovim/nvim-lspconfig",
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        {
            "williamboman/mason-lspconfig.nvim", -- setup in lspconfig function
            dependencies = {
                "williamboman/mason.nvim",
            },
        },
        "nvim-lua/plenary.nvim",
        "SmiteshP/nvim-navic",
        "ray-x/lsp_signature.nvim",
    },
    config = function()
        local lspconfig = require('lspconfig')
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = {buffer = event.buf}

                opts.desc = "Show LSP references"
                vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end
        })

        local signs = { Error = "", Warn = "", Hint = "", Info = "" }
        for type, icon in pairs(signs) do
            -- Highlights set in solarized.lua under `DiagnosticSign*`
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl })
        end

        local on_attach = function(client, bufnr)

            -- Attach Navic if supported
            if client.server_capabilities.documentSymbolProvider then
                local navic = require("nvim-navic")
                navic.setup {
                    highlight = true,
                    separator = " > ",
                    depth_limit_indicator = "...",
                    lazy_update_context = false,
                    click = false,
                }

                navic.attach(client, bufnr)
            end

            -- Highlight symbol under cursor
            if client.server_capabilities.documentHighlightProvider then
                vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    group = "LspDocumentHighlight",
                    buffer = bufnr,
                    callback = vim.lsp.buf.document_highlight,
                })
                vim.api.nvim_create_autocmd("CursorMoved", {
                    group = "LspDocumentHighlight",
                    buffer = bufnr,
                    callback = vim.lsp.buf.clear_references,
                })
            end

            -- Code Lens support
            if client.server_capabilities.codeLensProvider then
                vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                    buffer = bufnr,
                    callback = vim.lsp.codelens.refresh,
                })
            end

            -- Attach lsp_signature" if signatureHelpProvider supported
            if client.server_capabilities.signatureHelpProvider then
                require("lsp_signature").on_attach({
                    bind = true,
                    always_trigger = true,
                    auto_close_after = 5,
                    floating_window = true,
                    floating_window_above_cur_line = true,
                    floating_window_off_x = 30, -- Right 10 columns
                    handler_opts = { border = "single" },
                    hi_parameter = 'LspSignatureActiveParameter',
                    hint_enable = false,
                    wrap = true,
                    doc_lines = 15,
                    max_height = 12,
                    max_width = 150,
                }, bufnr)
            end
        end

        require("mason").setup({
            ui = {
                border = "rounded",
                check_outdated_packages_on_open = true,
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        require("mason-lspconfig").setup({
            automatic_installation = true,
            -- Language servers installed here. Formatters/linters
            -- installed in mull-ls.lua
            ensure_installed = {
                "bashls",
                "dockerls",
                "eslint", -- Javascript
                "harper_ls",
                "jsonls",
                "lua_ls",
                "ruff",
                "sqlls",
                "taplo", -- TOML
                "terraformls",
                "vimls",
                "yamlls",
            },
            handlers = {
                function(server_name)
                    local opts = {
                        capabilities = lsp_capabilities,
                        on_attach = on_attach,
                    }

                    if server_name == "lua_ls" then
                        opts.settings = {
                            Lua = {
                                runtime = {
                                    version = 'LuaJIT',
                                    path = vim.split(package.path, ';'),
                                },
                                diagnostics = {
                                    enable = true,
                                    globals = { 'vim', 'hs' },
                                },
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true),
                                    checkThirdParty = false,
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        }
                    end

                    lspconfig[server_name].setup(opts)
                end,
            },
        })
    end
}
