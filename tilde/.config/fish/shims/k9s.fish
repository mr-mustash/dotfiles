function k9s --wraps k9s -d 'k9s wrapper that display k8s context'
    set -gx __kubectl_run (date '+%s')
    command k9s $argv
end
