function! pking#external_plugins#ctrlp#LoadOrCallCtrlP()
    if exists("g:loaded_ctrlp")
        :CtrlP
    else
        packadd ctrlp.vim
        packadd ctrlp-py-matcher

        " TODO: File bug on the airline project on how to load plugins after
        " startup as described below. The only way to solve this now is to
        " force airline to reload all of its extentions.
        "
        " vim-airline only loads CtrlP theme at startup if CtrlP is loaded,
        " but since we're loading it here dynamically, we need to force it
        " to reload all of its plugins.
        " call airline#extensions#load()
        "
        silent call airline#extensions#load()
        silent call airline#update_statusline()

        :CtrlP
    endif
endfunction
