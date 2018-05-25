" === KEY BINDINGS ===

" === CONFIGURATION ===
let g:committia_open_only_vim_starting = 1

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Turn on spelling to edit window.
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    end

endfunction
