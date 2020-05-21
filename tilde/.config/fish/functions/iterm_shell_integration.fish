if begin; status --is-interactive; and not functions -q -- iterm2_status; and [ "$ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX""$TERM" != screen ]; and [ "$TERM" != dumb ]; and [ "$TERM" != linux ]; end
  function iterm2_status
    printf "\033]133;D;%s\007" $argv
  end

  # Mark start of prompt
  function iterm2_prompt_mark
    printf "\033]133;A\007"
  end

  # Mark end of prompt
  function iterm2_prompt_end
    printf "\033]133;B\007"
  end

  function iterm2_write_remotehost_currentdir_uservars
    printf "\033]1337;RemoteHost=%s@%s\007\033]1337;CurrentDir=%s\007" $USER $iterm2_hostname $PWD
  end

  # If hostname -f is slow for you, set iterm2_hostname before sourcing this script
  if not set -q -g iterm2_hostname
    set -g iterm2_hostname (hostname -f 2>/dev/null)
    # some flavors of BSD (i.e. NetBSD and OpenBSD) don't have the -f option
    if test $status -ne 0
      set -g iterm2_hostname (hostname)
    end
  end

  iterm2_write_remotehost_currentdir_uservars
  printf "\033]1337;ShellIntegrationVersion=10;shell=fish\007"
end

alias imgcat=~/.iterm2/imgcat;alias imgls=~/.iterm2/imgls;alias it2api=~/.iterm2/it2api;alias it2attention=~/.iterm2/it2attention;alias it2check=~/.iterm2/it2check;alias it2copy=~/.iterm2/it2copy;alias it2dl=~/.iterm2/it2dl;alias it2getvar=~/.iterm2/it2getvar;alias it2git=~/.iterm2/it2git;alias it2setcolor=~/.iterm2/it2setcolor;alias it2setkeylabel=~/.iterm2/it2setkeylabel;alias it2ul=~/.iterm2/it2ul;alias it2universion=~/.iterm2/it2universion
