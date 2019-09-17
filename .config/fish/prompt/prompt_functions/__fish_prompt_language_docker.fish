function __fish_prompt_language_docker -d "Display docker version"
    in-path docker
    return

    if not test -f Dockerfile \
        -o -f docker-compose.yml \
        -o -f /.dockerenv \
        -o -f "$COMPOSE_FILE"
        return
    end

    if not type -q docker
        return
    end

    set -l docker_version (docker version -f "{{.Server.Version}}" 2>/dev/null)
    # if docker daemon isn't running you'll get an error like 'Bad response from Docker engine'
    if test "$docker_version" = ""
        return 0
    end


    echo -ns (set_color $fish_prompt_color_docker_icon) " " (set_color normal)
    echo -ns (set_color --bold) " v$docker_version" (set_color normal)
end
