function __cmd_duration -S -d 'Show command duration'
  [ -z "$CMD_DURATION" -o "$CMD_DURATION" -lt 100 ]; and return

  if [ "$CMD_DURATION" -lt 5000 ]
    set_color $fish_color_escape
    echo -ns " $CMD_DURATION" 'ms'
  else if [ "$CMD_DURATION" -lt 60000 ]
    set_color $fish_color_escape
    echo -n " "
    math "scale=1;$CMD_DURATION/1000" | string replace -r '\\.0$' ''
    echo -n 's'
  else if [ "$CMD_DURATION" -lt 3600000 ]
    set_color $fish_color_error
    echo -n " "
    math "scale=1;$CMD_DURATION/60000" | string replace -r '\\.0$' ''
    echo -n 'm'
  else
    echo -n " "
    set_color $fish_color_error
    math "scale=2;$CMD_DURATION/3600000" | string replace -r '\\.0$' ''
    echo -n 'h'
  end
  set_color normal
end

function __connection_type
  if [ -n "$SSH_CLIENT" ]; or [ -n "$SSH_TTY" ]
    echo -n " (ssh)"
  end
end

function fish_right_prompt -d 'Setting the right prompt with connection type or command duration'
  set_color $fish_color_redirection
  __connection_type

  __cmd_duration

end

