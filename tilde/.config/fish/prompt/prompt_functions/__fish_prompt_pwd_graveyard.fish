function __fish_prompt_pwd_graveyard --description 'Are there files in the pwd that are in the `rip` graveyard?'
    # Early return if no GRAVEYARD variable
    set -q GRAVEYARD || return

    # Cache graveyard files
    set -l __rip_graveyard_files (rip -s 2>/dev/null) || return
    test (count $__rip_graveyard_files) -eq 0 && return

    # Get current path
    set -l pwd $PWD
    set -l pwd_p (pwd -P)

    # Prepare graveyard path regex once
    set -l _graveyard (string escape --style=regex -- $GRAVEYARD)

    # Process files in batch where possible
    for file in $__rip_graveyard_files
        # Do string operations only once per iteration
        set -l file_dir (dirname (string replace -r "^$_graveyard" "" $file))
        if test "$file_dir" = "$pwd" -o "$file_dir" = "$pwd_p"
            echo -ns (set_color normal)"("(set_color $fish_prompt_color_graveyard)""(set_color normal)")"
            return
        end
    end
end
