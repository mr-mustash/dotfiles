autocmd CmdlineEnter [/\?] call pking#plugins#search#search_mode_start()
autocmd CmdlineLeave [/\?] call pking#plugins#search#search_mode_stop()
