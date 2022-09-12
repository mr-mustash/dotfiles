function trash -d "Take out the trash from rip."
    set -l _list 1
    set -l _empty 1
    set -l _days -1

    getopts $argv | while read -l key value
        switch $key
            case l list
                set _list 0
            case e empty
                set _empty 0
            case d days
                set _days $value
            case h help
                __trash_usage
            case "*"
                echo -e "$key is not a valid option"
                __trash_usage
        end
    end

    if test $_list -eq $_empty
        echo -e "Please pick either list or empty."
        __trash_usage
        return 1
    end

    if test $_days -eq -1
        echo "No deletion days specified. Defaulting to 7 days."
        set _days 7
    end

    if test $_list -eq 0 -a $_empty -eq 1
        echo -e "Files in trash older than $_days days:"
        find /Users/$USER/.local/graveyard -ctime +$_days -type f -print | egrep -v .record
    else if test $_list -eq 1 -a $_empty -eq 0
        # Delete the files and remove from .record
        for file in $__files
            echo -e "Deleting $file"
            set -l __escaped (echo $file | string escape --style=regex | sed -e "s.\/.\\\/.g")
            command rm -f $file && command gsed -i "/$__escaped/d" /Users/$USER/.local/graveyard/.record
        end
    end

end

function __trash_usage
    echo "Usage: trash [-l/--list|-e/--empty] [-d/--days] [-h/--help]"
end
