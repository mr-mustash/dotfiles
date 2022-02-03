function rg --wraps rg --wraps ag -d 'Using batgrep when installed.'
    if status is-interactive
        if in-path batgrep
            batgrep --paging=never --no-highlight "$argv"
        else
            /usr/local/bin/rg "$argv"
        end
    end
end
