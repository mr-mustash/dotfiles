# Brew Prefix
# This is here because I will often want to get the brew prefix to check to see
# if a file exists with something installed be brew. Calling `brew --prefix` is
# slow, so I cache it here.
if which brew >/dev/null
    if not set -q __brew_prefix && $__brew_prefix == ""
        set -U __brew_prefix (/opt/homebrew/bin/brew --prefix)
    end
end

# Reading things
set -x EDITOR nvim
set -x PAGER less
set -x LESSCHARSET utf-8
set -x MANPAGER 'nvim +Man!'

# Homebrew
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_INSECURE_REDIRECT 1
set -x HOMEBREW_CASK_OPTS --require-sha

# Docker
set -x DOCKER_BUILDKIT 1

# Localization
set -gx LC_ALL "en_US.UTF-8"
set -gx LANG "en_US.UTF-8"
set -gx TZ America/Los_Angeles

# GPG
set -gx GPG_TTY (tty)
if not pgrep gpg-agent >/dev/null # Only start up the gpg-agent if it isn't running
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
end
set -gx QUBES_GPG_DOMAIN gpg

# Homebrew Paths
set -gx HOMEBREW_PREFIX $__brew_prefix
set -gx HOMEBREW_CELLAR $__brew_prefix/Cellar
set -gx HOMEBREW_REPOSITORY $__brew_prefix
set -gx HOMEBREW_GNUBIN $__brew_prefix/opt/coreutils/libexec/gnubin
set -gx HOMEBREW_GNUMAN $__brew_prefix/opt/coreutils/libexec/gnuman

set -q MANPATH; or set MANPATH ''
set -gx MANPATH $__brew_prefix/opt/coreutils/libexec/gnuman $__brew_prefix/share/man $MANPATH

set -q INFOPATH; or set INFOPATH ''
set -gx INFOPATH $__brew_prefix/share/info $INFOPATH

if test -e $__brew_prefix/opt/fish/share/fish/__fish_build_paths.fish
    source $__brew_prefix/opt/fish/share/fish/__fish_build_paths.fish
end

# Local binaries
set -q PATH; or set PATH ''
fish_add_path --path $HOME/bin
fish_add_path --path $__brew_prefix/opt/coreutils/libexec/gnubin
fish_add_path --path $__brew_prefix/bin
fish_add_path --path $__brew_prefix/sbin
fish_add_path --path $HOME/.yarn/bin
fish_add_path --path $HOME/.config/yarn/global/node_modules/.bin
fish_add_path --path $HOME/go/bin
fish_add_path --path $HOME/.cargo/bin
fish_add_path --path $HOME/.local/bin # pipx path
fish_add_path --path $__brew_prefix/share/google-cloud-sdk/path.fish.inc

# Using rip instead of rm
set -x GRAVEYARD "$HOME/.local/graveyard"

# selene lua linter
set -x SELENE_CONFIG ~/.config/selene.toml

# Autossh
set -x AUTOSSH_DEBUG 1
set -x AUTOSSH_LOGFILE "/tmp/autossh.log"

# Terragrunt
set -x TERRAGRUNT_FORWARD_TF_STDOUT true

# Autojump
[ -f $__brew_prefix/share/autojump/autojump.fish ]; and source $__brew_prefix/share/autojump/autojump.fish
