function __fish_prompt_hooked --description 'Shows if current working directory contains hooked files.'
    if in-path hook

        set -l __dirs_full (for file in (hook ls --files_only --null) ; dirname $file ; end | uniq | string collect)
        set -l __pwd (pwd)
        set -l __pwd_regex (echo -n $__pwd ; echo -n '$')

        if string match --regex $__pwd_regex $__dirs_full >> /dev/null
            echo -ns (set_color blue --bold) " ﯠ" (set_color normal)
        end
    end

end
