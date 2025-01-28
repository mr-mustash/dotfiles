function kubectx --wraps kubectx -d 'kubectx wrapper'
    set -gx __kubectl_run (date '+%s')
    command kubectx $argv
end
