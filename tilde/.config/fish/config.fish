if status is-interactive
    # Colors
    source "$__fish_config_dir/colors.fish"

    # Adding my prompt configs first
    set -gx fish_function_path $__fish_config_dir/prompt/prompt_functions/ $fish_function_path
    set -gx fish_function_path $__fish_config_dir/prompt/ $fish_function_path
    set -gx async_prompt_functions __fish_prompt_git __fish_prompt_screen __fish_prompt_jobs __fish_right_prompt_github_user
    set -gx async_prompt_inherit_variables status pipestatus SHLVL CMD_DURATION fish_bind_mode __wall_clock_time_pre __wall_clock_time_post
    set -gx async_prompt_internal_signal SIGUSR3


    # Separate directory for shims that --wrap commands
    set -gx fish_function_path $__fish_config_dir/shims/ $fish_function_path

    # Key bindings
    test -e $__fish_config_dir/function/fish_user_key_bindings.fish; and set fish_key_bindings fish_user_key_bindings

    # Add private scripts to the function path
    set -gx fish_function_path $__fish_config_dir/private/ $fish_function_path
    if test -e $__fish_config_dir/private/private_env.fish
        source $__fish_config_dir/private/private_env.fish
    end

    # Add event handlers to the function path and source them
    set -gx fish_function_path $__fish_config_dir/event_handlers $fish_function_path
    for event_function in $__fish_config_dir/event_handlers/*.fish
        source $event_function
    end

else
    set -gx fish_function_path $__fish_config_dir/prompt/prompt_functions/ $fish_function_path
    set -gx fish_function_path $__fish_config_dir/prompt/ $fish_function_path
end
