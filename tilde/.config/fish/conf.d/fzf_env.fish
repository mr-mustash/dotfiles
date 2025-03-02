status --is-interactive
or exit 0

set -l color00 '#002b36'
set -l color01 '#073642'
set -l color02 '#586e75'
set -l color03 '#657b83'
set -l color04 '#839496'
set -l color05 '#93a1a1'
set -l color06 '#eee8d5'
set -l color07 '#fdf6e3'
set -l color08 '#dc322f'
set -l color09 '#cb4b16'
set -l color0A '#b58900'
set -l color0B '#859900'
set -l color0C '#2aa198'
set -l color0D '#268bd2'
set -l color0E '#6c71c4'
set -l color0F '#d33682'


# Solarized Dark color scheme for fzf
set -gx FZF_DEFAULT_OPTS "--height 40% --reverse --border --inline-info"\
" --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
" --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
" --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

# Add in a preview window when using C-t to search for files.
set -gx FZF_CTRL_T_OPTS "--preview-window right:60% --preview='bat --color=always --style=numbers --line-range=:500 {}' "

set -gx FZF_DEFAULT_COMMAND 'rg --files --no-messages --no-ignore --hidden --follow --glob "!.git/*"'
set -gx FZF_CTRL_T_COMMAND "command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"
