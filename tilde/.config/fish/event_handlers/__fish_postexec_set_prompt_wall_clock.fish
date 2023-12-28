function __fish_postexec_set_prompt_wall_clock --on-event fish_postexec --description "Set wall clock time before command executes"
    set -g __wall_clock_time_post (date +"%T.%3N")

    # Currently `commandline -f repaint` does not fire before during the
    # preexec/postexect event. Eventually once
    # https://github.com/fish-shell/fish-shell/issues/9103 is fixed I'll be able
    # to use the `commandline` command below to repaint the existing prompt.
    # This will then show the wall clock time for a command on the same line as
    # it was executed.

    # commandline -f repaint
end
