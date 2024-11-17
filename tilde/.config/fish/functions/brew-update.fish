function brew-update --description="update brew and cleanup after itself"
    set -lx bold (tput bold)
    set -lx normal (tput sgr0)

    echo -e "$bold Brew Update $normal"
    command brew update

    echo -e "$bold Brew Upgrde $normal"
    command brew upgrade

    echo -e "$bold Brew Cleanup $normal"
    command brew cleanup --prune-prefix
    command brew cleanup
    command brew cleanup -s
end
