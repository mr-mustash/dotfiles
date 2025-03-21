status --is-interactive
or exit 0

set -g fish_user_abbreviations

# Moving around
alias ls='ls --color=auto'
alias l1="ls --color=auto -1"
alias more="less"
alias cd..="cd .."
alias cp="cp -i"

function ll
    pwd
    ls --color=auto -laF $argv
end

# Colorized and better syntax for diff.
alias diff='diff'

# Colorized grep
alias grep='grep --color=auto'

# COLORZ
alias less='less -R'

# Cleaner time output.
#alias time='time -f "\t%e real\t%U user\t%S sys\t%P CPU\t%x status"'

### Abbreviations ###
# Misc
abbr --add ag rg # some habits are too hard to break
abbr --add which type # `type` will return function definitions in addition to binary paths

# GitHub
abbr --add hub gh # I always type `hub` instead of the newer `gh` command
abbr --add ghb 'gh browse'


# K8s
abbr --add kctx kubectx

# Terraform
abbr --add tf 'terraform fmt'
abbr --add tp 'terraform fmt && terraform plan'
abbr --add tgp 'terragrunt hclfmt && terragrunt plan'
abbr --add tgg 'terragrunt show'

# K8s
abbr --add k kubectl
abbr --add kctx kubectx

# History
abbr -a !! --position anywhere --function last_history_item

# tmux
abbr --add t tmux
abbr --add tt tmux_for_ticket
abbr --add tls 'tmux list-sessions'

# Git expansions
abbr --add gco 'git checkout'
abbr --add gcub 'git checkout -b u/(whoami)/'
abbr --add gpib 'git push origin HEAD:i/(whoami)/'
abbr --add gcam 'git commit -a -m'
abbr --add gs 'git status'
abbr --add gd 'git diff'
abbr --add gb 'git branch'
abbr --add ga 'git add'
abbr --add git-clean 'git pull ;and git remote prune origin ;and git gc'
abbr --add grh 'git reset --hard'
abbr --add gbf fuzzy_git_branch
abbr --add grd 'cd (git rev-parse --git-dir) ; cd ..'
abbr --add gpom --function git_pull_origin_default
abbr --add gcm --function git_checkout_default
abbr --add gdm --function git_diff_default

# `gpom`, `gdm`, and `gcm` are now set in:
# prompt/prompt_functions/__fish_prompt_git_checkout_default.fish
