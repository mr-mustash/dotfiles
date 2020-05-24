if status is-interactive
    # Colors
    source "$__fish_config_dir/colors.fish"

    # Adding my prompt configs first

    #source $HOME/.config/fish/functions/__update_prompt.fish
    set -gx fish_function_path $HOME/.config/fish/prompt/prompt_functions/ $fish_function_path
    set -gx fish_function_path $HOME/.config/fish/prompt/ $fish_function_path

    #set -g async_prompt_inherit_variables all
    set -g async_prompt_functions __fish_prompt_git_status __fish_prompt_git_autofetch

    # Key bindings
    test -e $HOME/.config/fish/function/fish_user_key_bindings.fish; and set fish_key_bindings fish_user_key_bindings

    # Load iTerm 2 shell integration
    test -e {$HOME}/.config/fish/functions/iterm_shell_integration.fish; and source {$HOME}/.config/fish/functions/iterm_shell_integration.fish
else
    set -gx fish_function_path $HOME/.config/fish/prompt/prompt_functions/ $fish_function_path
    set -gx fish_function_path $HOME/.config/fish/prompt/ $fish_function_path
end
