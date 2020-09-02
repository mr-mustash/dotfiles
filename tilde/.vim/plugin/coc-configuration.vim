" Auto Groups
augroup cocConfiguraiton
    au!
    autocmd CursorHold * silent call CocActionAsync('doHover')
augroup END

" Settings
set pyxversion=3

" Bindings
nnoremap <silent> H :call <SID>show_documentation()<CR>
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Functions
function! s:show_documentation()
  if &filetype ==? 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
