function screen --wraps screen -d "Make screen more useful by asking what to connect to."
    if status is-interactive
        command screen $argv
        if test $status -ne 0
            echo "Fix this function."
        end
    end
end
