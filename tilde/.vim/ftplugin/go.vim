" vim-go is my only package that currently is in pack/plugin/start
" This is because it only load all of the debug and language
" server functions _AFTER_ the filetype has been set. This
" menas that laoding it in a custom ftdetect does not work.
" https://github.com/fatih/vim-go/issues/2144
set nolist

augroup golang
    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
augroup end
