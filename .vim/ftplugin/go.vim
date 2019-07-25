packadd vim-go
set nolist

" ### ALE ###
" golangserver
let g:ale_go_langserver_executable  = '/Users/pking/go/bin/go-langserver'
let g:ale_go_langserver_options = '-lint-tool golint'

" goplz
let g:ale_go_gopls_executable = "/Users/pking/go/bin/gopls"
let g:ale_go_gopls_options = "serve -mode stdio"
