nnoremap <silent> <Leader>r :call pking#external_plugins#mdrunner#LoadOrCallVimRunner()<CR>
nnoremap <silent> <Leader>R :call pking#external_plugins#mdrunner#LoadOrCallVimRunnerInsert()<CR>

" === Configuration ===
if !exists('g:markdown_runners')
  let g:markdown_runners = {
        \ '': getenv('SHELL'),
        \ 'go': function('markdown_runner#RunGoBlock'),
        \ 'js': 'node',
        \ 'javascript': 'node',
        \ 'python': 'python3',
        \ 'vim': function('markdown_runner#RunVimBlock'),
        \ }
endif
