function fish_mode_prompt --description 'Displays the current mode'
    switch $fish_bind_mode
        case default
            # bryellow is equal to grey???
            set color bryellow
            set mode 'N'
        case insert
            set color yellow
            set mode 'I'
        case visual
            set color magenta
            set mode 'V'
    end
    # For some reason I have to set the background color for bold to work.
    set_color --bold --background brblack $color
    echo -n "$mode "
    set_color normal
end
