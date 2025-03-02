function __fish_prompt_jobs --description 'Helper function for fish_prompt'
    set job_count 0

    set -l _jobs (jobs | string split '\n')
    for line in $_jobs
        if not string match -q '*autojump*' -- $line
            set job_count (math $job_count + 1)
        end
    end

    if test $job_count -gt 0
        echo -ns (set_color $fish_prompt_color_jobs) " 󰜎 " (set_color normal) $job_count (set_color normal)
    end
end
