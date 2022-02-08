if has('nvim')
    "let g:autoloaded_copilot_log = '/dev/null'

    imap <silent><script><expr> <C-k> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:true

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

    if PlugLoaded('copilot.vim')
        let g:copilot_enabled = 1
    endif
endif
