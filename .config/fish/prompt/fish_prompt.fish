function fish_prompt --description 'Write out the prompt'

    __fish_prompt_username
    if test "$SSH_CONNECTION" != "" ; __fish_prompt_hostname ; end
    __fish_prompt_pwd
    __fish_prompt_git_branch
    __fish_prompt_git_status
    __fish_prompt_languages
    __fish_prompt_jobs

    set -l glyph "➜"
    echo -ns (set_color $fish_color_user) " $glyph " (set_color normal)
end
