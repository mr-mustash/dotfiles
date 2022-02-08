if status is-interactive
    # Colors
    source "$__fish_config_dir/colors.fish"

    # Adding my prompt configs first
    set -gx fish_function_path $HOME/.config/fish/prompt/prompt_functions/ $fish_function_path
    set -gx fish_function_path $HOME/.config/fish/prompt/ $fish_function_path

    # Separate directory for shims that --wrap commands
    set -gx fish_function_path $HOME/.config/fish/shims/ $fish_function_path

    #set -g async_prompt_inherit_variables all
    set -g async_prompt_functions __fish_prompt_git __fish_prompt_pwd_graveyard __fish_right_prompt_git_autofetch

    # Key bindings
    test -e $HOME/.config/fish/function/fish_user_key_bindings.fish; and set fish_key_bindings fish_user_key_bindings

    # Add private scripts to the function path
    set -gx fish_function_path $HOME/.config/fish/private/ $fish_function_path
else
    set -gx fish_function_path $HOME/.config/fish/prompt/prompt_functions/ $fish_function_path
    set -gx fish_function_path $HOME/.config/fish/prompt/ $fish_function_path
end
