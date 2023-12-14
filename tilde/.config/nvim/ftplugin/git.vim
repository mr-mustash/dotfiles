autocmd customaugroup Filetype git,gitsendemail,*commit*,*COMMIT* call pencil#init({'wrap': 'hard', 'textwidth': 80})
            \ | setl expandtab noswapfile noautoindent
            \ | call ProseSetup()
