" === KEY BINDINGS ===

" === CONFIGURATION ===
let g:airline_theme                      = 'solarized'
let g:airline_powerline_fonts            = 1
let g:airline_skip_empty_sections        = 1

let g:airline#extensions#branch#enabled  = '1'
let g:airline#extensions#branch#format   = '2'
let g:airline#extensions#branch#empty_message = 'BRANCH NOT FOUND'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" ===== FUTURE IDEAS =====
" I don't like the basic Obsession extention, lets make it better...
"let g:airline#extensions#obsession#enabled = 0
" ... by building the whole status line ourselves.
"function! CustomStatusline(...)
"    " first variable is the statusline builder
"    let builder = a:1
"
"    " Since we only want add a section, get the default sections definitions
"    let l:airline_section_a  = g:airline_section_a
"    let l:airline_section_b  = get(w:, 'airline_section_b', g:airline_section_b)
"    let l:airline_section_c  = get(w:, 'airline_section_c', g:airline_section_c)
"    let l:airline_section_x  = get(w:, 'airline_section_x', g:airline_section_x)
"    let l:airline_section_y  = get(w:, 'airline_section_y', g:airline_section_y)
"    let l:airline_section_z  = get(w:, 'airline_section_y', g:airline_section_z)
"
"    call builder.add_section('airline_a', l:airline_section_a)
"    call builder.add_section('airline_b', l:airline_section_b)
"    call builder.add_section('airline_c', l:airline_section_c)
"    call builder.split()
"    call builder.add_section('airline_x', l:airline_section_x)
"    call builder.add_section('airline_z', 'Obsessed')
"    call builder.add_section('airline_y', l:airline_section_y)
"    call builder.add_section('airline_z', l:airline_section_z)
"
"    " tell the core to use the contents of the builder
"    return 1
"endfunction
" ... Or we would if we could. The statusline builder is kinda broken right
" now, and the status line doesn't behave as expected when changing to the
" command mode, or displaying nicely padded text for that matter. Keeping the
" above here in case it's all fixed one day.
" call airline#add_statusline_func('CustomStatusline')

"let g:airline#extensions#obsession#enabled = 1
"let g:airline#extensions#obsession#indicator_text = " Obsessed "

"augroup vim_airline
"  autocmd!
"  autocmd SessionLoadPost * AirlineRefresh
"augroup END
