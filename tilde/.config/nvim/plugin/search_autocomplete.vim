autocmd customaugroup CmdlineEnter [/\?] call pking#plugins#search#search_mode_start()
autocmd customaugroup CmdlineLeave [/\?] call pking#plugins#search#search_mode_stop()
