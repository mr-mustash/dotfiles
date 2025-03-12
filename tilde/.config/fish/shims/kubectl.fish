function kubectl --wraps kubectl -d 'kubectl shorthand'
    emit fish_k8s_command
    command kubectl $argv
end
