function fish_prompt --description 'Write out the prompt'
    __fish_prompt_in_docker #Check first to see if we're in a docker container
    __fish_prompt_username
    __fish_prompt_hostname
    __fish_prompt_pwd

    __fish_prompt_git

    __fish_prompt_languages
    __fish_prompt_jobs

    # Change the color of the glyph based on vi mode
    switch $fish_bind_mode
        case default
            # bryellow is equal to grey???
            set fish_color_prompt bryellow --bold
        case insert
            # This is different than the yellow that I use
            # for Vim but it's much more aestheticlaly pleasing.
            set fish_color_prompt $fish_color_user
        case visual
            set fish_color_prompt magenta --bold
    end

    function __fish_prompt_git_status_loading_indicator
        echo (set_color brblack)…(set_color normal)
    end

    set -l glyph "❯"
    echo -ns (set_color $fish_color_prompt) " $glyph " (set_color normal)
end
