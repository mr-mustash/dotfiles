function git_checkout_default -d 'git pull origin refs/remotes/origin/HEAD'
    if git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null 1>&2
        set -l default_branch (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
        echo "git checkout $default_branch"
    else
        echo "Not a git directory!"
    end
end
