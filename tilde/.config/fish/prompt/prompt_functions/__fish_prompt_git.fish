function __fish_prompt_git
    if test (command git rev-parse --abbrev-ref @ 2>/dev/null)
        __fish_prompt_git_branch
        __fish_prompt_git_status
        __fish_prompt_git_checkout_default_abbr
    end
end
