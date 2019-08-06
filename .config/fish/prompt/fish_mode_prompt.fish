function fish_mode_prompt --description 'Displays the current mode'
    switch $fish_bind_mode
        case default
            set_color --bold --background bryellow white
            echo '[N]'
        case insert
            set_color --bold --background yellow white
            echo '[I]'
        case visual
            set_color --bold --background magenta white
            echo '[V]'
    end
    set_color normal
    echo -n ' '
end
