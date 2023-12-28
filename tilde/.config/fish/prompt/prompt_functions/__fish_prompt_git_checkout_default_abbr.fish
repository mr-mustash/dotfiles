function __fish_prompt_git_checkout_default_abbr
    set -l __dir (pwd)
    if test -z $__git_prv_dir
        set --global __git_prv_dir (pwd)
    end

    if test $__dir != $__git_prv_dir
        # Set correct abbreviations for default git branch name
        set -l default_branch (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
        abbr --add gpom "git pull origin $default_branch"
        abbr --add gcm "git checkout $default_branch"
        abbr --add gdm "git diff $default_branch"
        set --global __git_prv_dir (pwd)
    end
end
