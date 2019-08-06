function __cmd_duration -S -d 'Show command duration'
  [ -z "$CMD_DURATION" -o "$CMD_DURATION" -lt 100 ]; and return

  if [ "$CMD_DURATION" -lt 5000 ]
    set_color $fish_color_escape
    echo -ns " $CMD_DURATION" 'ms'
  else if [ "$CMD_DURATION" -lt 60000 ]
    set_color $fish_color_escape
    echo -n " "
    math "$CMD_DURATION/1000" | xargs printf "%0.2f\n"
    echo -n 's'
  else if [ "$CMD_DURATION" -lt 3600000 ]
    set_color $fish_color_error
    echo -n " "
    math "$CMD_DURATION/60000" | xargs printf "%0.2f\n"
    echo -n 'm'
  else
    echo -n " "
    set_color $fish_color_error
    math "$CMD_DURATION/3600000" | xargs printf "%0.2f\n"
    echo -n 'h'
  end
  set_color normal
end

function __connection_type
  if [ -n "$SSH_CLIENT" ]; or [ -n "$SSH_TTY" ]
    echo -n " (ssh)"
  end
end

function __kubectl_status
  [ -z "$KUBECTL_PROMPT_ICON" ]; and set -l KUBECTL_PROMPT_ICON "⎈"
  [ -z "$KUBECTL_PROMPT_SEPARATOR" ]; and set -l KUBECTL_PROMPT_SEPARATOR "/"
  set -l config $KUBECONFIG
  [ -z "$config" ]; and set -l config "$HOME/.kube/config"
  if [ ! -f $config ]
    echo (set_color red)$KUBECTL_PROMPT_ICON" "(set_color normal)"no config"
    return
  end

  set -l ctx (kubectl config current-context 2>/dev/null)
  if [ $status -ne 0 ]
    echo (set_color red)$KUBECTL_PROMPT_ICON" "(set_color normal)"no context"
    return
  end

  set -l ns (kubectl config view -o "jsonpath={.contexts[?(@.name==\"$ctx\")].context.namespace}")
  [ -z $ns ]; and set -l ns 'default'

  echo " "(set_color cyan)$KUBECTL_PROMPT_ICON" "(set_color normal)"($ctx$KUBECTL_PROMPT_SEPARATOR$ns)"
end


function fish_right_prompt -d 'Setting the right prompt with connection type or command duration'
  set_color $fish_color_redirection
  set -gx __date (date +%s)

  if set -q __kubectl_run
    if test (math "$__date - $__kubectl_run") -lt 300
        __kubectl_status
    end
  end

  __connection_type

  __cmd_duration
end
