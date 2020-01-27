function aws -a cmd -d 'Universal CLI for AWS'
    set -gx __aws_run (date '+%s')

    if not set -q aws_completer_path
        set -g aws_completer_path (type -P aws_completer 2> /dev/null)
        or echo "aws: unable to find aws_completer, completions unavaliable"
    end

    switch "$cmd"
        case profile
        if set -q argv[2]
            set -gx AWS_PROFILE "$argv[2]"
        else if set -q FILTER
            aws profiles | command env $FILTER | read -gx AWS_PROFILE
            echo $AWS_PROFILE
        else
            echo $AWS_PROFILE
        end

        case profiles
            command sed -n -e 's/^\[\(.*\)\]/\1/p' "$HOME/.aws/credentials"

        case '*'
            command aws $argv
  end
end
