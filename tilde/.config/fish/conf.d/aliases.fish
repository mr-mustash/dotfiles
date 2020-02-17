if status --is-interactive
    set -g fish_user_abbreviations

    # So many dev servers, so little time
    abbr --add sshdev ssh pking@dev6-uswest1cdevc
    abbr --add moshdev mosh pking@dev6-uswest1cdevc

    # Moving around
    alias l1="exa --group-directories-first --icons -1"
    alias more="less"
    alias cd..="cd .."
    alias cp="cp -i"
    alias rm="rm -i"

    function ll
        pwd
        exa --group-directories-first --icons -laF $argv
    end

    # Colorized and better syntax for diff.
    alias diff='diff'

    # Colorized grep
    alias grep='grep --color=auto'

    # COLORZ
    alias less='less -R'

    # Cleaner time output.
    #alias time='time -f "\t%e real\t%U user\t%S sys\t%P CPU\t%x status"'

    ### Abbreviations ###
    # tmux
    abbr --add t 'tmux'
    abbr --add tt 'tmux_for_ticket'
    abbr --add tls 'tmux list-sessions'

    # Review Board
    abbr --add rb 'review-branch'
    abbr --add rbr 'review-branch -r '

    # Sensu expansion
    abbr --add silence '/nail/sys/bin/downtime (hostname --fqdn)'
    abbr --add unsilence 'sensu-cli stash delete silence/(hostname --fqdn)'
    abbr --add sreport '/nail/sys/bin/sensu-report'
    abbr --add ssreport 'sensu-cli client delete (hostname --fqdn) ;and sleep 60 ;and sensu-report'
    abbr --add cnfdiff 'git diff --no-index -- /etc/my.cnf /nail/etc/my.cnf'

    # Git expansions
    abbr --add gco 'git checkout'
    abbr --add gpom 'git pull origin master'
    abbr --add gcub 'git checkout -b u/(whoami)/'
    abbr --add gpib 'git push origin HEAD:i/(whoami)/'
    abbr --add gcam 'git commit -a -m'
    abbr --add gs 'git status'
    abbr --add gd 'git diff'
    abbr --add gcm 'git checkout master'
    abbr --add gb 'git branch'
    abbr --add ga 'git add'
    abbr --add gdm 'git diff master'
    abbr --add git-clean 'git pull ;and git remote prune origin ;and git gc'
    abbr --add grh 'git reset --hard'
end
