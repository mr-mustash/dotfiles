augroup search_autocomplete
    autocmd!
    autocmd CmdlineEnter [/\?] call pking#plugins#search#search_mode_start()
    autocmd CmdlineLeave [/\?] call pking#plugins#search#search_mode_stop()
augroup END
