require('mason.settings').set({
    ui = {
        border = 'rounded'
    }
})
require("mason").setup()

require("mason-lspconfig").setup({
    automatic_installation = true,
})
