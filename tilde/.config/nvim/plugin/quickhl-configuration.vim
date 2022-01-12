" === KEY BINDINGS ===
" Functions located in .vim/autoload/pking/external_plugins.vim
"nmap <leader>m <Plug>(quickhl-manual-this)
"nmap <leader>M <Plug>(quickhl-manual-reset)
"nnoremap <silent> <leader>m :call pking#external_plugins#quickhl#LoadOrCallQuickhlManual()<CR>
"nnoremap <silent> <leader>M :call pking#external_plugins#quickhl#LoadOrCallQuickhlReset()<CR>

nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
