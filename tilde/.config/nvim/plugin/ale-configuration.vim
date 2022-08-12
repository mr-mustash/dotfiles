scriptencoding utf-8

let g:airline#extensions#ale#enabled = 1 " work with airline
let g:ale_sign_column_always = 1 " Keep the sign column open

" Error and warning signs
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_sign_info = ''
let g:ale_sign_style_error = ''
let g:ale_sign_style_warning = ''

" Only lint with specific linters and use custom docker container to run them.
" Part of a failed experiment to lint only inside a docker container.
" Might pick this up again some day, but for now I think it's easier to just
" use the linters that are already installed on disk.
"let g:ale_linters_explicit = 1
"let g:ale_command_wrapper = '/Users/patrick.king/dev/github.com/mr-mustash/ale-linting-docker/test.sh' " Location of the wrapper script

" Fix on save
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*':  ['remove_trailing_lines', 'trim_whitespace'],
\}

" Don't lint when typing, only in normal mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = '1'

" Testing out virtual text to display errors
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '  '
let g:ale_virtualtext_delay = 500
let g:ALEVirtualTextError = ''
let g:ALEVirtualTextWarning = ''
let g:ALEVirtualTextInfo = ''
let g:ALEVirtualTextStyleError = ''
let g:ALEVirtualTextStyleWarning = ''

" Floating error windows
"let g:ale_cursor_detail = 1
"let g:ale_floating_preview = 1
"let g:ale_detail_to_floating_preview = 1
"let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']

" ALE only for linting
let g:ale_autocomplete = 0
let g:ale_completion_autoimport = 0

" Enable ALE everywhere
let g:ale_enabled = 0

" This makes sure that ale disables itself when we open an internal buffer
" g:internal_buffers can be found in .vimrc in the "26 various" section
"if !index(g:internal_buffers, expand('%')) >= 0
"    let b:ale_enabled = 0
"endif
