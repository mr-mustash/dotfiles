let g:pencil#wrapModeDefault = 'soft'
let g:airline_section_x = '%{PencilMode()}'

" manual reformatting shortcuts
nnoremap <buffer> <silent> Q gqap
xnoremap <buffer> <silent> Q gq
nnoremap <buffer> <silent> <leader>Q vapJgqap

" force top correction on most recent misspelling
nnoremap <buffer> <c-s> [s1z=<c-o>

" open most folds
setlocal foldlevel=6
