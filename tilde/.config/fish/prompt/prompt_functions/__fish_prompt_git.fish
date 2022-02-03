function __fish_prompt_git
    set -l is_git_repository (command git rev-parse --is-inside-work-tree 2>/dev/null)
    if test -n "$is_git_repository"
        __fish_prompt_git_branch
        __fish_prompt_git_behind
        __fish_prompt_git_status
    end
end
