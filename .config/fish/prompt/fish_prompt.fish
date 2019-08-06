function fish_prompt --description 'Write out the prompt'
    # Save the return status of the previous command
    set stat $status

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_normal
            set -g __fish_prompt_normal (set_color normal)
        end

    if not set -q __fish_color_blue
            set -g __fish_color_blue (set_color blue)
        end

    if not set -q __fish_color_green
            set -g __fish_color_green (set_color green)
        end

    if not set -q __fish_color_yellow
            set -g __fish_color_yellow (set_color yellow)
        end

    if not set -q __fish_color_red
            set -g __fish_color_red (set_color red)
        end

    if not set -q __git_cb
        set __git_cb (set_color magenta)" {"(git branch ^/dev/null | grep \* | sed 's/* //')"}"(set_color normal)""
    end

    switch $USER

    case root toor

    if not set -q __fish_prompt_cwd
                if set -q fish_color_cwd_root
                    set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
                else
                    set -g __fish_prompt_cwd (set_color $fish_color_cwd)
                end
            end

    printf '%s@%s %s%s%s# ' $USER (prompt_hostname) "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"

    case '*'

    if not set -q __fish_prompt_cwd
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)
            end

    printf '%s%s%s - [%s%s%s@%s%s%s]%s %s%s %s$ ' "$__fish_color_yellow" (date "+%H:%M:%S") $__fish_prompt_normal "$__fish_color_green" $USER $__fish_prompt_normal "$__fish_color_blue" (prompt_hostname) "$__fish_prompt_normal" "$__git_cb" "$__fish_color_red" (basename $PWD)  "$__fish_prompt_normal"

    end

end
