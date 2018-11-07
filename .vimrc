" 0 preamble ============================================================== {{{
"
" My .vimrc contains the core configurations of those settings which
" come with Vim and are enumerated by the :options command. The .vim
" directory contains everything else.
" 1) External plugins are managed by vim8's built in package manager
" 2) Custom plugins and external plugin configuraiton are found in the
" plugin directory
" 3) Most of my custom functions are found in the autoload directory
" 4) Anything pertaining to the behavior of a specific filetype, will be
" found in the ftplugin and ftdetect directories.

" ========================================================================= }}}
" 1 important ============================================================= {{{

set nocompatible
if has ("autocmd")
    augroup setNoPasteAfterPaste
        autocmd InsertLeave * set nopaste
    augroup END
endif
set pastetoggle=<F12>

" ========================================================================= }}}
" 2 moving around, searching and patterns ================================= {{{

set incsearch
set regexpengine=1

" ========================================================================= }}}
" 3 tags ================================================================== {{{



" ========================================================================= }}}
" 4 displaying text ======================================================= {{{

set wrap
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list
set numberwidth=2
set number
set relativenumber


" ========================================================================= }}}
" 5 syntax, highlighting and spelling ===================================== {{{

set background=dark

if has ("autocmd")
    filetype plugin indent on
endif

syntax enable
set synmaxcol=120
set hlsearch
colorscheme solarized

if has('termguicolors') && $COLORTERM ==? 'truecolor'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Only display the cursorline on the active buffer.
if has ("autocmd")
    if exists('+cursorline')
        augroup cursorLine
            autocmd!
            autocmd VimEnter,InsertLeave,BufEnter,BufWinEnter * setlocal cursorline
            autocmd WinLeave,InsertEnter,BufLeave,BufWinLeave * setlocal nocursorline
        augroup END
    endif
endif

" Only highlight the 81st character when it's visable on the screen.
highlight ColorColumn ctermbg=170 ctermfg=234
call matchadd('ColorColumn', '\%81v', 100)

set spelllang=en_us

highlight PmenuSel ctermbg=15 ctermfg=197
highlight Pmenu ctermbg=15 ctermfg=217

highlight SearchHighlight ctermfg=3

highlight SpellBad ctermbg=132 ctermfg=7

highlight CursorLineNR cterm=bold ctermfg=3 ctermbg=0

" ========================================================================= }}}
" 6 multiple windows ====================================================== {{{

set laststatus=2
"set hidden
set splitbelow
set splitright

" ========================================================================= }}}
" 7 multiple tab pages ==================================================== {{{


" ========================================================================= }}}
" 8 terminal ============================================================== {{{
" https://www.reddit.com/r/vim/comments/7fqpny/slow_vim_scrolling_and_cursor_moving_in_iterm_and/
set ttyfast


" ========================================================================= }}}
" 9 using the mouse ======================================================= {{{



" ========================================================================= }}}
" 10 GUI ================================================================== {{{



" ========================================================================= }}}
" 11 printing ============================================================= {{{



" ========================================================================= }}}
" 12 messages and info ==================================================== {{{

set ruler
set noshowcmd

" ========================================================================= }}}
" 13 selecting text ======================================================= {{{



" ========================================================================= }}}
" 14 editing text ========================================================= {{{

set undofile
set backspace=2
set showmatch

if exists('&undodir')
    set undodir=~/.vim/local/undo
    if !isdirectory(expand(&undodir))
        call mkdir(expand(&undodir), "p")
    endif
endif

if has("autocmd")
    " Don't create undofiles for files in the following folders.
    augroup noundofolders
        au!
        au BufWritePre /tmp/* setlocal noundofile
        au BufWritePre /run/shm/* setlocal noundofile
    augroup END
endif

" ========================================================================= }}}
" 15 tabs and indenting =================================================== {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent


" ========================================================================= }}}
" 16 folding =t============================================================= {{{



" ========================================================================= }}}
" 17 diff mode ============================================================ {{{



" ========================================================================= }}}
" 18 mapping ============================================================== {{{

let mapleader = "\<Space>"

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" No more arrow keys for you mister.
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Lets save our hands and use jk to leave insert and visual mode.
inoremap <esc> <nop>
inoremap jk <esc>
vnoremap <esc> <nop>
vnoremap jk <esc>

" Remap n and N to use special highlighting function during search.
nnoremap <silent> n  n:call pking#plugins#search#HLNext(0.03)<cr>
nnoremap <silent> N  N:call pking#plugins#search#HLNext(0.03)<cr>

" When in normal mode clear all status when hitting enter.
" Look at ":help map_bar" if you forget that you need to use \| to
" concat all of the commands here.
nnoremap <silent> <CR> :set nospell \| :set nopaste \| :let @/ = "" <CR>

" Window Splitting and Explore
nnoremap <Leader>es :Vexplore<CR>

" Run current line in terminal
nnoremap Q !!sh<CR>

" Make paste better with auto reformatting
noremap p p=`]
noremap P P=`]

" Make it easy to move between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move lines with leader-{j,k}, indent with leader-{h,l}
nnoremap <leader>k :m-2<CR>==
nnoremap <leader>j :m+<CR>==
nnoremap <leader>h <<
nnoremap <leader>l >>

" Enter cmdwindow when pressing : , /, or ?
nnoremap : q:
nnoremap / q/
nnoremap ? q?

" Save a file as sudo
cnoremap w!! w !sudo tee > /dev/null %<CR>

" Toggle line numbers
nnoremap <silent> <Leader>nn :set invnumber invrelativenumber<CR>

" Use C-t to create a new tab and C-g to close it
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-g> :tabclose<CR>


" ========================================================================= }}}
" 19 reading and writing files ============================================ {{{

set fsync


" ========================================================================= }}}
" 20 the swap file ======================================================== {{{

set swapsync=fsync
set updatetime=250

" ========================================================================= }}}
" 21 command line editing ================================================= {{{

set history=5000
set wildmode=list:longest
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildmenu

if has("autocmd")
    augroup cmdwinSettings
        au!
        " No line numbers in the command line window.
        autocmd CmdwinEnter * setlocal nonumber norelativenumber
        " This is a hack to get airline to display correctly when
        " entering the cmd window in insert mode. The first time this is run
        " there will be a brief error that appears, but it will clear quickly.
        autocmd CmdwinEnter *
            \   silent call airline#add_statusline_func('airline#cmdwinenter')
            \ | silent call airline#update_statusline()
        " Automatically enter insert mode when entering the command window
        autocmd CmdwinEnter * startinsert
        " I only want to have to press <C-c> once to exit
        autocmd CmdwinEnter * inoremap <buffer> <C-c> <C-c><C-c>
        autocmd CmdwinEnter * cnoremap <buffer> <C-c> <C-c><C-c>
        autocmd CmdwinEnter * nnoremap <buffer> <C-c> <C-c><C-c>
        " Allow me to run commands from normal mode
        autocmd CmdwinEnter * nnoremap <silent> <buffer> <Cr> i<Cr>
        " No highlighting from current search string
        autocmd CmdwinEnter * setlocal nohlsearch
        autocmd CmdwinLeave * setlocal hlsearch
        " I don't want the buffer to jump around when the cmdwindow opens, so
        " scroll the buffer 8 lines when opening and closing
        " TODO: Fix this
        " autocmd CmdWinEnter * execute "normal! 6<C-e> \| redraw"
        " autocmd CmdWinLeave * execute "normal! 6<C-y> \| redraw"
    augroup END
endif


" ========================================================================= }}}
" 22 executing external commands ========================================== {{{

if &shell =~# 'fish$'
    set shell=bash
endif

" ========================================================================= }}}
" 23 running make and jumping to errors =================================== {{{


" ========================================================================= }}}
" 24 language specific ==================================================== {{{


" ========================================================================= }}}
" 25 multi-byte characters ================================================ {{{

set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" ========================================================================= }}}
" 26 various ============================================================== {{{

if has("autocmd")
    augroup RememberLastView
        au!
        set viewoptions-=options
        autocmd VimLeave,BufLeave *
            \   if expand('%') != '' && &buftype !~ 'nofile'
            \|      mkview
            \|  endif
        autocmd BufRead *
            \   if expand('%') != '' && &buftype !~ 'nofile'
            \|      silent loadview
            \|  endif
    augroup END
endif

set sessionoptions-=blank sessionoptions-=options sessionoptions+=tabpages sessionoptions-=buffers

if exists('&viewdir')
    set viewdir=~/.vim/local/view/
    if !isdirectory(expand(&viewdir))
        call mkdir(expand(&viewdir), "p")
    endif
endif

if exists('g:ctrlp_cache_dir')
    if !isdirectory(expand(g:ctrlp_cache_dir))
        call mkdir(expand(g:ctrlp_cache_dir), "p")
    endif
endif

set viminfo='50,\"5000,h


" Setting up explore to behaive like we expect
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" ========================================================================= }}}
" vim: set fdm=marker fdl=1 :
