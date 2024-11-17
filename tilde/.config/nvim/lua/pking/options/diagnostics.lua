-- Only current line diagnostics
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { only_current_line = true },
    update_in_insert = false,
    severity_sort = true,
})
