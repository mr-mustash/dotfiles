# Check  see if custom colos are already set
if not set -q __pking_init_colors
    # -----------------------------------------------------------------------------
    # universals
    # -----------------------------------------------------------------------------
    set -U fish_color_autosuggestion 555
    set -U fish_color_command 005fd7
    set -U fish_color_comment 990000
    set -U fish_color_cwd cyan
    set -U fish_color_cwd_root magenta
    set -U fish_color_end 009900
    set -U fish_color_error ff0000
    set -U fish_color_escape bryellow --bold
    set -U fish_color_history_current --bold
    set -U fish_color_host blue --bold
    set -U fish_color_match --background=brblue
    set -U fish_color_normal normal
    set -U fish_color_operator bryellow
    set -U fish_color_param 00afff
    set -U fish_color_quote 999900
    set -U fish_color_redirection 00afff
    set -U fish_color_search_match --bold --background=magenta
    set -U fish_color_selection white --bold --background=brblack
    set -U fish_color_user green --bold
    set -U fish_color_valid_path --underline
    set -U fish_pager_color_description B3A06D yellow
    set -U fish_pager_color_prefix white --bold --underline
    set -U fish_pager_color_progress brwhite --background=cyan

    # -----------------------------------------------------------------------------
    # prompt
    # -----------------------------------------------------------------------------

    set -U fish_color_user_root red --bold
    set -U fish_prompt_color_clock blue --bold
    set -U fish_prompt_color_duration $fish_color_autosuggestion --bold
    set -U fish_prompt_color_exit $fish_color_error --bold

    # Branch color
    set -U fish_prompt_color_git_branch magenta --bold

    # Git Status icon colors
    set -U fish_prompt_color_git_untracked red
    set -U fish_prompt_color_git_added green
    set -U fish_prompt_color_git_modified yellow
    set -U fish_prompt_color_git_renamed cyan
    set -U fish_prompt_color_git_deleted red
    set -U fish_prompt_color_git_stashed purple
    set -U fish_prompt_color_git_unmerged red
    set -U fish_prompt_color_git_diverged magenta
    set -U fish_prompt_color_git_ahead magenta
    set -U fish_prompt_color_git_behind magenta
    set -U fish_prompt_color_git_clean green

    # Language icon colors
    set -U fish_prompt_color_golang_icon 89CBDA --bold
    set -U fish_prompt_color_docker_icon 3158E5 --bold
    set -U fish_prompt_color_vim_icon 41913F --bold

    # Number of jobs running in prompt
    set -U fish_prompt_color_jobs yellow --bold

    # Misc
    set -U fish_prompt_color_k8s 3158E5 --bold
    set -U fish_prompt_color_aws FF9900 --bold

    set -gx __pking_init_colours ✓
end

# -----------------------------------------------------------------------------
# LS_COLORS
# -----------------------------------------------------------------------------
set -gx CLICOLOR 1
eval (dircolors -c /Users/pking/.config/terminal/dircolors/dircolors-solarized/dircolors.ansi-dark)

# -----------------------------------------------------------------------------
# iTerm2 Colors
# -----------------------------------------------------------------------------
#
# Setting iTerm tab color based on environment
# https://www.iterm2.com/documentation-escape-codes.html
set uname (uname)

# Reset Terminal for localhost
if test $uname = 'Darwin'
    echo -e "\033]6;1;bg;*;default\a" | tr -d '\n'
end

# First test to see if we're connected to a linux machine
if test $uname = 'Linux'
    if set -q "$environment" == "" ; set -gx environment (hostname -s | awk -F '-' '{print $2}') ; end
    # (These Colors based on Solarized)
    if set -q "$environment" != ""
        switch $environment
        case dev  # Green
            echo -e "\033]6;1;bg;red;brightness;103\a" | tr -d '\n'
            echo -e "\033]6;1;bg;green;brightness;137\a" | tr -d '\n'
            echo -e "\033]6;1;bg;blue;brightness;30\a" | tr -d '\n'
        case staging # Blue
            echo -e "\033]6;1;bg;red;brightness;44\a" | tr -d '\n'
            echo -e "\033]6;1;bg;green;brightness;129\a" | tr -d '\n'
            echo -e "\033]6;1;bg;blue;brightness;168\a" | tr -d '\n'
        case prod # Red
            echo -e "\033]6;1;bg;red;brightness;172\a" | tr -d '\n'
            echo -e "\033]6;1;bg;green;brightness;47\a" | tr -d '\n'
            echo -e "\033]6;1;bg;blue;brightness;53\a" | tr -d '\n'
        case '*' #Magenta
            echo -e "\033]6;1;bg;red;brightness;211\a" | tr -d '\n'
            echo -e "\033]6;1;bg;green;brightness;54\a" | tr -d '\n'
            echo -e "\033]6;1;bg;blue;brightness;130\a" | tr -d '\n'
        end
    end
end
