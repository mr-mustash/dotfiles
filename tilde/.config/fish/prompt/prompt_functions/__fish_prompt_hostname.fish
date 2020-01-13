function __fish_prompt_hostname -d "Display hostname on remote hosts"
    if not set -q short_hostname
        set -g short_hostname (uname -n | string match -r "[^.]+")
        if test (awk -F/ '$2 == "docker"' /proc/self/cgroup | read) != ""
            set -g short_hostname $short_hostname(echo -ns "(")
            set -g short_hostnaem $short_hostname(echo -ns (set_color $fish_prompt_color_docker_icon) "" (set_color normal))
            set -g short_hostname $short_hostname (echo -ns ") ")
        end
    end

    echo -ns (set_color $fish_color_host) "$short_hostname " (set_color normal)
    echo -ns (set_color --bold) "in " (set_color normal)
end
