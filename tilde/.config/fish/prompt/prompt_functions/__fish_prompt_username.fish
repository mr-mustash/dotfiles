function __fish_prompt_username --description 'Display username on remost host or when root.'
    if test "$LOGNAME" != "$USER" \
    -o "$UID" = "0" \
    -o "$USER" = "root" \
    -o "$SSH_CONNECTION" != "" \
    -o "$in_docker" != ""

        set -l user_color
        if test "$USER" = "root"
            set user_color $fish_color_user_root
        else
            set user_color $fish_color_user
        end

        if test "$SSH_CONNECTION" != "" -o "$in_docker" != ""
            echo -ns (set_color $user_color) "$USER " (set_color normal)
            echo -ns (set_color --bold) "on " (set_color normal)
        else
            echo -ns (set_color $user_color) "$USER " (set_color normal)
            echo -ns (set_color --bold) "in " (set_color normal)
        end

    end
end
