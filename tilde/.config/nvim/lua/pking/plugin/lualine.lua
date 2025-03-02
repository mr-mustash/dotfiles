return {
    {
        "nvim-lualine/lualine.nvim",
        event = { 'UIEnter' },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            {
                "linrongbin16/lsp-progress.nvim",
                config = function()
                    require ('lsp-progress').setup()

                    vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
                    vim.api.nvim_create_autocmd("User", {
                          group = "lualine_augroup",
                          pattern = "LspProgressStatusUpdated",
                          callback = require("lualine").refresh,
                    })
                end,
            },
            "AndreM222/copilot-lualine",
        },
        config = function()
            -- Customizing the solarized theme to look like the vim-airline theme.
            local custom_solarized = require('lualine.themes.solarized_dark')

            -- Mode colors
            custom_solarized.insert.a.bg = '#b58900'
            custom_solarized.normal.a.bg = '#93a1a1'

            -- Background colors
            custom_solarized.normal.b.bg = '#586e75'
            custom_solarized.normal.b.fg = '#fdf6e3'
            custom_solarized.normal.c.fg = '#fdf6e3'

            local null_ls_sources = require("null-ls.sources")

            -- Functions for status line
            local function lsp_client_names()
                local client_names = {}
                for _, client in ipairs(vim.lsp.get_clients()) do
                    if client.name ~= 'null-ls' and client.name ~= 'copilot' then
                        table.insert(client_names, client.name)
                    end
                end
                if next(client_names) then
                    return "󰚩 " .. table.concat(client_names, " • ")
                else
                    return ''
                end
            end

            local function null_ls_diagnostics()
                local client_names = {}
                for _, client in ipairs(null_ls_sources.get_available(vim.bo.filetype)) do
                    if client.filetypes._all ~= true and (client.methods.NULL_LS_DIAGNOSTICS == true or client.methods.NULL_LS_DIAGNOSTICS_ON_SAVE == true) then
                        table.insert(client_names, client.name)
                    end
                end

                if next(client_names) then
                    return " " .. table.concat(client_names, " • ")
                else
                    return nil
                end
            end

            local function null_ls_formatting()
                local client_names = {}
                for _, client in ipairs(null_ls_sources.get_available(vim.bo.filetype)) do
                    if client.filetypes._all ~= true and client.methods.NULL_LS_FORMATTING == true then
                        table.insert(client_names, client.name)
                    end

                end

                if next(client_names) then
                    return "󰉼 " .. table.concat(client_names, " • ")
                else
                    return nil
                end
            end

            local function null_ls_code_actions()
                local client_names = {}
                for _, client in ipairs(null_ls_sources.get_available(vim.bo.filetype)) do
                    if client.filetypes._all ~= true and client.methods.NULL_LS_CODE_ACTION == true then
                        table.insert(client_names, client.name)
                    end
                end

                if next(client_names) then
                    return " " .. table.concat(client_names, " • ")
                else
                    return nil
                end
            end

            local function null_ls_attached_sources() -- Show active null-ls sources
                local full_status = {}
                local diagnostics = null_ls_diagnostics()
                local formatting = null_ls_formatting()
                local actions = null_ls_code_actions()


                if diagnostics ~= "" then table.insert(full_status, diagnostics) end
                if formatting ~= "" then table.insert(full_status, formatting) end
                if actions ~= "" then table.insert(full_status, actions) end

                local lualine = table.concat(full_status, "  ")

                if lualine ~= "" then
                    return lualine
                else
                    return ""
                end
            end

            -- Display number of search results
            local function searchCount()
                local search = vim.fn.searchcount({maxcount = 0}) --`maxcount = 0` makes the number not be capped at 99
                local searchCurrent = search.current
                local searchTotal = search.total
                if searchCurrent > 0 and vim.v.hlsearch ~= 0 then
                    return "/"..vim.fn.getreg("/").." ["..searchCurrent.."/"..searchTotal.."]"
                else
                    return ""
                end
            end

            local function treesitter_attached()
                if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] == nil then
                    return ""
                else
                    return ""
                end

            end

            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme  = custom_solarized,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000
                    }
                },
                extensions = {
                    'fugitive',
                    'lazy',
                    'man',
                    'mason',
                    'mundo',
                },
                tabline = {
                    lualine_a = {
                        {
                            "buffers",
                            show_modified_status = true,
                            mode = 4,
                            symbols = {
                                modified = '  ',
                                alternate_file = ' 󱞧 ',
                                directory =  '  ',
                                readonly = '  ',
                                unnamed = '[No Name]',
                                newfile = '  ',
                            },
                        },
                    },
                    lualine_c = {
                        {
                            'navic',
                            color_correction = 'dynamic',
                        }
                    },
                },
                sections = {
                    lualine_b = {
                        'branch',
                        'diff'
                    },
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,
                            newfile_status = true,
                            symbols = {
                                modified = '  ',
                                alternate_file = ' 󱞧 ',
                                directory =  '  ',
                                readonly = '  ',
                                unnamed = '[No Name]',
                                newfile = '  ',
                            }
                        },
                        'location',
                        require('lsp-progress').progress,
                    },
                    lualine_x = {
                        { searchCount },
                        'fileformat',
                        'filetype',
                    },
                    lualine_y = {
                        { treesitter_attached,  color = {fg= '#859900', gui='none'}, },
                        {
                            'copilot',
                            symbols = {
                                status = {
                                    icons = {
                                        enabled = "",
                                        sleep = "",
                                        disabled = "",
                                        warning = "",
                                        unknown = ""
                                    },
                                    hl = {
                                        enabled = "#859900",
                                        disabled = "#dc322f",
                                        warning = "#b58900",
                                        unknown = "#268bd2"
                                    },
                                    spinners = "arc",
                                    spinner_color = "#6c71c4",
                                },
                            },
                            show_colors = true,
                            show_loading = true,
                        },
                        lsp_client_names,
                        null_ls_attached_sources,
                    },
                    lualine_z = {
                        separator = nil,
                        {
                            'diagnostics',
                            sections = { 'error', 'warn', 'hint', 'info' },
                            symbols = { error = "" , warn = "", info = "", hint = "" },
                            diagnostics_color = {
                                error = {
                                    bg = "#dc322f",
                                    fg = "Black",
                                },
                                warn = {
                                    bg = "#b58900",
                                    fg = "Black",
                                },
                                hint = {
                                    bg = "#859900",
                                    fg = "Black",
                                },
                                info = {
                                    bg = "#268bd2",
                                    fg = "Black",
                                },
                            },
                            colored = true,
                            always_visible = true,
                            separator = nil,
                        },
                    }
                }
            }
        end,
    },
}
