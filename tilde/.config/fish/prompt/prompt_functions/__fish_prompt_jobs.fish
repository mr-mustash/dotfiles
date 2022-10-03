function __fish_prompt_jobs --description 'Helper function for fish_prompt'
    set -l job_count (jobs | egrep -v 'autojump|__fish_prompt_git_status|-WINCH|__async|echo $vars' | sed "s/^[[:space:]].*//" | sed '/^$/d' | wc -l)
    if test $job_count = 0
        return
    else
        echo -ns (set_color $fish_prompt_color_jobs) " ﰌ " (set_color normal) $job_count (set_color normal)
    end
end
