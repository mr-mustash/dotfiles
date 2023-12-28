function __fish_prompt_jobs --description 'Helper function for fish_prompt'
    set -l job_count (jobs | wc -l)
    if test $job_count = 0
        return
    else
        echo -ns (set_color $fish_prompt_color_jobs) " 󰜎 " (set_color normal) $job_count (set_color normal)
    end
end
