-- Only current line diagnostics
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
    update_in_insert = false,
    severity_sort = true,
})

function ToggleVirtualLines()
    local current_value = vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = not current_value })
end

vim.api.nvim_create_user_command('ToggleVirtualLines', ToggleVirtualLines, {})
vim.keymap.set('n', '<Leader>e', ToggleVirtualLines, { desc = 'Toggle virtual_lines in diagnostics' })
