set fish_key_bindings fish_user_key_bindings

# Load iTerm 2 shell integration
test -e {$HOME}/.config/fish/functions/iterm_shell_integration.fish; and source {$HOME}/.config/fish/functions/iterm_shell_integration.fish

# Test if we are in tmux
if [ "$TMUX" != "" ]
    # Fix for tmux window name
    tmux rename-window (prompt_hostname)
end
