packadd vim-markdown

"autocmd customaugroup BufWrite *
"    \ let b:filename = expand('@%')
"    \ | let b:markdown_name = expand('%:r')+".html"
"    \ | :!pandoc -s expand(b:filename) -o expane(b:markdown_name)

highlight clear ColorColumn
