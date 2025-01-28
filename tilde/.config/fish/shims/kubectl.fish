function kubectl --wraps kubectl -d 'kubectl shorthand'
    set -gx __kubectl_run (date '+%s')
    command kubectl $argv
end
