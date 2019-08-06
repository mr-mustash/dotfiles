function fish_prompt --description 'Write out the prompt'
    # Display the time if we're wide enough
    if test $COLUMNS -gt 132
        set_color $fish_prompt_color_clock
        printf "%s " (date +%T)
        set_color normal
    end

    if not set -q short_hostname
        set -g short_hostname (uname -n | string match -r "[^.]+")
    end

    if set -q SSH_CONNECTION
        echo -ns (set_color $fish_color_host) $short_hostname (set_color normal) ":"
    end

    __fish_prompt_pwd
    __fish_prompt_git
    __fish_prompt_jobs

    set -l glyph "¶"
    echo -ns (set_color $fish_color_user) " $glyph " (set_color normal)
end
