if exists('did_load_filetypes')
    finish
endif

augroup ftdetect_terraform
    autocmd!
    autocmd BufRead,BufNewFile *.tf,*.tfvars setfiletype terraform
    autocmd BufRead,BufNewFile *.tfstate setfiletype json
    autocmd BufRead,BufNewFile *.hcl setfiletype hcl
    autocmd BufRead,BufNewFile terragrunt.hcl setfiletype terragrunt
augroup END
