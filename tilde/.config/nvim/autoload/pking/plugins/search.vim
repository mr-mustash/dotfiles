function! pking#plugins#search#search_mode_start() abort
    cnoremap <tab> <c-f>a<c-n>
    let s:old_complete_opt = &completeopt
    set completeopt-=noinsert
endfunction

function! pking#plugins#search#search_mode_stop() abort
    cunmap <tab>
    let &completeopt = s:old_complete_opt
endfunction

function! pking#plugins#search#HLNext(blinktime) abort
    let c = 1

    while c <= 2
        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#\%('.@/.'\)'
        let ring = matchadd('SearchHighlight', target_pat, 101)
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        call matchdelete(ring)
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        let c += 1
    endwhile

endfunction
