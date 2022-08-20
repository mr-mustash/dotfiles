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
    " Allow vim-plug to generate its own help file
    Plug 'junegunn/vim-plug'

    " Lua functions
    Plug 'nvim-lua/plenary.nvim'
    Plug 'lewis6991/impatient.nvim'
    Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }

    " Colorshceme
    " Plug 'overcache/NeoSolarized'
    Plug 'mr-mustash/NeoSolarized' "My fork containing patches for Pmenu and FloatBorder

    " Status Line
    Plug 'nvim-lualine/lualine.nvim' | Plug 'arkav/lualine-lsp-progress' | Plug 'kyazdani42/nvim-web-devicons'

    " Movement
    Plug 'tpope/vim-repeat'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb' "https://github.com/jbranchaud/til/blob/ad29a186c389a1d463cee40679d48141181d69e0/vim/open-the-selected-lines-in-github-with-gbrowse.md
    Plug 'lewis6991/gitsigns.nvim'

    " Language server
    Plug 'neovim/nvim-lspconfig' | Plug 'VonHeikemen/lsp-zero.nvim' | Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'williamboman/mason.nvim'| Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

    " Code Hints
    Plug 'wellle/context.vim'
    Plug 'ray-x/lsp_signature.nvim'

    " Undo
    Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

    " Highlighting
    Plug 't9md/vim-quickhl'

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
    Plug 'junegunn/fzf', { 'do': './install --all' } | Plug 'junegunn/fzf.vim'

    " Prose Plugins
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'reedes/vim-pencil'
    Plug 'micarmst/vim-spellsync'
    Plug 'psliwka/vim-dirtytalk', { 'do': ':DirtytalkUpdate' }

    " Filetype specific
    Plug 'tpope/vim-markdown'
    Plug 'rhysd/committia.vim'
    Plug 'dag/vim-fish'
    Plug 'fatih/vim-go',
    Plug 'pearofducks/ansible-vim'
    Plug 'hashivim/vim-terraform'
    Plug 'darfink/vim-plist'
call plug#end()
