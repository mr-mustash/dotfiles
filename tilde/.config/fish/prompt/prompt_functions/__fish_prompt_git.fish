function __fish_prompt_git
    if ps -p $_git_prompt_last_pid >/dev/null
        # We don't need to run more than one of these async at at a time.
        command kill $_git_prompt_last_pid
    end

    if test (command git rev-parse --abbrev-ref @'{u}' 2>/dev/null)
        __fish_prompt_git_branch
        __fish_prompt_git_behind
        __fish_prompt_git_status

    end

    # Set the pid so we can check it on the next time this fires
    # asynchronously.
    set -U _git_prompt_last_pid $fish_pid
end
