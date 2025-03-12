function screen --wraps screen -d "Make screen more useful by asking what to connect to."
    set -e __screen_session_count
    command screen $argv
end
