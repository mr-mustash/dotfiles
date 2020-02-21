command! -nargs=0 -bar GenHelptags
    \  for p in glob('~/.vim/pack/bundle/opt/*', 1, 1)
    \|     exe 'packadd ' . fnamemodify(p, ':t')
    \| endfor
    \| helptags ALL
