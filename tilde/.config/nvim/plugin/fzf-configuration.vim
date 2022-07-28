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

" === CONFIG ===
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'border': 'rounded'} }

autocmd customaugroup FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" === FUNCTIONS ===
" Use ripgrep to search in files in current directory
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
