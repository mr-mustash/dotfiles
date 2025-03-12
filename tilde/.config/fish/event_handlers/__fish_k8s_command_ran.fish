function __fish_k8s_command_ran --on-event fish_k8s_command
    set -gx __kubectl_run (date '+%s')
end
