# Reading things
set -x EDITOR vim
set -x PAGER less
set -x LESSCHARSET utf-8

# Homebrew
set -x HOMEBREW_NO_ANALYTICS 1

# Docker
set -x DOCKER_BUILDKIT 1

# Localization
set -gx LC_ALL "en_US.UTF-8"
set -gx LANG "en_US.UTF-8"
set -gx TZ America/Los_Angeles


# Don't judge me, I just like VIM, OK?!
set -x MANPAGER "vim -c MANPAGER -"

# GPG
set -gx GPG_TTY (tty)
set -gx QUBES_GPG_DOMAIN gpg

# Paths!
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -q PATH; or set PATH ''
set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
set -q MANPATH; or set MANPATH ''
set -gx MANPATH /opt/homebrew/share/man $MANPATH
set -q INFOPATH; or set INFOPATH ''
set -gx INFOPATH /opt/homebrew/share/info $INFOPATH

set -a fish_user_paths "$HOME/bin"
set -a fish_user_paths "$HOME/.yarn/bin"
set -a fish_user_paths "$HOME/.config/yarn/global/node_modules/.bin"


# Using rip instead of vim
set -x GRAVEYARD "$HOME/.local/graveyard"

# Autossh
set -x AUTOSSH_DEBUG 1
set -x AUTOSSH_LOGFILE "/tmp/autossh.log"

# This monstrosity is here to make sure that I only have to run
# `brew --prefix coreutils` once per boot. Otherwise it was making
# each shell (and vim for some reason?) take over a second to load.
set -l __uname (uname)
if test $__uname = Darwin
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
end

if test -e /opt/homebrew/opt/fish/share/fish/__fish_build_paths.fish
    source /opt/homebrew/opt/fish/share/fish/__fish_build_paths.fish
end

if test -d $HOME/go
    set -gx GOPATH "$HOME/go"
    if test -d $GOPATH/bin
        fish_add_path $GOPATH/bin
    end
end

# Autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

#FZF
if test -e $HOME/.config/fish/functions/fzf_env.fish
    if which fzf >/dev/null 2>/dev/null
        source $HOME/.config/fish/functions/fzf_env.fish
        fzf_env
    end
end
