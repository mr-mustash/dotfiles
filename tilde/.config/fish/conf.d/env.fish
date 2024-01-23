# Brew Prefix
# This is here because I will often want to get the brew prefix to check to see
# if a file exists with something installed be brew. Calling `brew --prefix` is
# slow, so I cache it here.
if which brew > /dev/null
    if not set -q __brew_prefix && $__brew_prefix == ""
        set -U __brew_prefix (/opt/homebrew/bin/brew --prefix)
    end
end

# Reading things
set -x EDITOR nvim
set -x PAGER less
set -x LESSCHARSET utf-8
set -Ux MANPAGER 'nvim +Man!'

# Homebrew
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_INSECURE_REDIRECT 1
set -x HOMEBREW_CASK_OPTS "--require-sha"

# Docker
set -x DOCKER_BUILDKIT 1

# Localization
set -gx LC_ALL "en_US.UTF-8"
set -gx LANG "en_US.UTF-8"
set -gx TZ America/Los_Angeles

# GPG
set -gx GPG_TTY (tty)
if not pgrep gpg-agent > /dev/null # Only start up the gpg-agent if it isn't running
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
end
set -gx QUBES_GPG_DOMAIN gpg

# Homebrew Paths
set -gx HOMEBREW_PREFIX $__brew_prefix
set -gx HOMEBREW_CELLAR $__brew_prefix/Cellar
set -gx HOMEBREW_REPOSITORY $__brew_prefix
set -q PATH; or set PATH ''
set -gx PATH $__brew_prefix/bin $__brew_prefix/sbin $PATH
set -q MANPATH; or set MANPATH ''
set -gx MANPATH /opt/homebrew/share/man $MANPATH
set -q INFOPATH; or set INFOPATH ''
set -gx INFOPATH $__brew_prefix/share/info $INFOPATH
if test -e $__brew_prefix/opt/fish/share/fish/__fish_build_paths.fish
    source $__brew_prefix/opt/fish/share/fish/__fish_build_paths.fish
end

# Local binaries
fish_add_path --path $HOME/bin
fish_add_path --path $HOME/.yarn/bin
fish_add_path --path $HOME/.config/yarn/global/node_modules/.bin
fish_add_path --path $HOME/go/bin
fish_add_path --path $HOME/.cargo/bin
fish_add_path --path $__brew_prefix/opt/homebrew/opt/coreutils/libexec/gnubin
fish_add_path --path $__brew_prefix/share/google-cloud-sdk/path.fish.inc

# Using rip instead of vim
set -x GRAVEYARD "$HOME/.local/graveyard"

# Autossh
set -x AUTOSSH_DEBUG 1
set -x AUTOSSH_LOGFILE "/tmp/autossh.log"

# Autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish
