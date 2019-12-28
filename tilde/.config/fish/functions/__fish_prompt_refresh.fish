function __fish_prompt_refresh -d "Refresh the prompt with kill -WINCH"
    kill -WINCH $argv[1]
end

