function __fish_prompt_hostname -d "Display hostname on remote hosts"
    if not set -q short_hostname
        set -g short_hostname (uname -n | string match -r "[^.]+")
    end

    echo -ns (set_color $fish_color_host) "$short_hostname " (set_color normal)
    echo -ns (set_color --bold) "in " (set_color normal)
end
