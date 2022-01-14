function irc -d "Connect to or start a screen session running weechat"
    screen -list | grep irc >/dev/null 2>1
    if test $status -eq 0
        screen -r irc
    else
        screen -S irc -m weechat
    end
end
