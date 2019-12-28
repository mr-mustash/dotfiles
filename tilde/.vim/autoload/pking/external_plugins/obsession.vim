function! pking#external_plugins#obsession#LoadOrCallObsess()
    if exists("g:loaded_obsession")
        :Obsess
    else
        packadd vim-obsession
        :Obsess
    endif
endfunction

function! pking#external_plugins#obsession#LoadOrCallStopObsessing()
    if exists("g:loaded_obsession")
        :Obsess!
    else
        packadd vim-obsession
        :Obsess!
    endif
endfunction
