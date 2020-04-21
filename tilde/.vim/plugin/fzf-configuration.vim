" === KEY BINDINGS ===
nnoremap <silent><leader>ff :Files<cr>
nnoremap <silent><leader>p  :Files<CR>
nnoremap <silent><leader>fh :Helptags<CR>
nnoremap <silent><leader>fr :RG<CR>
nnoremap <silent><leader>fb :Buffers<cr>
nnoremap <silent><leader>fc :Commands<cr>
nnoremap <silent><leader>fm :Maps<cr>
nnoremap <silent><leader>f: :History:<cr>
nnoremap <silent><leader>ft :Filetypes<cr>

" === CONFIGURATION ===
if isdirectory('/usr/local/opt/fzf/')
    set runtimepath+=/usr/local/opt/fzf/
    source /usr/local/opt/fzf/plugin/fzf.vim
endif

command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

augroup fzf_layout
    au!
    if !exists('g:fzf_layout')
        autocmd! FileType fzf
        autocmd  FileType fzf set laststatus=0 noshowmode noruler
                    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    endif
augroup END

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

" === FUNCTIONS ===
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
