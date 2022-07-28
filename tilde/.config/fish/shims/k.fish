function k --wraps kubectl -d 'kubectl shorthand'
    set -gx __kubectl_run (date '+%s')
    kubectl $argv
end
