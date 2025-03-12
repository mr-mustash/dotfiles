function kubectx --wraps kubectx -d 'kubectx wrapper'
    emit fish_k8s_command
    command kubectx $argv
end
