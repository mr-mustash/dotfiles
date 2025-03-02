function __fish_prompt_language_python -d "Print out the golang version"
    if not test -f __init__.py; or not string match -q "*.py" $__dir_file_list
        return 0
    end

    if ! set -q python_version
        set -l python_version_local (python3 --version | string split ' ')
        set -gx python_version "v$python_version_local[2]"
    end

    echo -ns (set_color $fish_prompt_color_python_icon) " " (set_color normal)
    echo -ns (set_color --bold) " $python_version" (set_color normal)
end
