function! ProseSetup() abort
    " `set spell` set by default in plugins/spellcheck.vim, and noplainbuffer
    " is added to spelloptions by default. Setting this here allows us to
    " override the default.
    let g:isprose = 1
    set spelloptions-=noplainbuffer

    highlight clear ColorColumn

    " manual reformatting shortcuts
    nnoremap <buffer> <silent> Q gqap
    xnoremap <buffer> <silent> Q gq
    nnoremap <buffer> <silent> <leader>Q vapJgqap

    " force top correction on most recent misspelling
    nnoremap <buffer> <silent> <leader>s [s1z=<c-o>

    " open most folds
    setlocal foldlevel=6
endfunction
