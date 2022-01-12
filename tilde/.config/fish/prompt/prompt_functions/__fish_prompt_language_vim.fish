function __fish_prompt_language_vim -d "Display vim version"
    if not test (count *.vim) -gt 0
        return 0
    end

    if ! set -q vim_version
        if in-path nvim
            set -gx vim_version (nvim --version | head -n 1 | cut -d ' ' -f 2 | cut -d '-' -f 1)
        else
            set -gx vim_version (vim --version | head -n 1 | cut -d ' ' -f 5)
            set -gx vim_version "v$vim_version"
        end
    end

    echo -ns (set_color $fish_prompt_color_vim_icon) " " (set_color normal)
    echo -ns (set_color --bold) " $vim_version" (set_color normal)
end
