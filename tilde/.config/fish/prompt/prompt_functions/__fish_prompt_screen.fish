function __fish_prompt_screen --description 'Helper function for fish_prompt'
    set -l screen_count (screen -ls | egrep -v 'Socket|There is a screen|^[[:space:]]*$' | wc -l)
    if test $screen_count = 0
        return
    end

    set -l sty (echo $STY)
    if test -n "$sty"
        echo -ns (set_color $fish_prompt_color_in_screen) "  " (set_color normal) $screen_count (set_color normal)
    else
        echo -ns (set_color $fish_prompt_color_screen) "  " (set_color normal) $screen_count (set_color normal)
    end
end
