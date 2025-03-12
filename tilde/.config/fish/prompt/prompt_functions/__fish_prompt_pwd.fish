function __fish_prompt_pwd --description 'Format the current directory for the prompt'
    if not set -q __fish_prompt_pwd_string
        # Avoid repeated string operations by using a more direct approach
        set -l path_str
        if string match -q "$HOME/*" "$PWD"
            set path_str "~"(string sub -s (math 1 + (string length "$HOME")) "$PWD")
        else if test "$PWD" = "$HOME"
            set path_str "~"
        else
            set path_str "$PWD"
        end

        # Calculate max length
        set -l max (math "round($COLUMNS/6)")

        # Quick return for short paths
        if test (string length -- $path_str) -le $max
            echo -ns (set_color $fish_color_cwd --bold) $path_str (set_color normal)
            return
        end

        # Split path into components only once
        set -l components (string split / $path_str)
        set -l num_components (count $components)
        set -l truncated
        set -l current_len 0
        set -l i $num_components

        # Process components from end until we hit length limit
        while test $i -gt 0
            set -l component $components[$i]
            set -l component_len (string length -- $component)

            # Add 1 for the slash unless it's the first component
            if test -n "$truncated"
                set component_len (math $component_len + 1)
            end

            if test (math $current_len + $component_len) -gt $max
                break
            end

            if test -n "$truncated"
                set truncated "$component/$truncated"
            else
                set truncated $component
            end

            set current_len (math $current_len + $component_len)
            set i (math $i - 1)
        end

        # Add ellipsis if we didn't use all components
        if test $i -gt 0
            set __fish_prompt_pwd_string "…/$truncated"
        end
    end

    echo -ns (set_color $fish_color_cwd --bold) $__fish_prompt_pwd_string (set_color normal)
end
