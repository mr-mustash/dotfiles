function _log_error
    echo (set_color --bold red)"ERROR"(set_color normal)": $argv" >&2
    return 0
end

function _log_warning
    echo (set_color --bold yellow)"WARNING"(set_color normal)": $argv" >&2
    return 0
end

function _log_info
    echo (set_color --bold green)"INFO"(set_color normal)": $argv" >&2
    return 0
end
