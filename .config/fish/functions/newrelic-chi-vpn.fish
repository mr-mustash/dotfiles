function newrelic-chi-vpn
    echo -e "\033]6;1;bg;red;brightness;211\a" | tr -d '\n'
    echo -e "\033]6;1;bg;green;brightness;54\a" | tr -d '\n'
    echo -e "\033]6;1;bg;blue;brightness;130\a" | tr -d '\n'
    echo -ne "\033]0;newrelic-chi-vpn\007" | tr -d '\n'
    /usr/local/bin/newrelic-chi-vpn
    echo -e "\033]6;1;bg;*;default\a" | tr -d '\n'
end

