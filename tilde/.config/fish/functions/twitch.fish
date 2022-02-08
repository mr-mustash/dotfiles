function twitch -d "Use streamlink to watch twitch streams"
    if test -z $argv
        set -l mystreamers paymoneywubby brittballs babbsity kore hamncheddar bootyswagga maiyadanny carlosthegardener villifiedpeanut ashly113 esfandtv esfandradio soycrates
        set streamer (echo $mystreamers | tr ' ' '\n' | eval "fzf $FZF_DEFAULT_OPTS -d ' ' +m --header='[kill:process]'")
    else
        set streamer $argv
    end

    /usr/bin/screen -dmS $streamer streamlink --http-proxy "socks5://localhost:18888" twitch.tv/$streamer 2>&1 | tee -a /tmp/streamlink.log
end
