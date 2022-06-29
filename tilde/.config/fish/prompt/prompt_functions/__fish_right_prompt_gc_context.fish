function __fish_right_prompt_gc_context -d "Show the kubectl current context after running the `k` alias"

    echo -ns (set_color $fish_prompt_color_gc) "" (set_color normal)
    echo -ns (set_color --bold) " $__gproject" / "$__gzone " (set_color normal)
end
