function code -d 'List all git repos in $HOME/dev and cd to them'
    set -l _repo (find $HOME/dev -name .git -type d -prune -maxdepth 5 | sed -e 's/.git$//g' | fzf)
    cd $_repo
end
