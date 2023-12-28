function __fish_prompt_git_status --description 'Display git info in the fish prompt'
    set -l index $argv
    if test (count $index) -gt 1 # gt 1 because of `# main...origin/main` line
        set -l icon_untracked "?"
        set -l icon_added "+"
        set -l icon_modified "~"
        set -l icon_renamed "»"
        set -l icon_deleted -
        set -l icon_stashed "\$"
        set -l icon_unmerged "<>"
        set -l icon_diverged "↕"
        set -l icon_ahead "⇡"
        set -l icon_behind "⇣"
        set -l icon_clean "√"

        set -l GIT_PROMPT_ORDER untracked added modified renamed deleted stashed unmerged diverged ahead behind
        set -l trimmed_index (string split \n $index | string sub --start 1 --length 2)

        for i in $trimmed_index
            if test (string match '\?\?' $i)
                set git_status untracked $git_status
            else if test (string match '*A*' $i)
                set git_status added $git_status
            else if test (string match '*M*' $i)
                set git_status modified $git_status
            else if test (string match '*R*' $i)
                set git_status renamed $git_status
            else if test (string match '*D*' $i)
                set git_status deleted $git_status
            else if test (string match '*U*' $i)
                set git_status unmerged $git_status
            end
        end

        # Check whether the branch is ahead
        if test (string match '*ahead*' $index)
            set is_ahead true
        end

        # Check whether the branch is behind
        if test (string match '*behind*' $index)
            set is_behind true
        end

        # Check whether the branch has diverged
        if test "$is_ahead" = true -a "$is_behind" = true
            set git_status diverged $git_status
        else if test "$is_ahead" = true
            set git_status ahead $git_status
        else if test "$is_behind" = true
            set git_status behind $git_status
        end

        for i in $GIT_PROMPT_ORDER
            if contains $i in $git_status
                set -l status_color (echo fish_prompt_color_git_$i)
                set -l full_color "$$status_color"

                set -l status_symbol icon_$i
                set -l full_status_symbol "$$status_symbol"
                set -l status_with_color (set_color $full_color --bold; echo $full_status_symbol ; set_color normal)

                set full_git_status "$full_git_status$status_with_color"

            end
        end

        set -l status_trimmed (echo $full_git_status | tr -d '[:blank:]')
        echo -ns " [$status_trimmed]"
    end


end
