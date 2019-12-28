# Colors
if status is-interactive
    source "$__fish_config_dir/colors.fish"
end

# Adding my prompt configs first
set -gx fish_function_path $HOME/.config/fish/prompt/prompt_functions/ $fish_function_path
set -gx fish_function_path $HOME/.config/fish/prompt/ $fish_function_path

test -e $HOME/.config/fish/function/fish_user_key_bindings.fish; and set fish_key_bindings fish_user_key_bindings

# Load iTerm 2 shell integration
test -e {$HOME}/.config/fish/functions/iterm_shell_integration.fish; and source {$HOME}/.config/fish/functions/iterm_shell_integration.fish
