function _debug -d "Debug logging for my fish scripts."
    set -l _logfile "/tmp/fish_debug.log"
    set -l _date (date)

    if ! test -f $_logfile
        touch $_logfile
        echo "$_date: Log file created." >>$_logfile
    end

    echo "$_date: $argv[1]: $argv[2]" >>$_logfile
end
