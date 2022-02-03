function cputurbo -d "Manage DisableTurboBoost KEXT"
    set -l _disable 1
    set -l _enable 1

    getopts $argv | while read -l key value
        switch $key
            case e enable
                set _disable 0
            case d disable
                set _enable 0
            case s status
                __cputurbo_status
            case h help
                __cputurbo_usage
            case "*"
                echo -e "$key is not a valid option"
                __cputurbo_usage
        end
    end

    if test $_enable -eq 0 -a $_disable -eq 0
        echo -e "You can't enable and disable at the same time"
        __cputurbo_usage
        return 1
    else if test $_enable -eq 0 -a $_disable -eq 1
        echo -e "Disabling TurboBoost"
        sudo /sbin/kextload /Applications/tbswitcher_resources/DisableTurboBoost.64bits.kext
        __cputurbo_status
    else if test $_enable -eq 1 -a $_disable -eq 0
        echo -e "Enabling TurboBoost"
        sudo /sbin/kextunload /Applications/tbswitcher_resources/DisableTurboBoost.64bits.kext
        __cputurbo_status
    end

end

function __cputurbo_status
    set -l _command (sudo kextstat 2>&1 | grep -i turbo)
    if test $status -eq 0
        echo -e "TurboBoost is disabled"
        echo -e $_command
    else
        echo -e "TurboBoost is enabled"
    end
end

function __cputurbo_usage
    echo "Usage: cputurbo [-e/--enable|-d/--disable] [-h/--help]"
end
