function __fish_prompt_language_docker -d "Display docker version"
    if not test -f Dockerfile \
        -o -f docker-compose.yml \
        -o -f /.dockerenv \
        -o -f "$COMPOSE_FILE"
        return
    end

    if not type -q docker
        return
    end

    if ! set -q docker_version
        set -gx docker_version (docker version | grep 'Version:' | awk '{print $2}')
    end
    # if docker daemon isn't running you'll get an error like 'Bad response from Docker engine'
    if string match daemon $docker_version ; return ; end

    if test "$docker_version" = ""
        return
    end


    echo -ns (set_color $fish_prompt_color_docker_icon) " " (set_color normal)
    echo -ns (set_color --bold) " v$docker_version" (set_color normal)
end
