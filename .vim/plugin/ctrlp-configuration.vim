" === KEY BINDINGS ===
"let g:ctrlp_map = '<leader>p'
nnoremap <silent> <leader>p :call pking#external_plugins#ctrlp#LoadOrCallCtrlP()<CR>

" === CONFIGURAITON ===
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Use rg or ag if avaliable. Default to find if not.
if executable('rg')
    let g:ctrlp_user_command = 'rg %s --smart-case --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
elseif executable('ag')
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
          \ --ignore .git
          \ --ignore .svn
          \ --ignore .hg
          \ --ignore .DS_Store
          \ --ignore "**/*.pyc"
          \ -g ""'
    let g:ctrlp_use_caching = 0
else
    let g:ctrlp_user_command = 'find %s -type f'
    let g:ctrlp_use_caching = 1
endif

" Mixed mode for searching
let g:ctrlp_cmd = 'CtrlPMixed'

" CtrlP working patch defaults to furthest directory that has .git.
" Secondary path defaults to current working directory.
let g:ctrlp_working_path_mode   = 'ra'

let g:ctrlp_custom_ignore       = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_show_hidden         = 1
let g:ctrlp_max_files           = 1000000
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_match_window        = 'bottom,order:btt,max:20,max:0'
let g:ctrlp_cache_dir           = expand('~/.vim/local/cache')
