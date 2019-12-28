" === KEY BINDINGS ===
" Functions located in .vim/autoload/pking/external_plugins.vim
"nmap <leader>m <Plug>(quickhl-manual-this)
"nmap <leader>M <Plug>(quickhl-manual-reset)
nnoremap <silent> <leader>m :call pking#external_plugins#quickhl#LoadOrCallQuickhlManual()<CR>
nnoremap <silent> <leader>M :call pking#external_plugins#quickhl#LoadOrCallQuickhlReset()<CR>

" === CONFIGURAITON ===
let g:quickhl_manual_enable_at_startup = 1
