" === KEY BINDINGS ===
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
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
