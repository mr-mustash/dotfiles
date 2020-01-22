function cat --argument-names cmd --wraps cat -d "Use bat instead of cat unless it's a Markdown file, then use markcat"
    if status is-interactive
        switch "$cmd"
            # I want to still be able to use the real cat when I need to.
            case '-p'
                if not test -f $argv[2]
                    echo "File not found: $argv"
                    return 1
                end

                # Don't send "-p" to cat
                /bin/cat $argv[2]

            case '*'
                set -l exts md markdown txt

                if not test -f $argv
                    echo "File not found: $argv"
                    return 1
                end

                if contains ( __get_extension $argv ) $exts
                    markcat --smartypants -s $argv
                    if test $status -ne "0"
                        /bin/cat $argv
                    end
                else
                    highlight -O ansi --style=solarized-dark --force $argv
                    if test $status -ne "0"
                        /bin/cat $argv
                    end
                end
        end
    else
        /bin/cat $argv
    end
end
