function __fish_prompt_jobs --description 'Helper function for fish_prompt'
  jobs -q; or return 0

  set job_count (jobs | wc -l)

  echo -n (set_color $fish_prompt_color_jobs) "$job_count"
end
