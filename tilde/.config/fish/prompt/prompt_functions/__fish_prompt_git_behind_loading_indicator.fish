function __fish_prompt_git_loading_indicator -a last_prompt
    echo -n "$last_prompt" | sed -r 's/\x1B\[[0-9;]*[JKmsu]//g' | read -zl uncolored_last_prompt
    echo -ns (set_color brblack)"$uncolored_last_prompt"(set_color normal)
end
