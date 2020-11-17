function! pking#plugins#prose#Prose()
    " Disable coc.nvim for text
    silent! CocDisable

    set spell

    packadd vim-wordy
    packadd vim-pencil

    call pencil#init({'wrap': 'soft', 'autoformat': 1})

    " Airline Status
    let g:airline_section_x = '%{PencilMode()}'

    " manual reformatting shortcuts
    nnoremap <buffer> <silent> Q gqap
    xnoremap <buffer> <silent> Q gq
    nnoremap <buffer> <silent> <leader>Q vapJgqap

    " force top correction on most recent misspelling
    nnoremap <buffer> <c-s> [s1z=<c-o>

    " open most folds
    setlocal foldlevel=6

    " highlight words (reedes/vim-wordy)
    nnoremap <Leader>W :NextWordy<cr>

endfunction
