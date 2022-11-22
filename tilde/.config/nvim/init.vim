" preamble ============================================================== {{{

" My .vimrc contains the core configurations of those settings which
" come with Vim and are enumerated by the :options command. The .vim
" directory contains everything else.
" 1) External plugins are managed by vim8's built in package manager
" 2) Custom plugins and external plugin configuration are found in the
" plugin directory
" 3) Most of my custom functions are found in the autoload directory
" 4) Anything pertaining to the behavior of a specific filetype, will be
" found in the ftplugin and ftdetect directories.

" ========================================================================= }}}
" 0 global setup ========================================================== {{{

" Creating an autogroup to add to all of my autocommands. This allows me to
" add autocmds without having to create a new augroup that wraps each
" autocommand in an augroup.
" https://gist.github.com/romainl/6e4c15dfc4885cb4bd64688a71aa7063#protip
augroup customaugroup
    autocmd!
augroup END

let g:configdir = expand(stdpath('config'))
let g:datadir = expand(stdpath('data'))

:execute 'source '.fnameescape(g:configdir . '/plug.vim')

" Speed up nvim startup time https://github.com/lewis6991/impatient.nvim
lua require('impatient')

" ========================================================================= }}}
" 1 important ============================================================= {{{

autocmd customaugroup InsertLeave * set nopaste

" ========================================================================= }}}
" 2 moving around, searching and patterns ================================= {{{

set incsearch
set regexpengine=1

" ========================================================================= }}}
" 3 tags ================================================================== {{{


" ========================================================================= }}}
" 4 displaying text ======================================================= {{{

set wrap
"vint: -ProhibitUnnecessaryDoubleQuote
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
"vint: +ProhibitUnnecessaryDoubleQuote
set list
set numberwidth=2
set number
set relativenumber


" ========================================================================= }}}
" 5 syntax, highlighting and spelling ===================================== {{{

set background=dark

filetype plugin indent on

syntax enable
set hlsearch

" Load custom highlights after colorscheme is loaded
" https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
function! MyHighlights() abort
    " Only highlight the 121st character when it's visible on the screen.
    highlight ColorColumn guibg=#e75480 guifg=#b58900
    let g:noColumnHighlight = ['man', 'fzf']
    autocmd customaugroup Filetype * if index(g:noColumnHighlight, &ft) == -1 | call matchadd('ColorColumn', '\%121v',100) | endif

    highlight SearchHighlight ctermfg=3
    highlight CursorLineNR    cterm=bold guifg=#b58900
    highlight CursorLine      cterm=none ctermbg=0 ctermfg=none
    highlight SignColumn      guibg=#073642

    highlight SpellBad   ctermbg=7 guifg=#ef3b3b
    highlight SpellLocal ctermbg=7 guifg=#ef3b3b
    highlight SpellRare  ctermbg=7 guifg=#ef3b3b
    highlight SpellCap   ctermbg=7 guifg=#ef3b3b

    highlight GitGutterDelete guifg=#dc322f guibg=#073642
    highlight GitGutterAdd    guifg=#859900 guibg=#073642
    highlight GitGutterChange guifg=#b58900 guibg=#073642
endfunction

autocmd customaugroup ColorScheme * call MyHighlights()

set termguicolors

let g:neosolarized_vertSplitBgTrans = 0
let g:neosolarized_italic = 0
let g:neosolarized_termBoldAsBright = 0
colorscheme NeoSolarized

" Only display the cursorline on the active buffer.
autocmd customaugroup VimEnter,InsertLeave,BufEnter,BufWinEnter * setlocal cursorline
autocmd customaugroup WinLeave,InsertEnter,BufLeave,BufWinLeave * setlocal nocursorline

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

if has('termguicolors') && $COLORTERM ==? 'truecolor'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if has('termguicolors')
    set t_Co=256
endif


" ========================================================================= }}}
" 9 using the mouse ======================================================= {{{



" ========================================================================= }}}
" 10 GUI ================================================================== {{{



" ========================================================================= }}}
" 11 printing ============================================================= {{{



" ========================================================================= }}}
" 12 messages and info ==================================================== {{{

set noshowcmd

" ========================================================================= }}}
" 13 selecting text ======================================================= {{{



" ========================================================================= }}}
" 14 editing text ========================================================= {{{

set undofile
set backspace=2
set showmatch

let &undodir = g:datadir . '/undo'

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), 'p')
endif

" Don't create undofiles for files in the following folders.
au customaugroup BufWritePre /tmp/* setlocal noundofile
au customaugroup BufWritePre /run/shm/* setlocal noundofile

" TODO: Fix this so it works everywhere. Currently overwritten in some files,
" most likely by vim-pencil or another plugin.
set textwidth=80 " Wrap comments at 80 characters
set formatoptions=caqlj " options defined in :h fo-table

if has('nvim')
    set completeopt=menu,menuone,noselect,noinsert
else
    set completeopt=menu,menuone,popup,noselect,noinsert
endif

" ========================================================================= }}}
" 15 tabs and indenting =================================================== {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" ========================================================================= }}}
" 16 folding ============================================================== {{{



" ========================================================================= }}}
" 17 diff mode ============================================================ {{{



" ========================================================================= }}}
" 18 mapping ============================================================== {{{

let g:mapleader = "\<Space>"

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" nvim made this default in 0.6.0
if !has('nvim')
    " make Y consistent with C and D.
    nnoremap Y y$
end

" Lets save our hands and use jk to leave insert and visual mode.
inoremap <esc> <nop>
inoremap jk <esc>
" vnoremap <esc> <nop>
" vnoremap jk <esc>

" Remap n and N to use special highlighting function during search.
nnoremap <silent> n  nzz:call pking#plugins#search#HLNext(0.03)<cr>
nnoremap <silent> N  Nzz:call pking#plugins#search#HLNext(0.03)<cr>

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

" Align text to 80 column in current selection
vnoremap <silent> <leader>a gq

" ========================================================================= }}}
" 19 reading and writing files ============================================ {{{
set fsync


" ========================================================================= }}}
" 20 the swap file ======================================================== {{{
"
if !has('nvim')
    set swapsync=fsync
endif
set updatetime=500

" ========================================================================= }}}
" 21 command line editing ================================================= {{{

set history=5000
set wildmode=list:longest
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildmenu

" No line numbers or signs in the command line window.
autocmd customaugroup CmdwinEnter * setlocal nonumber norelativenumber signcolumn=no
" Automatically enter insert mode when entering the command window
autocmd customaugroup CmdwinEnter * startinsert
" I only want to have to press <C-c> once to exit
autocmd customaugroup CmdwinEnter * inoremap <buffer> <C-c> <C-c><C-c>
autocmd customaugroup CmdwinEnter * cnoremap <buffer> <C-c> <C-c><C-c>
autocmd customaugroup CmdwinEnter * nnoremap <buffer> <C-c> <C-c><C-c>
" Allow me to run commands from normal mode
autocmd customaugroup CmdwinEnter * nnoremap <silent> <buffer> <Cr> i<Cr>
" No highlighting from current search string
autocmd customaugroup CmdwinEnter * setlocal nohlsearch
autocmd customaugroup CmdwinLeave * setlocal hlsearch
" I don't want the buffer to jump around when the cmdwindow opens, so
" scroll the buffer 8 lines when opening and closing
" TODO: Fix this
" autocmd CmdWinEnter * execute "normal! 6<C-e> \| redraw"
" autocmd CmdWinLeave * execute "normal! 6<C-y> \| redraw"


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

" vint: next-line -ProhibitMissingScriptEncoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" ========================================================================= }}}
" 26 various ============================================================== {{{

" Skip vim internal buffers
let g:internal_buffers = [
        \ '[Command Line]',
        \ '[Input]',
        \ '[Messages]',
        \ '[Popup]',
        \ '[Quickfix]',
        \ '[Signs]',
        \ '[Status Line]',
        \ '[Termcap]',
        \ '[Terminal]',
        \ '[Undo]',
        \ 'option-window',
        \ 'NetrwTreeListing',
        \ 'NetrwTree',
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
    if index(g:internal_buffers, expand('%')) >= 0
        " File is in skip list
        return 0
    endif
    return 1
endfunction

" Autosave & Load Views.
autocmd customaugroup BufWritePost,BufLeave ?* nested if MakeViewCheck() | silent! mkview | endif
autocmd customaugroup BufWinEnter           ?* nested if MakeViewCheck() | silent! loadview | endif

set sessionoptions-=blank sessionoptions-=options sessionoptions+=tabpages sessionoptions-=buffers

let &viewdir = g:datadir . '/view'

if !isdirectory(expand(&viewdir))
    call mkdir(expand(&viewdir), 'p')
endif

set viminfo='50,\"5000,h,/0

" Setting up explore to behaive like we expect
let g:netrw_banner = 0
let g:netrw_liststyle = 3

set signcolumn=auto:1-3

autocmd customaugroup VimEnter * echo "<^.^>"

" ========================================================================= }}}
" 26 neovim  ============================================================== {{{
set guicursor=

lua << EOF
    require('plugin.mason-config')
    require('plugin.lsp-zero-config')
    require('plugin.lsp_lines-config')
    require('plugin.null-ls-config')
    require('plugin.lspconfig-config')
    require('plugin.lualine-config')
    require('plugin.gitsigns-config')
    require('plugin.mini-config')
    require('plugin.lsp-signature-config')
EOF
" ========================================================================= }}}
" vim: set foldmethod=marker foldlevel=99 foldlevelstart=99
