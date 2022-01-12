nmap <Leader>gd :GoDebugStart<CR>
nmap <Leader>gr :GoDebugRestart<CR>
nmap <Leader>gx :GoDebugStop<CR>
nmap <Leader>gt :GoDebugTest<CR>
nmap <Leader>gb :GoDebugBreakpoint<CR>
nmap <Leader>gc :GoDebugContinue<CR>
nmap <Leader>gs :GoDebugStep<CR>
nmap <Leader>go :GoDebugStepOut<CR>
nmap <Leader>gn :GoDebugNext<CR>

" === CONFIGURATION ===
" See ftplugin/go.vim for most of the go configuration
" This file is just for anything that vim-go can do

" Debugging
let g:go_debug_log_output = 'debugger'
let g:go_highlight_debug = 1
let g:go_debug_breakpoint_sign_text = ''

" Use ALE instead
let g:go_code_completion_enabled = 0
let g:go_fmt_command = 'goimports'

" Highlighting
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_methods = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0

" TMP - gopls not working
let g:go_gopls_enabled = 0
