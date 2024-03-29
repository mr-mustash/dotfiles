function __fish_right_prompt_git_autofetch
    if test ! (command git rev-parse --abbrev-ref @'{u}' 2>/dev/null)
        return 0
    end

    if test -e .git/FETCH_HEAD
        set -l last_fetch_timestamp (command stat -c "%Y" .git/FETCH_HEAD)
        set -l current_timestamp (date +%s)
        set -l time_since_last_fetch (math "$current_timestamp - $last_fetch_timestamp")

        if test $time_since_last_fetch -gt 600
            env GIT_TERMINAL_PROMPT=0 git -c gc.auto=0 fetch >/dev/null 2>&1 && touch .git/FETCH_HEAD
        end
    end
end
