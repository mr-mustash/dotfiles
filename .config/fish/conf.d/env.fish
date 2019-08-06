# Reading things
set -x EDITOR vim
set -x PAGER less
set -x LESSCHARSET utf-8

# Homebrew
set -x HOMEBREW_NO_ANALYTICS 1

# Location
set -x LC_ALL "en_US.UTF-8"
set -x TZ America/Los_Angeles

# LS
set -x CLICOLOR 1
set -x LSCOLORS exfxcxdxbxexexabagacad

# Don't judge me, I just like VIM, OK?!
set -x  MANPAGER "vim -c MANPAGER -"

# GPG
set -gx GPG_TTY (tty)

# Paths!
set -gx fish_user_paths  "~/bin" $fish_user_paths
set -gx fish_user_paths "/usr/local/sbin" $fish_user_paths

if test -e (brew --prefix coreutils)/libexec/gnubin
    set -gx fish_user_paths (brew --prefix coreutils)/libexec/gnubin $fish_user_paths
end

if test -e /usr/local/share/fish/__fish_build_paths.fish
    source /usr/local/share/fish/__fish_build_paths.fish
end

if test -d $HOME/go
    set -gx GOPATH "$HOME/go"
    if test -d $GOPATH/bin
        set -gx fish_user_paths "$GOPATH/bin" $fish_user_paths
    end
end

# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# New Relic Paths
if test -e $HOME/.config/fish/functions/new_relic_env.fish
    new_relic_env
end

#FZF
if test -e $HOME/.config/fish/functions/fzf_env.fish
    fzf_env
end

# rbenv
status --is-interactive; and source (rbenv init -|psub)
