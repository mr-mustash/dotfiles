function fzf_find_to_edit --description="Open of fzf file search with C-e in insert mode, and then open the selected file in vim."
    # This looks gross because using $FZF_DEFAULT_OPTS is not working here. This is litearlly just the output of `echo $FZF_DEFAULT_OPTS`.
    set -l file (fzf --query="$1" --multi --select-1 --exit-0 --height 40% --reverse --border --inline-info --color fg:-1,bg:-1,hl:33,fg+:254,hl+:33 --color info:136,prompt:136,pointer:230,marker:230,spinner:136 --preview-window right:60% --preview='bat --color=always --style=numbers --line-range=:500 {}')
    if test $status -eq 0
        vim $file
    end

    commandline -f repaint
end
