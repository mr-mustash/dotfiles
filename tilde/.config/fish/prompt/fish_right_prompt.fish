function fish_right_prompt --description 'Display the right side of the interactive prompt'
    set -l _status $status
    set -l _duration $CMD_DURATION

    if test $_status -ne 0
        __fish_right_prompt_signal $_status
        set -e _status
    end

    if test $COLUMNS -gt 132 && set -q __gproject && set -q __gzone
        __fish_right_prompt_gc_context
    end

    if test $COLUMNS -gt 132
        set -lx __date (date +%s)
        if set -q __kubectl_run
            if test (math "$__date - $__kubectl_run") -lt 300
                __fish_right_prompt_k8s_context
            end
        end
        __fish_right_prompt_saml2aws
    end

    if test $_duration -ne 0
        __fish_right_prompt_timer $_duration
        set -e _duration
    end

    __fish_right_prompt_wall_time
end
