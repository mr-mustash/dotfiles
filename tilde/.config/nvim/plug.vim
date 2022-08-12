" Use this function for custom conditions with vim-plug
function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&runtimepath, trim(g:plugs[a:name].dir, '/')) >= 0)
endfunction

call plug#begin()
    " Lua functions
    Plug 'nvim-lua/plenary.nvim'
    Plug 'lewis6991/impatient.nvim'

    " Colorshceme
    Plug 'overcache/NeoSolarized'

    " Status Line
    Plug 'nvim-lualine/lualine.nvim'

    " Movement
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'godlygeek/tabular'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb' "https://github.com/jbranchaud/til/blob/ad29a186c389a1d463cee40679d48141181d69e0/vim/open-the-selected-lines-in-github-with-gbrowse.md
    Plug 'lewis6991/gitsigns.nvim'

    " Language server
    Plug 'neovim/nvim-lspconfig'
    Plug 'VonHeikemen/lsp-zero.nvim'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
    Plug 'jose-elias-alvarez/null-ls.nvim'

    " Code Visualization
    Plug 'wellle/context.vim'

    " Undo
    Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

    " Highlighting
    Plug 't9md/vim-quickhl'
    Plug 'machakann/vim-highlightedyank'
    Plug 'RRethy/vim-illuminate'

    " Prose Plugins
    Plug 'tpope/vim-markdown'
    Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
    Plug 'junegunn/limelight.vim', { 'for': 'markdown' }
    Plug 'reedes/vim-pencil'
    Plug 'micarmst/vim-spellsync'
    Plug 'psliwka/vim-dirtytalk', { 'do': ':DirtytalkUpdate' }

    " All of this is here so that we do not load Copilot for specific
    " directories. Add more lines to the NoCopilot augroup to exclude more
    " directories.
    Plug 'github/copilot.vim', Cond(has('nvim'), { 'on': [] })
    augroup NoCopilot
        autocmd!
        autocmd VimEnter */dev/gitlab.com/replicant-ai* autocmd! LoadCopilot
    augroup END

    augroup LoadCopilot
        autocmd!
        autocmd VimEnter * call plug#load('copilot.vim')
    augroup END

    " Fuzzy Finding
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Filetype specific
    Plug 'rhysd/committia.vim', { 'for': 'gitcommit' }
    Plug 'dag/vim-fish'
    Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
    Plug 'pearofducks/ansible-vim'
    Plug 'hashivim/vim-terraform'
    Plug 'darfink/vim-plist'
call plug#end()
