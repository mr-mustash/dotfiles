" Configuration
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 750
let g:ale_set_balloons = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0

let g:ale_lint_delay = 500
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1

" Leader shortcuts
nnoremap <silent> <Leader>agd :ALEGoToDefinition<CR>
nnoremap <silent> <Leader>afr :ALEFindReferences<CR>

let g:ale_linters = {
            \   'go':        ['gopls'],
            \   'python':    ['flake8'],
            \   'sh':        ['shfmt', 'shellcheck'],
            \   'terraform': ['terraform-lsp'],
            \   'vim':       ['vint',],
            \   'yaml':      [],
            \}
