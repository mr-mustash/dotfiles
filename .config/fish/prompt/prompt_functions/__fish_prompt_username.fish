function __fish_prompt_username --description 'Display username on remost host or when root.'
    if test "$LOGNAME" != "$USER" \
    -o "$UID" = "0" \
    -o "$USER" = "root" \
    -o "$SSH_CONNECTION" != ""

        set -l _local_user $USER

        set -l user_color
        if test "$USER" = "root"
            set user_color $fish_color_user_root
        else
            set user_color $fish_color_user
        end

        if test "$SSH_CONNECTION" != ""
            # Only need "@" if we're connected remotely
            set _local_user (echo -ns "$USER" ; set_color normal ; echo -ns "@")
            # Don't display "in" since this will be taken care of by __fish_prompt_hostname when remote
            echo -ns (set_color $user_color) "$_local_user" (set_color normal)
        else
            echo -ns (set_color $user_color) "$_local_user " (set_color normal)
            echo -ns (set_color --bold) "in " (set_color normal)
        end

    end
end
