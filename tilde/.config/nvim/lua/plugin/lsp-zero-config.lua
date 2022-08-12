local lsp = require('lsp-zero')

lsp.preset('lsp-only')
lsp.set_preferences({
    sign_icons = {
        error = '',
        warn = '',
        info = '',
        hint = '⚑'
    }
})

lsp.setup()
