function! pking#external_plugins#mdrunner#LoadOrCallVimRunner()
    if exists('g:markdown_runner_populate_location_list')
        :MarkdownRunner
    else
        packadd vim-markdown-runner
        :MarkdownRunner
    endif
endfunction

function! pking#external_plugins#mdrunner#LoadOrCallVimRunnerInsert()
    if exists('g:markdown_runner_populate_location_list')
        :MarkdownRunnerInsert
    else
        packadd vim-markdown-runner
        :MarkdownRunnerInsert
    endif
endfunction
