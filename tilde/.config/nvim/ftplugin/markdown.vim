autocmd customaugroup FileType markdown,mkd,text call pencil#init()
autocmd customaugroup FileType text call pencil#init({'wrap': 'hard'})
set spell

highlight clear ColorColumn
let g:pencil#wrapModeDefault = 'soft'
let g:airline_section_x = '%{PencilMode()}'

" manual reformatting shortcuts
nnoremap <buffer> <silent> Q gqap
xnoremap <buffer> <silent> Q gq
nnoremap <buffer> <silent> <leader>Q vapJgqap

" force top correction on most recent misspelling
nnoremap <buffer> <silent> <leader>s [s1z=<c-o>

" open most folds
setlocal foldlevel=6
