function rm --wraps rm --wraps rip --description "Replaces rm with rip."
    if status is-interactive
        if in-path rip
            rip --inspect "$argv"
        else
            rm -vi "$argv"
        end
    end
end
