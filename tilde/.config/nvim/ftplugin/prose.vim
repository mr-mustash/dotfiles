autocmd customaugroup FileType markdown,mkd,md call pencil#init()
            \ | call pencil#init()
            \ | call ProseSetup()

autocmd customaugroup FileType text,tex
            \ | call pencil#init({'wrap': 'hard'})
            \ | call ProseSetup()

autocmd customaugroup Filetype git,gitsendemail,*commit*,*COMMIT*
            \ | setl expandtab noswapfile noautoindent
            \   call pencil#init({'wrap': 'hard', 'textwidth': 80})
            \ | call ProseSetup()
