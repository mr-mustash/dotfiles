let g:airline#extensions#ale#enabled = 1 " work with airline
let g:ale_sign_column_always = 1 " Keep the sign column open

" Error and warning signs
let g:ale_sign_error = ''
let g:ale_sign_warning = ''

let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace', 'fix_trailing_dot',
            \            'fix_trailing_semicolon', 'fix_trailing_comma'],
            \   }

" Don't lint when typing, only in normal mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = '1'

" Floating error windows
let g:ale_cursor_detail = 1
let g:ale_detail_to_floating_preview = 1
let g:ale_floating_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']

" ALE autocomplete
let g:ale_autocomplete = 1
let g:ale_completion_autoimport = 1
set omnifunc=ale#completion#OmniFunc


" This makes sure that ale disables itself when we open an internal buffer
" g:internal_buffers can be found in .vimrc in the "26 various" section
if !index(g:internal_buffers, expand('%')) >= 0
    let g:ale_enabled = 0
endif
