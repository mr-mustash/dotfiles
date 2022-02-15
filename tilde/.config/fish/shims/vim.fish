function vim --wraps vim -d "Checks to see if neovim is installed and default to it over vim."
    if status is-interactive
        if in-path nvim
            nvim $argv
        else
            echo (set_color red)"---Falling back to vim---"(set_color normal)
            sleep 0.5
            command vim $argv
        end
    end
end
