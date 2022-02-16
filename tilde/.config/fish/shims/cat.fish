function cat --wraps cat -d "Use bat instead of cat unless it's a Markdown file, then use markcat"
    if status is-interactive
        if in-path bat
            # Here we are testing if the output is a terminal or a pipe. If
            # it's a pipe I am most likely doing something like `cat
            # example.txt | pbcopy` where I _don't_ want any extra characters
            # (like color codes) to appear.
            if test -t 1
                bat "$argv"
            else
               command cat "$argv"
            end
        else
            command cat "$argv"
        end
    end
end
