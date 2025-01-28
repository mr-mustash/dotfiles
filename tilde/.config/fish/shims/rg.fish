function rg --wraps rg --wraps ag -d 'Using batgrep when installed.'
    if status is-interactive
        if in-path batgrep
            command batgrep --hidden --paging=never --no-highlight "$argv"
        else
            command rg "$argv"
        end
    end
end
