-- Faster loading:  Used to be https://github.com/lewis6991/impatient.nvim
vim.loader.enable()

-- Load my old init.vim file first
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-- Load any new vim options that are in lua files
local optionpath = vim.split(vim.fn.glob(vim.fn.stdpath("config") .. "/lua/vimrc/*.lua"), '\n')
for _, file in ipairs(optionpath) do
        dofile(file)
end

require("pking")
