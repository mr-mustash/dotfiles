function fish_right_prompt --description 'Display the right side of the interactive prompt'
  set -l exit $status
  set -l time $CMD_DURATION

  if test $exit -ne 0
    set_color $__fish_prompt_color_exit
    __fish_right_prompt_signal $exit
    set_color normal
  end

  begin
      __fish_right_k8s_context
  end

  begin
    set_color $__fish_prompt_color_duration
    __fish_right_prompt_timer $time
    set_color normal
  end

end

