function __fish_prompt_git_behind
    if test ! (command git rev-parse --abbrev-ref @'{u}' 2>/dev/null)
        return 0
    end

    set -l _local_branch_name (command git rev-parse --abbrev-ref @)
    set -l _remote_branch_name (command git rev-parse --abbrev-ref @{u})

    set -l _branch_updates (git log --no-merges  --oneline --no-show-signature $_local_branch_name..$_remote_branch_name | wc -l)
    if test $_branch_updates -gt 0
        echo -ns (set_color normal) "("
        echo -ns (set_color $fish_prompt_color_git_behind) "" (set_color normal)
        echo -ns " $_branch_updates"
        echo -ns ")"
    end
end
