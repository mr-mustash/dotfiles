if status is-interactive
    # Colors
    source "$__fish_config_dir/colors.fish"

    # Adding my prompt configs first
    set -gx fish_function_path $__fish_config_dir/prompt/prompt_functions/ $fish_function_path
    set -gx fish_function_path $__fish_config_dir/prompt/ $fish_function_path

    # Separate directory for shims that --wrap commands
    set -gx fish_function_path $__fish_config_dir/shims/ $fish_function_path

    # Key bindings
    test -e $__fish_config_dir/function/fish_user_key_bindings.fish; and set fish_key_bindings fish_user_key_bindings

    # Add private scripts to the function path and source private env file if
    # it exists
    fish_add_path $__fish_config_dir/private/
    if test -e $__fish_config_dir/private/private_env.fish
        source $__fish_config_dir/private/private_env.fish
    end

else
    set -gx fish_function_path $__fish_config_dir/prompt/prompt_functions/ $fish_function_path
    set -gx fish_function_path $__fish_config_dir/prompt/ $fish_function_path
end
