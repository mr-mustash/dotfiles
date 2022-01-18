function __fish_prompt_in_docker -d "Display hostname inside docker container"
    if not set -q in_docker
        if test -f /proc/1/sched
            set -lx sched (cat /proc/1/sched | head -n 1 | awk '{print $1}')
            if test $status -eq 0 && test sched != init
                set -g in_docker (echo -ns (set_color normal) "(")
                set -g in_docker $in_docker(echo -ns (set_color $fish_prompt_color_docker_icon) "" (set_color normal))
                set -g in_docker $in_docker(echo -ns ")")
            end
        end
    end
end
