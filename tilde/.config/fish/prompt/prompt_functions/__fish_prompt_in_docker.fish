function __fish_prompt_in_docker -d "Display hostname inside docker container"
    if not set -q in_docker
        if test -d /proc/self
            if test (awk -F/ '$2 == "docker"' /proc/self/cgroup | read) != ""
                set -g in_docker (echo -ns (set_color normal) "(")
                set -g in_docker $in_docker(echo -ns (set_color $fish_prompt_color_docker_icon) "" (set_color normal))
                set -g in_docker $in_docker(echo -ns ")")
            end
        end
    end
end
