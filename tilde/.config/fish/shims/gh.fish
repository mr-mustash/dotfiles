function gh --wraps gh -d 'Unset __github_user every time we run gh'
    set -e __github_user
    command gh $argv
end
