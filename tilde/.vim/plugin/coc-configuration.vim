augroup cocConfiguraiton
    au!
    autocmd CursorHold * silent call CocActionAsync('doHover')
augroup END

nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype ==? 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
