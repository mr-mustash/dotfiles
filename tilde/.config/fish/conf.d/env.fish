# Reading things
set -x EDITOR vim
set -x PAGER less
set -x LESSCHARSET utf-8

# Homebrew
set -x HOMEBREW_NO_ANALYTICS 1

# Docker
set -x DOCKER_BUILDKIT "1"

# Location
set -x LC_ALL "en_US.UTF-8"
set -x TZ America/Los_Angeles

# Don't judge me, I just like VIM, OK?!
set -x  MANPAGER "vim -c MANPAGER -"

# GPG
set -gx GPG_TTY (tty)

# Paths!
set -a fish_user_paths  "$HOME/bin"
set -a fish_user_paths "/usr/local/sbin"

# This monstrosity is here to make sure that I only have to run
# `brew --prefix coreutils` once per boot. Otherwise it was making
# each shell (and vim for some reason?) take over a second to load.
if status is-interactive
    if which brew >/dev/null
        if set -q __brew_coreutils_path
            if test "$__brew_coreutils_path" != ""
                set -a fish_user_paths $__brew_coreutils_path
            else
                set -Ux __brew_coreutils_path (brew --prefix coreutils)/libexec/gnubin
                set -a fish_user_paths $__brew_coreutils_path
            end
        else
            if test -e (brew --prefix coreutils)/libexec/gnubin
                set -Ux __brew_coreutils_path (brew --prefix coreutils)/libexec/gnubin
                set -a fish_user_paths $__brew_coreutils_path
            end
        end
    end
end

if test -e /usr/local/share/fish/__fish_build_paths.fish
    source /usr/local/share/fish/__fish_build_paths.fish
end

if test -d $HOME/go
    set -gx GOPATH "$HOME/go"
    if test -d $GOPATH/bin
        set -a fish_user_paths "$GOPATH/bin"
    end
end

# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# New Relic Paths
if test -e $HOME/.config/fish/functions/new_relic_env.fish
    source $HOME/.config/fish/functions/new_relic_env.fish
    new_relic_env
end

#FZF
if test -e $HOME/.config/fish/functions/fzf_env.fish
    if which fzf >/dev/null 2>/dev/null
        source $HOME/.config/fish/functions/fzf_env.fish
        fzf_env
    end
end
