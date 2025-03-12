function __fish_prompt_screen --description 'Helper function for fish_prompt'
    if not set -q __screen_session_count
        set -g __screen_session_count (command screen -ls | egrep -v 'Socket|Sockets|There is a screen|There are screens|^[[:space:]]*$' | wc -l)
    end

    if test $__screen_session_count = 0
        return
    end

    set -l sty (echo $STY)
    if test -n "$sty"
        echo -ns (set_color $fish_prompt_color_in_screen) " 󰊓 " (set_color normal) $__screen_session_count (set_color normal)
    else
        echo -ns (set_color $fish_prompt_color_screen) " 󰊓 " (set_color normal) $__screen_session_count (set_color normal)
    end
end
