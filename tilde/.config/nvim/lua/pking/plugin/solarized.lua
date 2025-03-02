return {
    {
        "ishan9299/nvim-solarized-lua",
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        commit = "d69a263c97cbc765ca442d682b3283aefd61d4ac",
        config = function()
            vim.opt.termguicolors = true
            vim.g.solarized_italics = 0

            -- Set up highlights before loading colorscheme
            local custom_highlights = {
                ColorColumn = { bg = "#e75480", fg = "#b58900" },
                SearchHighlight = { ctermfg = 3 },
                CursorLineNR = { bold = true, fg = "#b58900" },
                CursorLine = { bg = "NONE" },
                SignColumn = { bg = "#073642" },
                SpellBad = { bg = "NONE", fg = "#ef3b3b" },
                SpellLocal = { bg = "NONE", fg = "#ef3b3b" },
                -- The icons I use in Copilot Chat (, , and 󰬅) trigger SpellCap for some reason and this is the easiest way to fix it
                SpellCap = { clear = true },
                -- Clear SpellRare because of https://github.com/psliwka/vim-dirtytalk#known-issues
                SpellRare = { clear = true },
                -- Diagnostic signs
                DiagnosticSignError = { fg = "#dc322f", bg = "#073642" },
                DiagnosticSignWarn = { fg = "#b58900", bg = "#073642" },
                DiagnosticSignHint = { fg = "#859900", bg = "#073642" },
                DiagnosticSignInfo = { fg = "#268bd2", bg = "#073642" },
                -- Float windows
                FloatBorder = { bg = "#002b36" },
                NormalFloat = { bg = "#002b36" },
                -- Telescope
                TelescopeSelection = { bg = "#073642", bold = true },
                -- Rainbow delimiters
                RainbowDelimiterRed = { fg = "#DE2A33" },
                RainbowDelimiterOrange = { fg = "#FFAD00" },
                RainbowDelimiterYellow = { fg = "#ffef00" },
                RainbowDelimiterGreen = { fg = "#08FF08" },
                RainbowDelimiterCyan = { fg = "#00C8F0" },
                RainbowDelimiterBlue = { fg = "#4D4DFF" },
                RainbowDelimiterViolet = { fg = "#C724B1" },
            }

            -- Apply the highlights
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    for group, colors in pairs(custom_highlights) do
                        if colors.clear then
                            vim.cmd.highlight("clear " .. group)
                        else
                            vim.api.nvim_set_hl(0, group, colors)
                        end
                    end
                end,
            })

            -- For the 121st column highlight
            local noColumnHighlight = { "man", "fzf" }
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    if not vim.tbl_contains(noColumnHighlight, vim.bo.filetype) then
                        vim.fn.matchadd("ColorColumn", "\\%121v", 100)
                    end
                end,
            })

            -- Load the colorscheme
            vim.cmd.colorscheme("solarized")
        end
    },
    {
        "NvChad/nvim-colorizer.lua",
        event = "VeryLazy",
        opts = {
            lazy_load = true,
            buftypes = {
                "*",
                "!prompt",
                "!popup",
                "!copilot-chat",
            }
        },
    },
}
