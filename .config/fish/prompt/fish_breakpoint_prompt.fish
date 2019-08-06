function fish_breakpoint_prompt --description 'A prompt to be used when `breakpoint` is executed'
    set -l last_exit $status
    set -l glyph 'Ϟ'

    set -l function (status -L0 function)

    if test -z "$function" -o "$function" = 'Not a function'
        set function 'main'
    end

    if test $last_exit -ne 0
        set_color $fish_color_error
    else
        set_color $fish_color_status
    end
    echo -n $glyph

    set_color $fish_color_dimmed
    echo -n " $function() "

    echo -ns (set_color $fish_color_status) "»" (set_color normal) " "
end

