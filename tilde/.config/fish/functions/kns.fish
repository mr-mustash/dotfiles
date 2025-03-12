function kns -d "Set Kubernetes namespace"
    set -l namespaces (command kubectl get namespace | awk 'NR>1 {print $1}')

    if test $status -ne 0
        _log_error "Failed to retrieve Kubernetes namespaces."
        return 1
    end

    set -l __k8s_namespace (printf "%s\n" $namespaces | fzf)

    if test -z "$__k8s_namespace"
        _log_error "No namespace selected."
        return 1
    end

    echo "Switching to K8s namespace $__k8s_namespace"

    command kubectl ns $__k8s_namespace
    if test $status -ne 0
        _log_error "Failed to switch namespace to $__k8s_namespace."
        return 1
    end

    set -gx __kubectl_run (date '+%s')
end
