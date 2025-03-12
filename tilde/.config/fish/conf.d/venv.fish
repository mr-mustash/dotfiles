function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
    status --is-command-substitution; and return

    # Check if we are inside a git directory
    set -l gitdir (git rev-parse --show-toplevel 2>/dev/null)
    if test $status -eq 0
        set -l cwd (pwd -P)
        # While we are still inside the git directory, find the closest
        # virtualenv starting from the current directory.
        while string match -q "$gitdir*" "$cwd"
            if test -e "$cwd/.venv/bin/activate.fish"
                source "$cwd/.venv/bin/activate.fish" 2>/dev/null
                return
            end
            set cwd (dirname "$cwd")
        end
    end

    # If virtualenv activated but we are not in a git directory, deactivate.
    set -q VIRTUAL_ENV; and deactivate
end
