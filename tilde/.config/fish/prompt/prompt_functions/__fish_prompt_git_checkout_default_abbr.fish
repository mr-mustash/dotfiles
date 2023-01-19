function __fish_prompt_git_checkout_default_abbr
    # Set correct abbreviations for default git branch name
    set -l default_branch (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    abbr --add gpom "git pull origin $default_branch"
    abbr --add gcm "git checkout $default_branch"
    abbr --add gdm "git diff $default_branch"
end
