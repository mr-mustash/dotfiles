-- Customizing the solarized theme to look like the vim-airline theme.
local custom_solarized = require'lualine.themes.solarized_dark'
-- Mode colors
custom_solarized.insert.a.bg = '#b58900'
custom_solarized.normal.a.bg = '#93a1a1'

-- Background colors
custom_solarized.normal.b.bg = '#586e75'
custom_solarized.normal.b.fg = '#fdf6e3'
custom_solarized.normal.c.fg = '#fdf6e3'

-- Functions for status line
local function lsp_client_names()
    local client_names = {}
    for _, client in ipairs(vim.lsp.get_active_clients()) do
        if client.name ~= 'null-ls' and client.name ~= 'copilot' then
            table.insert(client_names, client.name)
        end
    end
    if next(client_names) then
        return "ﮧ " .. table.concat(client_names, " • ")
    else
        return ''
    end
end

local function null_ls_diagnostics()
    local client_names = {}
    for _, client in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
        if client.filetypes._all ~= true and client.methods.NULL_LS_DIAGNOSTICS == true then
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
    for _, client in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
        if client.filetypes._all ~= true and client.methods.NULL_LS_FORMATTING == true then
            table.insert(client_names, client.name)
        end
    end

    if next(client_names) then
        return " " .. table.concat(client_names, " • ")
    else
        return nil
    end
end

local function null_ls_code_actions()
    local client_names = {}
    for _, client in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
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
    local actions = null_ls_code_actions()
    local diagnostics = null_ls_diagnostics()
    local formatting = null_ls_formatting()


    if actions ~= "" then table.insert(full_status, actions) end
    if diagnostics ~= "" then table.insert(full_status, diagnostics) end
    if formatting ~= "" then table.insert(full_status, formatting) end

    local lualine = table.concat(full_status, "  ")

    if lualine ~= "" then
        return lualine
    else
        return ""
    end
end

-- Display number of serach results
function searchCount()
    local search = vim.fn.searchcount({maxcount = 0}) -- maxcount = 0 makes the number not be capped at 99
    local searchCurrent = search.current
    local searchTotal = search.total
    if searchCurrent > 0 and vim.v.hlsearch ~= 0 then
        return "/"..vim.fn.getreg("/").." ["..searchCurrent.."/"..searchTotal.."]"
    else
        return ""
    end
end

-- Status line config
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
        'fzf',
        'man',
        'mundo',
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
                    modified = '  ',      -- Text to show when the file is modified.
                    readonly = '  ',      -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                    newfile = '  ',     -- Text to show for new created file before first writting
                }
            },
            'lsp_progress',
        },
        lualine_x = {
            { searchCount },
            'fileformat',
            'filetype'
        },
        lualine_y = {
            separator = nil,
            lsp_client_names,
            null_ls_attached_sources,
        },
        lualine_z = {
            'diagnostics',
        }
    }
}
