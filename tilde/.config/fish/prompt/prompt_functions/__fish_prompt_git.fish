function __fish_prompt_git
    if test (command git rev-parse --abbrev-ref @ 2>/dev/null)
        set -l __status (git status --porcelain --branch)
        __fish_prompt_git_branch $__status
        __fish_prompt_git_status $__status
        __fish_prompt_git_checkout_default_abbr
    else
        set -e __git_current_dir
    end
end
