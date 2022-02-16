function __fish_prompt_git_behind
    set -l _branch_updates (git rev-list --no-merges --count @{upstream}...@)
    if test $_branch_updates -gt 0
        echo -ns (set_color normal) "("
        echo -ns (set_color $fish_prompt_color_git_behind) "" (set_color normal)
        echo -ns " $_branch_updates"
        echo -ns ")"
    end
end
