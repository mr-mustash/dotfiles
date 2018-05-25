# tmux helper functions
function vim_session_for_ticket
    # Setting _TICKET as an environmental variable to all child processes.
    set -x _TICKET $argv

    # Checking to see if there's a tmux session already open for this ticket
    # if not, we start a new session sourcing the default_ticket_session file.
    if test -f ~/.vim/local/sessions/$_TICKET
        vim -S ~/.vim/local/sessions/$_TICKET
    else
        vim -c "packadd vim-obsession | exe 'Obsess' fnameescape(~/.vim/local/sessions/$_TICKET)"
    end
end
