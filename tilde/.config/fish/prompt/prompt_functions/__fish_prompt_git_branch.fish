function __fish_prompt_git_branch --description "Display git the git branch name"
    # Fail if we don't have git installed
    in-path git
    or return 0

    # Fail if we're not inside a git repo
    set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
    or return 0

    set -l git_branch (git branch | grep '^*' | awk '{print $2}')
    or return 0

    # If the branch name is too long take out the '/u/pking/'
    set -l max (math "round($COLUMNS / 8)") # maximum length = 1/8rd window width
    set -l git_branch_length (string length $git_branch)

    if test $git_branch_length -gt $max
        set git_branch (echo $git_branch | sed -e 's/u\/[a-zA-Z0-9]*\///')
        set git_branch (echo "../$git_branch")
    end

    echo -ns (set_color --bold) " on" (set_color normal)
    set_color $fish_prompt_color_git_branch --bold
    echo -ns "  $git_branch"

    set_color normal
end
