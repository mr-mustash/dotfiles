function __fish_prompt_pwd_graveyard --description 'Are there files in the pwd that are in the `rip` graveyard?'
    if in-path rip
        set -l __rip_graveyard_files (rip -s 2>/dev/null)
        if test $status -ne 0 -o (count $__rip_graveyard_files) -eq 0
            return
        end

        # This whole statement is here because if you call `rip -s` it'll recurse
        # through every directory and see if there is a file in the graveyard.
        # Here I am checking to see if there is a file in the graveyard exists
        # in the current directory and not in any subdirectories.

        # First, find the graveyard location.
        set -l _whoami (whoami)
        if set -q GRAVEYARD
            set _graveyard (echo $GRAVEYARD | string escape --style=regex | sed -e "s.\/.\\\/.g")
        else
            set _graveyard (\/tmp\/graveyard-$_whoami\/)
        end

        # Now, find if the current directory is in the graveyard.
        contains -i (pwd -L) (dirname (rip -s | sed -e "s/$_graveyard//")) >/dev/null \
            || contains -i (pwd -P) (dirname (rip -s | sed -e "s/$_graveyard//")) >/dev/null
        if test $status -eq 0
            set __fish_prompt_pwd_has_graveyard 0
        else
            return
        end

        if test $__fish_prompt_pwd_has_graveyard -eq 0
            echo -ns (set_color normal) "("
            echo -ns (set_color $fish_prompt_color_graveyard) "" (set_color normal)
            echo -ns ")"
        end
    end

end
