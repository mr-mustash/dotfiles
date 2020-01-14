function fish_prompt --description 'Write out the prompt'
    __fish_prompt_username

    if test "$SSH_CONNECTION" != "" || test -f /proc/self/cgroup
        if test (awk -F/ '$2 == "docker"' /proc/self/cgroup | read) != ""
            __fish_prompt_hostname
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