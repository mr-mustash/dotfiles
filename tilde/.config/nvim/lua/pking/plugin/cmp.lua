return {
    "hrsh7th/nvim-cmp",
    event = "FileType",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "petertriho/cmp-git",
        "onsails/lspkind.nvim",
        {
            "saadparwaiz1/cmp_luasnip",
            dependencies = {
                {
                    "L3MON4D3/LuaSnip",
                    build = "make install_jsregexp",
                    dependencies = { "rafamadriz/friendly-snippets" },
                },
            }
        },
        {
            "zbirenbaum/copilot-cmp",
            dependencies = { "zbirenbaum/copilot.lua" }
        },
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        require("cmp_git").setup()
        require("luasnip.loaders.from_vscode").lazy_load()

        require('copilot').setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                [""] = false,
                commit = false,
                ["copilot-chat"] = false,
                cvs = false,
                git = false,
                gitcommit = false,
                gitrebase = false,
                gitsendmail = false,
                help = false,
                hgcommit = false,
                man = false,
                markdown = false,
                md = false,
                mkd = false,
                netrw = false,
                svn = false,
                tex = false,
                text = false,
                yaml = false,
            },
        })

        require("copilot_cmp").setup()

        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

        cmp.setup({
            enabled = function()
            -- Disable completion in copilot-chat buffers
                local buftype = vim.api.nvim_buf_get_option(0, 'filetype')
                if buftype == "copilot-chat" or buftype == 'TelescopePrompt' then
                    return false
                end
                return true
            end,
            completion = {
                completeopt = "menu,menuone,preview,noselect"
            },
            snippet = { -- Configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = "copilot", group_index = 2, max_item_count = 3 },
                { name = "nvim_lsp", group_index = 2 },
                { name = "luasnip" }, -- snippets
                { name = "path" }, -- filesystem paths
                {
                    name = 'buffer',
                    option = {
                        get_bufnrs = function()
                            local bufs = {}
                            for _, win in ipairs(vim.api.nvim_list_wins()) do
                                bufs[vim.api.nvim_win_get_buf(win)] = true
                            end
                            return vim.tbl_keys(bufs)
                        end,
                        keyword_length = 4,
                        keyword_pattern = [[\k\+]],
                        max_item_count = 5,
                    }
                }
            }),
            -- Configure lspkind for vs-code like pictograms in completion menu
            formatting = {
                format = lspkind.cmp_format({
                    preset = 'codicons',
                    mode = 'symbol_text',
                    maxwidth = 80,
                    ellipsis_char = "...",
                    show_labelDetails = true,
                    symbol_map = {
                        Copilot = "",
                    },
                }),
            },
            sorting = {
                priority_weight = 2,
                comparators = {
                    require("copilot_cmp.comparators").prioritize,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.score,
                    cmp.config.compare.kind,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                },
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            filetype = {
                ['copilot-chat'] = {
                    enabled = false
                },
                gitcommit = {
                    sources = cmp.config.sources({
                        { name = 'git' },
                        { name = 'buffer' },
                    })
                }
            }
        })

        -- Hack to get cmp to work in command window https://github.com/hrsh7th/cmp-cmdline/pull/61#issuecomment-1243380455
        vim.api.nvim_create_augroup('CMP', { clear = true })
        vim.api.nvim_create_autocmd('CmdwinEnter', {
            group = 'CMP',
            pattern = '*',
            callback = function()
                cmp.setup.buffer({
                    sources = cmp.config.sources({
                        { name = 'cmdline' },
                        { name = 'path' },
                        { name = 'buffer' }
                    }),
                    mapping = cmp.mapping.preset.cmdline(), -- Add this line
                    completion = {
                        completeopt = 'menu,menuone,noselect'
                    }
                })
            end
        })
    end
}
