command! -nargs=0 -bar Helptags
    \  for p in glob('~/.vim/pack/plugins/opt/*', 1, 1)
    \|     exe 'packadd ' . fnamemodify(p, ':t')
    \| endfor
    \| helptags ALL
