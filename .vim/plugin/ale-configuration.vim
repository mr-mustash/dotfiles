" Configuration
let g:ale_completion_enabled = 1
let g:ale_set_balloons = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1


" Leader shortcuts
nnoremap <silent> <Leader>agd :ALEGoToDefinition<CR>
nnoremap <silent> <Leader>afr :ALEFindReferences<CR>

let g:ale_linters = {
            \   'go':   ['gopls', 'gofmt'],
            \   'sh':   ['shfmt', 'shellcheck'],
            \   'yaml': [],
            \}
