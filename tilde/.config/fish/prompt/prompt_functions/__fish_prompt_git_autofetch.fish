function __fish_prompt_git_autofetch
    if test ! (command git rev-parse --abbrev-ref @'{u}' 2>/dev/null)
      return 0
    end

    set -l git_fetch_required 0

    if test -e .git/FETCH_HEAD
        set -l last_fetch_timestamp (command stat -f "%m" .git/FETCH_HEAD)
        set -l current_timestamp (date +%s)
        set -l time_since_last_fetch (math "$current_timestamp - $last_fetch_timestamp")

        if test $time_since_last_fetch -gt 600 # seconds
            set git_fetch_required 1
        end
    else
        set git_fetch_required 0
    end

    if test $git_fetch_required -eq 0
      return 0
    end

    set -l cmd "env GIT_TERMINAL_PROMPT=0 git -c gc.auto=0 fetch > /dev/null 2>&1"
    __run_async "__git_fetching" __update_prompt $cmd

end
