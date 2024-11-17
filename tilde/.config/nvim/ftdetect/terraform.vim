augroup ftdetect_terraform
    autocmd!
    autocmd BufRead,BufNewFile *.tf setlocal filetype=terraform
    autocmd BufRead,BufNewFile *.tfvars setlocal filetype=terraform
    autocmd BufRead,BufNewFile *.tfstate setlocal filetype=javascript
augroup END
