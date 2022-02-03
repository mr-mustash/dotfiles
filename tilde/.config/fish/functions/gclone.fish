function gclone -d "Clone a git repository from anywhere, make the correct directory structure, and cd to it."
    set -l _git_url $argv[1]
    set -l _website (echo "$_git_url" | awk -F '/' '{print $(NF-2)}')
    set -l _username (echo "$_git_url" | awk -F '/' '{print $(NF-1)}')
    set -l _repo (echo "$_git_url" | awk -F '/' '{print $(NF)}' | sed -e 's/.git//')
    set -l _dir "$HOME/dev/$_website/$_username/$_repo"

    mkdir -p "$_dir"
    git clone "$_git_url" "$_dir"

    cd "$_dir"
end
