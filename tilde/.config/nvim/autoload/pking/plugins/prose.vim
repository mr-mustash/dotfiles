function! pking#plugins#prose#Prose() abort
    set spell

    packadd vim-wordy
    packadd vim-pencil
    packadd limelight.vim

    " vim-pencil settings
    let g:pencil#wrapModeDefault = 'soft'
    let g:airline_section_x = '%{PencilMode()}'
    call pencil#init()

    " Limelight Settings
    let g:limelight_default_coefficient = 0.5
    let g:limelight_priority = -1
    :Limelight

    " manual reformatting shortcuts
    nnoremap <buffer> <silent> Q gqap
    xnoremap <buffer> <silent> Q gq
    nnoremap <buffer> <silent> <leader>Q vapJgqap

    " force top correction on most recent misspelling
    nnoremap <buffer> <c-s> [s1z=<c-o>

    " open most folds
    setlocal foldlevel=6
endfunction
