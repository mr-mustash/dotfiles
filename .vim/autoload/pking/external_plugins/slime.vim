" Note: This doesn't work 100% correctly as I can't get it to work on visual
" selection mode. Most of these commands were found in the source code and are
" called directly. Source code is found here: https://github.com/jpalardy/vim-slime/blob/master/plugin/slime.vim
function! pking#external_plugins#slime#LoadOrCallSlimeRegion()
    if exists("g:slime_no_mappings")
        call slime#send_op(visualmode(), 1)
    else
        packadd vim-slime
        call slime#send_op(visualmode(), 1)
    endif
endfunction

function! pking#external_plugins#slime#LoadOrCallSlimeParagraph()
    if exists("g:slime_no_mappings")
        <SID>Operatorip
    else
        packadd vim-slime
        <SID>Operatorip
    endif
endfunction

function! pking#external_plugins#slime#LoadOrCallSlimeConfig()
    if exists("g:slime_no_mappings")
        :SlimeConfig
    else
        packadd vim-slime
        :SlimeConfig
    endif
endfunction
