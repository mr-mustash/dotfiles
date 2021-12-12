function vim --argument-names vim --wraps vim -d "Checks to see if neovim is installed and default to it over vim."
    if status is-interactive
        if in-path nvim
            nvim $argv
        else
            /usr/local/bin/vim $argv
        end
    end
end
