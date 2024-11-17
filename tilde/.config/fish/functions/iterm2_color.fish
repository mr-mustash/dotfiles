function iterm2_color -d "Set the iTerm 2 tab color"
    switch $argv[1]
        case green # Green
            echo -e "\033]6;1;bg;red;brightness;103\a" | tr -d '\n'
            echo -e "\033]6;1;bg;green;brightness;137\a" | tr -d '\n'
            echo -e "\033]6;1;bg;blue;brightness;30\a" | tr -d '\n'
        case blue # Blue
            echo -e "\033]6;1;bg;red;brightness;44\a" | tr -d '\n'
            echo -e "\033]6;1;bg;green;brightness;129\a" | tr -d '\n'
            echo -e "\033]6;1;bg;blue;brightness;168\a" | tr -d '\n'
        case red # Red
            echo -e "\033]6;1;bg;red;brightness;172\a" | tr -d '\n'
            echo -e "\033]6;1;bg;green;brightness;47\a" | tr -d '\n'
            echo -e "\033]6;1;bg;blue;brightness;53\a" | tr -d '\n'
        case magenta
            echo -e "\033]6;1;bg;red;brightness;211\a" | tr -d '\n'
            echo -e "\033]6;1;bg;green;brightness;54\a" | tr -d '\n'
            echo -e "\033]6;1;bg;blue;brightness;130\a" | tr -d '\n'
        case default
            echo -e "\033]6;1;bg;*;default\a" | tr -d '\n'
    end
end
