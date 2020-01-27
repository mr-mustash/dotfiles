function __fish_right_prompt_aws_profile -d "Show the aws profile after running the aws comman"
  [ -z "$AWS_PROMPT_ICON" ]; and set -l AWS_PROMPT_ICON ""

  set -lx aws_profile (aws profile)

  if test $aws_profile = ""
    echo (set_color red --bold)$AWS_PROMPT_ICON" "(set_color normal)"no profile "
    return
  end

  echo (set_color $fish_prompt_color_aws)$AWS_PROMPT_ICON" "(set_color normal)"$aws_profile "
end
