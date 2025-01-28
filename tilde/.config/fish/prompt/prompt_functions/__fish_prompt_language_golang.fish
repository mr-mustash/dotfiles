function __fish_prompt_language_golang -d "Print out the golang version"

    if not string match -q "*.go" $__dir_file_list; or not test -f go.mod \
            -o -d Godeps \
            -o -f glide.yaml \
            -o (count src/*.go) -gt 0 \
            -o -f Gopkg.yml \
            -o -f Gopkg.lock \
            -o ([ (count $GOPATH) -gt 0 ]; and string match $GOPATH $PWD)
        return 0
    end

    if ! set -q go_version
        set -l go_version_local (go version | string split ' ')
        # Go version is either the commit hash and date (devel +5efe9a8f11 Web Jan 9 07:21:16 2019 +0000)
        # at the time of the build or a release tag (go1.11.4)
        if test (string match 'devel*' $go_version[3])
            set -gx go_version $go_version_local[3]":"(string sub -s 2 $go_version_local[4])
        else
            set -gx go_version "v"(string sub -s 3 $go_version_local[3])
        end
    end

    echo -ns (set_color $fish_prompt_color_golang_icon) " " (set_color normal)
    echo -ns (set_color --bold) " $go_version" (set_color normal)
end
