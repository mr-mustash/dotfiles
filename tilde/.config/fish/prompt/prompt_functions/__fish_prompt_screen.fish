function __fish_prompt_screen --description 'Helper function for fish_prompt'
    set -l screen_count (screen -ls | egrep -v 'Socket|There is a screen|^[[:space:]]*$' | wc -l)
    if test $screen_count = 0
        return
    end

    set -l sty (echo $STY)
    if test -n "$sty"
        echo -ns (set_color $fish_prompt_color_in_screen) "  $screen_count"
    else
        echo -ns (set_color $fish_prompt_color_screen) "  $screen_count"
    end
end
