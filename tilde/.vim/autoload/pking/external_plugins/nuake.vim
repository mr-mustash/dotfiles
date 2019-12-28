function! pking#external_plugins#nuake#LoadOrCallNuake()
    if exists("g:nuake_position")
        :Nuake
    else
        packadd nuake
        let g:nuake_position = "top"
        :Nuake
    endif
endfunction
