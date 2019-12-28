" === DESCRIPTION ===
" This is a meta plugin for any time I'm editing prose. It sets up the
" configuration for vim-wordy and vim-pencil inside the Prose function call.

" === KEY BINDINGS ===

" === CONFIGURATION ===
autocmd FileType markdown,mkd,md,tex,text call pking#plugins#prose#Prose()
