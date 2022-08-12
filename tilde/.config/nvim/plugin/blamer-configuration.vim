scriptencoding utf-8

let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
let g:blamer_prefix = '   '

let g:blamer_template = '<committer> on <committer-time> • <commit-short> • <summary>'
let g:blamer_date_format = '%Y-%m-%d'

nnoremap <Leader>bt :BlamerToggle<cr>
