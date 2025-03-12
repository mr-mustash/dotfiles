function k9s --wraps k9s -d 'k9s wrapper that display k8s context'
    emit fish_k8s_command
    command k9s $argv
end
