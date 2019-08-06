# Adding my prompt configs first
set -gx fish_function_path $HOME/.config/fish/prompt/ $fish_function_path

set fish_key_bindings fish_user_key_bindings

# Load iTerm 2 shell integration
test -e {$HOME}/.config/fish/functions/iterm_shell_integration.fish; and source {$HOME}/.config/fish/functions/iterm_shell_integration.fish

