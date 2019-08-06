function fish_right_prompt --description 'Display the right side of the interactive prompt'
    set -l exit $status
    set -l time $CMD_DURATION

    __fish_right_prompt_timer $time
    if test $exit -ne 0
        __fish_right_prompt_signal $exit
    end

    if test $COLUMNS -gt 132
        set -lx __date (date +%s)
        if set -q __kubectl_run
            if test (math "$__date - $__kubectl_run") -lt 300
                 __fish_right_prompt_k8s_context
            end
        end
    end


end

