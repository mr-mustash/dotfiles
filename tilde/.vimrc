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
if has ('autocmd')
    augroup setNoPasteAfterPaste
        au!
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

if has ('autocmd')
    filetype plugin indent on
endif

syntax enable
set synmaxcol=120
set hlsearch

function! MyHighlights() abort
    " Why this exists: https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f

    " Only highlight the 81st character when it's visable on the screen.
    highlight ColorColumn guibg=#e75480 guifg=#FFFFFF
    augroup NoColorColInMan
        autocmd!
        autocmd Filetype * if &ft!="man" | call matchadd('ColorColumn', '\%81v',100) | endif
    augroup END

    " Other highlights
    highlight PmenuSel cterm=bold guifg=#ffb6c1 guibg=#e75480
    highlight Pmenu cterm=none guifg=#e75480 guibg=#ffb6c1
    highlight SearchHighlight ctermfg=3
    highlight SpellBad ctermbg=7 ctermfg=none
    highlight CursorLineNR cterm=bold guifg=#b58900
    highlight CursorLine cterm=none ctermbg=0 ctermfg=none
    highlight SignColumn guibg=#073642

    highlight GitGutterAdd    guifg=#859900 guibg=#073642
    highlight GitGutterChange guifg=#b58900 guibg=#073642
    highlight GitGutterDelete guifg=#dc322f guibg=#073642
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

set termguicolors

let g:neosolarized_vertSplitBgTrans = 0
let g:neosolarized_italic = 1
let g:neosolarized_termBoldAsBright = 0
colorscheme NeoSolarized

if has('termguicolors') && $COLORTERM ==? 'truecolor'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Only display the cursorline on the active buffer.
if has ('autocmd')
    if exists('+cursorline')
        augroup cursorLine
            autocmd!
            autocmd VimEnter,InsertLeave,BufEnter,BufWinEnter * setlocal cursorline
            autocmd WinLeave,InsertEnter,BufLeave,BufWinLeave * setlocal nocursorline
        augroup END
    endif
endif


set spelllang=en_us


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
        call mkdir(expand(&undodir), 'p')
    endif
endif

if has('autocmd')
    " Don't create undofiles for files in the following folders.
    augroup noundofolders
        au!
        au BufWritePre /tmp/* setlocal noundofile
        au BufWritePre /run/shm/* setlocal noundofile
    augroup END
endif

set completeopt=menu,menuone,popup,noselect,noinsert

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

" Lets save our hands and use jk to leave insert and visual mode.
inoremap <esc> <nop>
inoremap jk <esc>
" vnoremap <esc> <nop>
" vnoremap jk <esc>

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

" Resize windwos with Animate.vim
nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(10)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(-10)<CR>

" Move lines with leader-{j,k}, indent with leader-{h,l}
nnoremap <leader>k :m-2<CR>==
nnoremap <leader>j :m+<CR>==
nnoremap <leader>h <<
nnoremap <leader>l >>

" Enter cmdwindow when pressing : , /, or ?
nnoremap : q:
nnoremap / q/
nnoremap ? q?
"map /  <Plug>(incsearch-forward)
"map ?  <Plug>(incsearch-backward)
"map g/ <Plug>(incsearch-stay)


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

if has('autocmd')
    augroup cmdwinSettings
        au!
        " No line numbers in the command line window.
        autocmd CmdwinEnter * setlocal nonumber norelativenumber
        " This is a hack to get airline to display correctly when
        " entering the cmd window in insert mode. The first time this is run
        " there will be a brief error that appears, but it will clear quickly.
        "autocmd CmdwinEnter *
        "            \   silent call airline#add_statusline_func('airline#cmdwinenter')
        "            \ | silent call airline#update_statusline()
        autocmd CmdwinEnter * silent call airline#update_statusline()
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
    set shell=fish
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

if has('autocmd')
    let g:skipview_files = [
            \ '[Command Line]'
            \ ]
    function! MakeViewCheck()
        if has('quickfix') && &buftype =~# 'nofile'
            " Buffer is marked as not a file
            return 0
        endif
        if &buftype ==# 'nofile' && &filetype ==# 'vim'
            " Buffer is marked as not a file
            return 0
        endif
        if empty(glob(expand('%:p')))
            " File does not exist on disk
            return 0
        endif
        if len($TEMP) && expand('%:p:h') == $TEMP
            " We're in a temp dir
            return 0
        endif
        if len($TMP) && expand('%:p:h') == $TMP
            " Also in temp dir
            return 0
        endif
        if index(g:skipview_files, expand('%')) >= 0
            " File is in skip list
            return 0
        endif
        return 1
    endfunction

    augroup vimrcAutoView
        autocmd!
        " Autosave & Load Views.
        autocmd BufWritePost,BufLeave ?* nested if MakeViewCheck() | silent! mkview | endif
        autocmd BufWinEnter ?* nested if MakeViewCheck() | silent! loadview | endif
    augroup end
endif

set sessionoptions-=blank sessionoptions-=options sessionoptions+=tabpages sessionoptions-=buffers

if exists('&viewdir')
    set viewdir=~/.vim/local/view/
    if !isdirectory(expand(&viewdir))
        call mkdir(expand(&viewdir), 'p')
    endif
endif

set viminfo='50,\"5000,h,/0

" Setting up explore to behaive like we expect
let g:netrw_banner = 0
let g:netrw_liststyle = 3

augroup hellocat
    au!
    autocmd VimEnter * echo "<^.^>"
augroup END


" ========================================================================= }}}
" vim: set fdm=marker fdl=1 :
