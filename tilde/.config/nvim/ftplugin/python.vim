" Syntax Plugins
let g:python_highlight_all = 1

" Nicer tabs and editing for python
autocmd customaugroup BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix
