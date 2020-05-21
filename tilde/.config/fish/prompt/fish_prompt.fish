function fish_prompt --description 'Write out the prompt'
    iterm2_prompt_mark

    __fish_prompt_in_docker #Check first to see if we're in a docker container
    __fish_prompt_username
    __fish_prompt_hostname
    __fish_prompt_pwd

    set -l git_working_tree (command git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$git_working_tree"
        __fish_prompt_git_branch
        __fish_prompt_git_status
        __fish_prompt_git_autofetch
    end

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

    set -l glyph "❯"
    echo -ns (set_color $fish_color_prompt) " $glyph " (set_color normal)

    iterm2_prompt_end
end
