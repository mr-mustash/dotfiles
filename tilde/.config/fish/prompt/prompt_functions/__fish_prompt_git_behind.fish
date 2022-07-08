function __fish_prompt_git_behind
    # Testing to see if a remote branch exists. This is important because in
    # __fish_prompt_git_, we only check for the existence of a local branch.
    if test (command git rev-parse --abbrev-ref @'{u}' 2>/dev/null)
        set -l _branch_updates (git rev-list --no-merges --count @{upstream}...@)
        if test $_branch_updates -gt 0
            echo -ns (set_color normal) "("
            echo -ns (set_color $fish_prompt_color_git_behind) "" (set_color normal)
            echo -ns " $_branch_updates"
            echo -ns ")"
        end
    end
end
