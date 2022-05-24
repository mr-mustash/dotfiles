autocmd customaugroup FileType markdown,mkd,md,tex,text
                    \ | call pencil#init()

autocmd customaugroup Filetype git,gitsendemail,*commit*,*COMMIT*
                    \   call pencil#init({'wrap': 'hard', 'textwidth': 72})
                    \ | setl spell spl=en_us et sw=2 ts=2 noai
