function fish_prompt --description 'Write out the prompt'
    __fish_prompt_username
    __fish_prompt_hostname
    __fish_prompt_pwd
    #__fish_prompt_pwd_graveyard

    __fish_prompt_git

    #__fish_prompt_languages
    #__fish_prompt_jobs
    __fish_prompt_screen

    # Change the color of the glyph based on vi mode
    switch $fish_bind_mode
        case default
            # bryellow is equal to grey???
            set fish_color_prompt bryellow --bold
        case insert
            set fish_color_prompt $fish_color_user
        case visual
            set fish_color_prompt magenta --bold
    end

    set -l glyph "❯"
    echo -ns (set_color $fish_color_prompt) " $glyph " (set_color normal)
end
