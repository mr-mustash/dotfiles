# tmux helper functions
function tmux_for_ticket
    # Setting _TICKET as an environmental variable to all child processes.
    set -x _TICKET $argv

    # Checking to see if there's a tmux session already open for this ticket
    # if not, we start a new session sourcing the default_ticket_session file.
    tmux has-session -t $_TICKET >/dev/null ^ /dev/null
    if test $status = 0
        tmux -CC attach-session -t $_TICKET
    else
        tmux -CC new "tmux rename-session $_TICKET ; tmux source-file ~/.config/tmux/default_ticket_session"
    end
end
