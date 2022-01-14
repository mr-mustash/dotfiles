set nolist
autocmd customaugroup BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" ALE Linting Configuration
let b:ale_linters = { 'go': ['govet', 'gofmt', 'golint', 'gopls', 'staticcheck'] }
let b:ale_fixers  = { 'go': ['gofmt', 'gofumpt', 'goimports', 'golines'] }
