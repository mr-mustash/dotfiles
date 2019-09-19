function fish_prompt --description 'Write out the prompt'
    # This is a total hack to make the git staus async
    # from the rest of the prompt because it can
    # sometimes take a really long time to return.
    # Right now it doesn't work totally because for some
    # reason every time I'm in a git directory this just fires
    # off constantly. Still trying to figure out why.
    #set -l updated_status (eval echo "\$prompt_$fish_pid")
    #$HOME/.config/fish/prompt/prompt_functions/__fish_prompt_git_status.fish $fish_pid &

    __fish_prompt_username
    if test "$SSH_CONNECTION" != ""
        __fish_prompt_hostname
    end

    # If we're inside a docker container display the hostname as well
    if test -e /proc/self/cgroup
        if test (awk -F/ '$2 == "docker"' /proc/self/cgroup | read) != ""
            __fish_prompt_hostname
            echo -ns "("
            echo -ns (set_color $fish_prompt_color_docker_icon) "" (set_color normal)
            echo -ns ") "
        end
    end

    __fish_prompt_pwd

    set -l git_working_tree (command git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$git_working_tree"
        __fish_prompt_git_branch
        __fish_prompt_git_status
        __fish_prompt_git_autofetch
    end

    __fish_prompt_languages
    __fish_prompt_jobs

    set -l glyph "➜"
    echo -ns (set_color $fish_color_user) " $glyph " (set_color normal)
end
