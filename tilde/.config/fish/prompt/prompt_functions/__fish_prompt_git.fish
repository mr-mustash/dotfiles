function __fish_prompt_git
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l __status (git status --porcelain --branch)
        __fish_prompt_git_branch $__status
        __fish_prompt_git_status $__status
    end
end
