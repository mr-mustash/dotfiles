function __fish_right_prompt_wall_time
    # If either pre or post time is set, display the time
    if set -q __wall_clock_time_pre || set -q __wall_clock_time_post
        set_color $fish_prompt_color_clock
        echo "$__wall_clock_time_pre - $__wall_clock_time_post"
        set_color normal
    end
    # After displaying the time clear both variables. This prevents the previous
    # commands time from being displayed on the next prompt if it's empty.
    #if set -q __wall_clock_time_pre && set -q __wall_clock_time_post
    #    set -e __wall_clock_time_pre
    #    set -e __wall_clock_time_post
    #end
end
