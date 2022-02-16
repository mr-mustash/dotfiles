function rm --wraps rm --wraps rip --description "Replaces rm with rip."
    if status is-interactive
        if in-path rip
            command rip --inspect "$argv"
        else
            command rm -vi "$argv"
        end
    end
end
