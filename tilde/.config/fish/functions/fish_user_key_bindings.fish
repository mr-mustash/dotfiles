function user_bash_key_bindings
    # bash-like command cancel
    bind \cc 'echo; commandline | cat; commandline ""; commandline -f repaint'
end

function user_vimrc_like_key_bindings
    bind -M insert -m default jk backward-char force-repaint
end

function user_misc_key_bindings
    bind -M insert -m insert \cn quick_man_page
    bind -M default -m default \ce edit_command_buffer

    #Auto suggestion complete
    bind -M insert -m insert \cl forward-word
    bind -M insert -m insert \ck end-of-line

    #Delete words
    bind -M insert -m insert \ch backward-kill-word
    bind -M insert -m insert \cj backward-kill-line force-repaint

    # Open FZF and edit file selected in vim
    bind -M insert -m insert \ce fzf_find_to_edit

    # Use ctrl-p to go to previous directory
    bind -M insert -m insert \cp 'prevd | commandline -f repaint'

    # Trap EOF and call cowboy.fish
    bind -M insert \cd cowboy
    bind -M default \cd cowboy
end

# For some reason my vim man pager doesn't work with __fish_man_page.
# This is a quick hack so that I can at least use the feature for now.
function quick_man_page
    set -x  MANPAGER "less -X"
    __fish_man_page
    set -x  MANPAGER "vim -c MANPAGER -"
end

function fish_user_key_bindings
    # VIM ALL THE THINGS
    fish_vi_key_bindings

    user_bash_key_bindings

    user_vimrc_like_key_bindings

    user_misc_key_bindings

    fzf_key_bindings
end

