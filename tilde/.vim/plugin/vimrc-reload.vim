augroup VimRCReload
    au!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END


