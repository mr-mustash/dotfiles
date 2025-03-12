function __fish_right_prompt_github_user -d "Show the current, active github user."
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        if not set -q __github_user
            if command -q gh
                set -l gh_status (gh auth status -a 2>/dev/null)
                if test $status -eq 0
                    # Extract username using string match
                    set -l user_line (string match -r ".*account ([^ ]+) \(keyring\)" $gh_status)
                    if test -n "$user_line"
                        # Set the global variable
                        set -g __github_user $user_line[2]
                    end
                end
            end
        end
        if set -q __github_user
            echo -ns (set_color normal --bold) "" (set_color normal)
            echo -ns (set_color normal) " $__github_user " (set_color normal)
        end
    end
end
