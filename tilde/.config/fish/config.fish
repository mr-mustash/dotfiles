if status is-interactive
    # Colors
    source "$__fish_config_dir/colors.fish"

    # Adding my prompt configs first
    set -gx fish_function_path $__fish_config_dir/prompt/prompt_functions/ $fish_function_path
    set -gx fish_function_path $__fish_config_dir/prompt/ $fish_function_path

    # Separate directory for shims that --wrap commands
    set -gx fish_function_path $__fish_config_dir/shims/ $fish_function_path

    #set -g async_prompt_inherit_variables all
    set -g async_prompt_functions __fish_prompt_git __fish_prompt_pwd_graveyard __fish_right_prompt_git_autofetch

    # Key bindings
    test -e $__fish_config_dir/function/fish_user_key_bindings.fish; and set fish_key_bindings fish_user_key_bindings

    # Add private scripts to the function path and source private env file if
    # it exists
    set -gx fish_function_path $__fish_config_dir/private/ $fish_function_path
    if test -e $__fish_config_dir/private/private_env.fish
        source $__fish_config_dir/private/private_env.fish
    end

else
    set -gx fish_function_path $__fish_config_dir/prompt/prompt_functions/ $fish_function_path
    set -gx fish_function_path $__fish_config_dir/prompt/ $fish_function_path
end
