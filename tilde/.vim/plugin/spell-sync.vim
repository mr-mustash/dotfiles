" Taken from emilyst/home - https://github.com/emilyst/home/blob/b041fe5228f05cb2352b052b4d4f25284deab1cf/.vim/plugin/spell-sync.vim
function! s:RegenerateSpellfiles() abort
  for l:dir in split(globpath(&rtp, 'spell'), '\n')
    for l:wordlist in uniq(split(globpath(l:dir, '*.add'), '\n') + split(&l:spellfile, ','))
      if !filewritable(l:wordlist) | continue | endif

      " sort the contents of the wordlist first
      call writefile(uniq(sort(readfile(l:wordlist), 'i')), l:wordlist)

      let l:spellfile = l:wordlist . '.spl'
      if !filewritable(l:spellfile) | continue | endif

      if getftime(l:wordlist) > getftime(l:spellfile)
        silent execute 'mkspell! ' . fnameescape(l:wordlist)
      endif
    endfor
  endfor
endfunction

" for good measure, try to regenerate on vim startup and exit
if has('autocmd') && !exists('#RegenerateSpellfiles')
  augroup RegenerateSpellfiles
    autocmd!
    autocmd VimEnter,VimLeave * call <SID>RegenerateSpellfiles()
  augroup END
endif
