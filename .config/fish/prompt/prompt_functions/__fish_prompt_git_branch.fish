function __fish_prompt_git_branch --description "Display git the git branch name"
  # Fail if we don't have git installed
  in-path git
  or return 0

  # Fail if we're not inside a git repo
  set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
  or return 0

  set -l git_status (git status --branch --porcelain=v2 2>/dev/null)
  or return

  set -l git_branch (string match -r '(?<=branch.head ).*' $git_status)
  set_color $fish_prompt_color_git_branch
  echo -n " $git_branch"

  set_color normal
end
