augroup ftdetect_puppet
    autocmd!
    autocmd BufRead,BufNewFile *.pp setfiletype puppet
    autocmd BufRead,BufNewFile Puppetfile setfiletype ruby
augroup END
