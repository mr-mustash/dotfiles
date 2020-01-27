function __fish_prompt_language_vim -d "Display vim version"
    if not test (count *.vim) -gt 0
        return 0
    end

    if ! set -q vim_version
        set -gx vim_version (vim --version | head -n1 | awk '{print $5}')
    end

    echo -ns (set_color $fish_prompt_color_vim_icon) " " (set_color normal)
    echo -ns (set_color --bold) " v$vim_version" (set_color normal)
end
