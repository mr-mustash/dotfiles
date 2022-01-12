" Use this function for custom conditions with vim-plug
function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()
    " Colorshceme
    Plug 'overcache/NeoSolarized'

    " Global
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'

    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    Plug 'dense-analysis/ale'

    Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

    Plug 't9md/vim-quickhl'
    Plug 'machakann/vim-highlightedyank'
    Plug 'RRethy/vim-illuminate'

    Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
    Plug 'junegunn/limelight.vim', { 'for': 'markdown' }
    Plug 'reedes/vim-pencil'
    Plug 'micarmst/vim-spellsync'

    Plug 'github/copilot.vim', Cond(has('nvim'))

    Plug 'junegunn/fzf'

    Plug 'voldikss/vim-floaterm'

    "Plug 'neovim/nvim-lspconfig'
    "Plug 'nvim-lua/completion-nvim'
    "Plug 'nvim-lua/lsp-status.nvim'
    "Plug 'nvim-lua/diagnostic-nvim'
    "Plug 'williamboman/nvim-lsp-installer'


    " Filetype specific
    Plug 'rhysd/committia.vim' " Git commit with Vim
    Plug 'lambdalisue/vim-manpager'
    Plug 'tpope/vim-markdown'
    Plug 'cespare/vim-toml'
    Plug 'maralla/vim-toml-enhance'
    Plug 'dag/vim-fish'
    Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
    Plug 'pearofducks/ansible-vim'
    Plug 'hashivim/vim-terraform'
    Plug 'darfink/vim-plist'
call plug#end()
