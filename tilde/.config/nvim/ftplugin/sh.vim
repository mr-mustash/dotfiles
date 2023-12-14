"vint: -ProhibitUnnecessaryDoubleQuote
let &listchars="tab:  ,trail:\uB7,nbsp:~"
"vint: +ProhibitUnnecessaryDoubleQuote

autocmd customaugroup BufNewFile,BufRead *.sh setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
