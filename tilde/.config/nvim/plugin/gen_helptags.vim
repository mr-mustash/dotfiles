command! -nargs=0 -bar Helptags
    \  for p in glob('/Users/patrickking/.local/share/nvim/plugged/*', 1, 1)
    \|     exe 'packadd ' . fnamemodify(p, ':t')
    \| endfor
    \| helptags ALL
