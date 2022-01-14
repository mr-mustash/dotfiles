" Syntax Plugins
let g:python_highlight_all = 1

" Nicer tabs and editing for python
autocmd customaugroup BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix

" ALE Linting Configuration
"let b:ale_linters = { 'python': [] }
let b:ale_python_flake8_options = '--config $HOME/.config/flake8'
let b:ale_fixers  = { 'python': ['reorder-python-imports', 'add_blank_lines_for_python_control_statements'] }
