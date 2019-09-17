function __fish_prompt_jobs --description 'Helper function for fish_prompt'
    jobs | egrep -v 'autojump' >/dev/null 2>/dev/null; or return 0

    set job_count (jobs | egrep -v 'autojump|__fish_prompt_git_status' | wc -l)

    if test "$job_count" != "0"
        echo -n (set_color $fish_prompt_color_jobs) "$job_count"
    end
end
