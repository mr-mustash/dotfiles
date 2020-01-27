#!/usr/local/opt/coreutils/libexec/gnubin/env fish
function __fish_prompt_git_status --description 'Display git info in the fish prompt'
    if not set -q __git_last_dirty_check
        set -g __git_last_dirty_check 0
    end

    set -l current_timestamp (command date +%s)
    set -l time_since_last_dirty_check (math "$current_timestamp - $__git_last_dirty_check")

    if test $time_since_last_dirty_check -gt 2
        # This is here because I'm using `-b` to find dirty branches
        # which means there will always be at least one line here
        # even when the branch is clean.
        # IF THINGS ARE BROKEN CHECK HERE FIRST BECAUSE IT'S ALWAYS
        # THIS GODDAMNED COMMAND AND IT'S EDGE CASES
        set -l cmd "git status --porcelain -b 2>/dev/null | wc -l"
        __run_async "__checking_dirty" __fish_prompt_git_dirty_callback $cmd
    end

    if set -q __git_is_dirty
        echo -ns " "
        echo -ns $__git_is_dirty | tr -d '[:blank:]'
    end

end
