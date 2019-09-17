function fish_prompt --description 'Write out the prompt'
    # This is a total hack to make the git staus async
    # from the rest of the prompt because it can
    # sometimes take a really long time to return.
    # Right now it doesn't work totally because for some
    # reason every time I'm in a git directory this just fires
    # off constantly. Still trying to figure out why.
    #set -l updated_status (eval echo "\$prompt_$fish_pid")
    #$HOME/.config/fish/prompt/prompt_functions/__fish_prompt_git_status.fish $fish_pid &

    __fish_prompt_username
    if test "$SSH_CONNECTION" != "" ; __fish_prompt_hostname ; end
        __fish_prompt_pwd
        __fish_prompt_git_branch
        __fish_prompt_git_status
        #echo -ns $updated_status
        __fish_prompt_languages
        __fish_prompt_jobs

        set -l glyph "➜"
        echo -ns (set_color $fish_color_user) " $glyph " (set_color normal)
end
