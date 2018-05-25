function fzf_env
    set -l base03 "234"
    set -l base02 "235"
    set -l base01 "240"
    set -l base00 "241"
    set -l base0 "244"
    set -l base1 "245"
    set -l base2 "254"
    set -l base3 "230"
    set -l yellow "136"
    set -l orange "166"
    set -l red "160"
    set -l magenta "125"
    set -l violet "61"
    set -l blue "33"
    set -l cyan "37"
    set -l green "64"

    # Solarized Dark color scheme for fzf
    set -g FZF_DEFAULT_OPTS " 
      --height 40% --reverse --border --inline-info
      --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
      --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
    "

    # Add in a preview window when using C-t to search for files.
    set -g FZF_CTRL_T_OPTS "
     --preview-window right:60%
     --preview='head -$LINES {}'
    "

    set -g FZF_DEFAULT_COMMAND 'rg --files --no-messages --no-ignore --hidden --follow --glob "!.git/*"'
    set -g FZF_CTRL_T_COMMAND  'eval $FZF_DEFAULT_COMMAND'

end
