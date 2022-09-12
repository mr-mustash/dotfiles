if has('nvim')
    "let g:autoloaded_copilot_log = '/dev/null'
    let g:copilot_node_command = glob('/opt/homebrew/Cellar/node@16/**/bin/node')

    imap <silent><script><expr> <C-k> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:true

    " Copilot suggestions
    inoremap <C-p>  <Esc>:Copilot<CR>i " List all sugestions
    imap <silent><script><expr> <C-l> <Plug>(copilot-next)
    imap <silent><script><expr> <C-h> <Plug>(copilot-previous)

    " Disable copilot when working on text files
    let g:copilot_filetypes = {
      \ 'markdown':     v:false,
      \ 'mkd':          v:false,
      \ 'md':           v:false,
      \ 'tex':          v:false,
      \ 'text':         v:false,
      \ 'git':          v:false,
      \ 'gitsendemail': v:false,
      \ 'gitcommit':    v:false,
      \ '*commit*':     v:false,
      \ '*COMMIT*':     v:false,
      \ }

    let g:copilot_enabled = 1
endif
