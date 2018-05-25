function! pking#external_plugins#mundo#LoadOrCallMundo()
    if exists("g:loaded_mundo")
        :MundoToggle
    else
        packadd vim-mundo
        :MundoToggle
    endif
endfunction

