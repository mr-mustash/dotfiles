function __fish_prompt_language_docker -d "Display docker version"
    if not test -f Dockerfile \
        -o -f docker-compose.yml \
        -o -f /.dockerenv \
        -o -f "$COMPOSE_FILE"
        return
    end

    set -l docker_version (docker version -f "{{.Server.Version}}")
    # if docker daemon isn't running you'll get an error like 'Bad response from Docker engine'
    [ -z $docker_version ]; and return


    echo -ns (set_color $fish_prompt_color_docker_icon) " " (set_color normal)
    echo -ns (set_color --bold) " v$docker_version" (set_color normal)
end
