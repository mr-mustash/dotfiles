-- Load my old init.vim file first
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-- Faster loading:  Used to be https://github.com/lewis6991/impatient.nvim
vim.loader.enable()

-- Only current line diagnostics
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = {
        only_current_line = true
    },
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
})

-- Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({{import = "plugin"}, {import = "plugin.lsp"}}, {
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
})
