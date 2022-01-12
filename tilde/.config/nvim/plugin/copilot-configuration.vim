if has('nvim')
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
