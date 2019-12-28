function! pking#external_plugins#quickhl#LoadOrCallQuickhlManual()
    if exists("g:loaded_quickhl")
        call quickhl#manual#this("n")
    else
        packadd vim-quickhl
        call quickhl#manual#this("n")
    endif
endfunction

function! pking#external_plugins#quickhl#LoadOrCallQuickhlReset()
    if exists("g:loaded_quickhl")
         :call quickhl#manual#reset()
    else
        packadd vim-quickhl
        :call quickhl#manual#reset()
    endif
endfunction

" TODO: Fix this single function version
"function! LoadOrCallQuickhl (hlcommand)
"    "echo a:hlcommand
"    if exists("g:loaded_quickhl")
"        <Plug>(a:hlcommand)
"    else
"        packadd vim-quickhl
"        <Plug>(a:hlcommand)
"    endif
"endfunction
