function __fish_prompt_language_fish -d "Display fish version"
    if not test (count *.fish) -gt 0
        return 0
    end

    echo -ns (set_color f66 --bold) " 󰈺" (set_color normal)
    echo -ns (set_color --bold) " v$FISH_VERSION" (set_color normal)
end
