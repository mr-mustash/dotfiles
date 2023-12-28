function gclone -d "Clone a git repository from anywhere, make the correct directory structure, and cd to it."
    if in-path url-parser
        set -l _git_url $argv[1]
        set -l _website (url-parser --url "$_git_url" host)
        set -l _path (url-parser --url "$_git_url" path | awk '{sub("/[^/]*$","")} 1')
        set -l _repo (echo "$_git_url" | awk -F '/' '{print $(NF)}' | sed -e 's/.git//')
        set -l _dir "$HOME/dev/$_website/$_path/$_repo"

        if test -d "$_dir"
            echo -s (set_color $fish_color_error) WARNING (set_color normal) ": $_dir already exists. Changing directory to it."
            cd "$_dir"
            return
        else
            mkdir -p "$_dir"
            git clone "$_git_url" "$_dir"
        end

        cd "$_dir"
    else
        echo -s (set_color $fish_color_error) WARNING (set_color normal) ": failing back to a less robust implementation of gclone."
        echo -e "Please install build and install url-parser from https://github.com/thegeeklab/url-parser"

        set -l _git_url $argv[1]
        set -l _website (echo "$_git_url" | awk -F '/' '{print $(NF-2)}')
        set -l _username (echo "$_git_url" | awk -F '/' '{print $(NF-1)}')
        set -l _repo (echo "$_git_url" | awk -F '/' '{print $(NF)}' | sed -e 's/.git//')
        set -l _dir "$HOME/dev/$_website/$_username/$_repo"

        mkdir -p "$_dir"
        git clone "$_git_url" "$_dir"

        cd "$_dir"
    end
end
