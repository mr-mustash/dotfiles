function cowboy --on-process-exit $fish_pid
    echo -e
    bash $HOME/.config/fish/functions/seeyouspacecowboy.sh
    sleep 1
    kill %self
end
